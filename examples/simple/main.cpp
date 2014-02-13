#include <QApplication>
#include <QtWidgets>

#include "macpreferenceswindow.h"
#include "macstandardicon.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setAttribute(Qt::AA_UseHighDpiPixmaps);

    MacPreferencesWindow w;

    QIcon generalIcon = MacStandardIcon::icon(MacStandardIcon::PreferencesGeneral);
    QIcon accountsIcon = MacStandardIcon::icon(MacStandardIcon::UserAccounts);
    QIcon quickLookIcon = MacStandardIcon::icon(MacStandardIcon::QuickLookTemplate);

    QWidget foo;
    QPalette pal(foo.palette());
    pal.setColor(QPalette::Background, Qt::blue);
    foo.setAutoFillBackground(true);
    foo.setPalette(pal);

    QPushButton btn("Foobar");
    btn.setFixedSize(300, 200);

    QSize maxIconSize;
    QList<QIcon> icons;
    for (int i = 0; i < (int)MacStandardIcon::LastIcon; ++i) {
        MacStandardIcon::MacStandardIconType iconType = (MacStandardIcon::MacStandardIconType)i;
        QIcon icon = MacStandardIcon::icon(iconType);
        icons.append(icon);

        foreach (const QSize &size, icon.availableSizes()) {
            if (size.width() > maxIconSize.width())
                maxIconSize = size;
        }
    }
    QListWidget iconListWidget;
    iconListWidget.setIconSize(maxIconSize);
    iconListWidget.setResizeMode(QListWidget::Adjust);
    iconListWidget.setViewMode(QListWidget::IconMode);
    for (int i = 0; i < (int)MacStandardIcon::LastIcon; ++i) {
        MacStandardIcon::MacStandardIconType iconType = (MacStandardIcon::MacStandardIconType)i;
        QIcon icon = MacStandardIcon::icon(iconType);
        QListWidgetItem *item = new QListWidgetItem(icon, QString());
        iconListWidget.addItem(item);
    }

    w.addPreferencesPanel(generalIcon, "General", &foo);
    w.addPreferencesPanel(accountsIcon, "Accounts", &btn);
    w.addPreferencesPanel(quickLookIcon, "Network", &iconListWidget);

    w.show();

    return app.exec();
}
