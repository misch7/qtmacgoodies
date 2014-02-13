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
    QIcon networkIcon = MacStandardIcon::icon(MacStandardIcon::Network);

    QWidget foo;
    QPalette pal(foo.palette());
    pal.setColor(QPalette::Background, Qt::blue);
    foo.setAutoFillBackground(true);
    foo.setPalette(pal);

    QPushButton btn("Foobar");
    btn.setFixedSize(300, 200);


    QPushButton btn2("ZapZap");
    btn2.setFixedSize(300, 200);

    w.addPreferencesPanel(generalIcon, "General", &foo);
    w.addPreferencesPanel(accountsIcon, "Accounts", &btn);
    w.addPreferencesPanel(networkIcon, "Network", &btn2);

    w.show();

    return app.exec();
}
