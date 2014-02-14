#include "macpreferenceswindow.h"

#include <QVBoxLayout>
#include <QToolBar>
#include <QAction>
#include <QEvent>
#include <QWindow>
#include <QDebug>

#import <Cocoa/Cocoa.h>

struct PanelInfo
{
    PanelInfo(QAction *a, QWidget *p)
        : action(a), panel(p), windowSize(NSMakeSize(0, 0))
    { }

    QAction *action;
    QWidget *panel;
    NSSize windowSize;
};

class MacPreferencesWindowPrivate
{
public:
    MacPreferencesWindowPrivate(MacPreferencesWindow *q)
      : q(q), toolbar(0), currentPanelIndex(0)
    { }

    void displayPanel(int panelIndex);
    QSize guesstimateSizeHint(QWidget *w);
    bool isResizable(QWidget *w);
    QSize windowSizeForPanel(int panelIndex);

    MacPreferencesWindow *q;

    QVBoxLayout *layout;
    QToolBar *toolbar;
    QList<PanelInfo> panels;
    int currentPanelIndex;
};

MacPreferencesWindow::MacPreferencesWindow(QWidget *parent)
    : QMainWindow(parent), d(new MacPreferencesWindowPrivate(this))
{
    setWindowFlags(windowFlags() & ~Qt::WindowFullscreenButtonHint);
    setUnifiedTitleAndToolBarOnMac(true);

    QWidget *centralWidget = new QWidget;
    d->layout = new QVBoxLayout(centralWidget);
    d->layout->setContentsMargins(0, 0, 0, 0);
    setCentralWidget(centralWidget);

    d->toolbar = addToolBar("maintoolbar");
    d->toolbar->setMovable(false);
    d->toolbar->setIconSize(QSize(32, 32));
    d->toolbar->setToolButtonStyle(Qt::ToolButtonTextUnderIcon);
}

MacPreferencesWindow::~MacPreferencesWindow()
{
    delete d;
}

void MacPreferencesWindow::addPreferencesPanel(const QIcon &icon, const QString &title, QWidget *widget)
{
    QAction *action = d->toolbar->addAction(icon, title);

    action->setCheckable(true);
    connect(action, SIGNAL(triggered(bool)), this, SLOT(toolButtonClicked()));

    d->panels.append(PanelInfo(action, widget));
}

int MacPreferencesWindow::currentPanelIndex() const
{
    return d->currentPanelIndex;
}

void MacPreferencesWindow::setCurrentPanelIndex(int panelIndex)
{
    if (d->currentPanelIndex == panelIndex)
        return;

    if (panelIndex < 0 || panelIndex >= d->panels.size())
        return;

    d->displayPanel(panelIndex);
}

QSize MacPreferencesWindowPrivate::guesstimateSizeHint(QWidget *w)
{
    if (w->minimumSize() == w->maximumSize())
        return w->minimumSize();
    return w->sizeHint();
}

bool MacPreferencesWindowPrivate::isResizable(QWidget *w)
{
    return w->minimumSize() != w->maximumSize();
}

QSize MacPreferencesWindowPrivate::windowSizeForPanel(int panelIndex)
{
    const PanelInfo &panelInfo = panels[panelIndex];
    QSize size = QSize(panelInfo.windowSize.width, panelInfo.windowSize.height);
    if (size.width() == 0 || size.height() == 0) {
        QSize panelSize = q->sizeHintForPanel(panelIndex);
        size = QSize(panelSize.width(), panelSize.height() + toolbar->size().height());
    }
    return size;
}

void MacPreferencesWindowPrivate::displayPanel(int panelIndex)
{
    PanelInfo &oldPanel = panels[currentPanelIndex];
    PanelInfo &newPanel = panels[panelIndex];

    bool isUpdatingTheAlreadyVisiblePanel = panelIndex == currentPanelIndex;

    currentPanelIndex = panelIndex;

    NSView *view = reinterpret_cast<NSView *>(q->effectiveWinId());
    NSRect frame = view.window.frame;

    static const int TitlebarHeight = 22;

    if (!isUpdatingTheAlreadyVisiblePanel) {
        oldPanel.action->setChecked(false);

        oldPanel.panel->hide();
        layout->removeWidget(oldPanel.panel);

        oldPanel.windowSize = frame.size;
        // sigh. Ugly. Workaround. The titlebar height is included into the frame, which is fine, but Qt expects
        oldPanel.windowSize.height -= TitlebarHeight;
    }

    newPanel.action->setChecked(true);

    QSize newSize = windowSizeForPanel(panelIndex);
    NSPoint topLeft = NSMakePoint(frame.origin.x, frame.origin.y + frame.size.height);
    NSRect newFrame = NSMakeRect(topLeft.x, topLeft.y - (newSize.height()+TitlebarHeight),
                                 newSize.width(), newSize.height()+TitlebarHeight);
    [view.window setFrame:newFrame display:YES animate:YES];

    if (isResizable(newPanel.panel)) {
        q->setMinimumSize(QSize(0, 0));
        q->setMaximumSize(QSize(QWIDGETSIZE_MAX, QWIDGETSIZE_MAX));
    } else {
        q->setFixedSize(QSize(newSize.width(), newSize.height()));
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        layout->addWidget(newPanel.panel);
         newPanel.panel->show();
    });
}

void MacPreferencesWindow::toolButtonClicked()
{
    QAction *action = qobject_cast<QAction *>(sender());
    Q_ASSERT(action);

    action->setChecked(true);

    int panelIndex = 0;
    for (int i = 0; i < d->panels.size(); ++i) {
        const PanelInfo &panel = d->panels[i];
        if (panel.action == action) {
            panelIndex = i;
            break;
        }
    }

    setCurrentPanelIndex(panelIndex);

    emit activated(panelIndex);
}

bool MacPreferencesWindow::event(QEvent *event)
{
    switch (event->type()) {
    case QEvent::Show:
        d->displayPanel(d->currentPanelIndex);
        break;
    default:
        break;
    }

    return QMainWindow::event(event);
}

void MacPreferencesWindow::setVisible(bool visible)
{
    if (d->currentPanelIndex < d->panels.size()) {
        const PanelInfo &panelInfo = d->panels[d->currentPanelIndex];
        if (!d->isResizable(panelInfo.panel)) {
            QSize size = d->windowSizeForPanel(d->currentPanelIndex);
            setFixedSize(QSize(size.width(), size.height()-22));
        }
    }
    QMainWindow::setVisible(visible);
}

QSize MacPreferencesWindow::sizeHintForPanel(int panelIndex)
{
    Q_ASSERT(panelIndex >= 0 && panelIndex < d->panels.size());
    const PanelInfo &panelInfo = d->panels[panelIndex];
    return d->guesstimateSizeHint(panelInfo.panel);
}
