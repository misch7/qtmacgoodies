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
    QIcon quickLookIcon = MacStandardIcon::icon(MacStandardIcon::Info);

    QLabel blueWidget("Note: the window has fixed size");
    blueWidget.setAlignment(Qt::AlignCenter);
    blueWidget.setFixedSize(300, 150);

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

    QWidget iconsWidget;
    QVBoxLayout *layout = new QVBoxLayout(&iconsWidget);
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
    QLabel iconsWidgetLabel("Note: the window is resizable");
    layout->addWidget(&iconListWidget);
    layout->addWidget(&iconsWidgetLabel);

    w.addPreferencesPanel(generalIcon, "General", &blueWidget);
    w.addPreferencesPanel(quickLookIcon, "Icons", &iconsWidget);

    w.show();

    return app.exec();
}
