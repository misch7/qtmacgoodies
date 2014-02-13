#include "macpreferenceswindow.h"
#include <QApplication>
#include <QtWidgets>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    MacPreferencesWindow w;

    QIcon icon("/Applications//iBooks.app/Contents/PlugIns/iBAReaderKit.bundle/Contents/Resources/play-small-64-P.png");
    QWidget foo;
    QPalette pal(foo.palette());
    pal.setColor(QPalette::Background, Qt::blue);
    foo.setAutoFillBackground(true);
    foo.setPalette(pal);

    QPushButton btn("Foobar");
    btn.setFixedSize(300, 200);

    w.addPreferencesPanel(icon, "General", &foo);
    w.addPreferencesPanel(icon, "Accounts", &btn);

    w.show();

    return a.exec();
}
