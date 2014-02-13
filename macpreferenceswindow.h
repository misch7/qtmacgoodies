#ifndef MACPREFERENCESWINDOW_H
#define MACPREFERENCESWINDOW_H

#include <QMainWindow>
#include <QIcon>

class MacPreferencesWindowPrivate;
class MacPreferencesWindow : public QMainWindow
{
    Q_OBJECT
    Q_PROPERTY(int currentPanelIndex READ currentPanelIndex WRITE setCurrentPanelIndex)

public:
    explicit MacPreferencesWindow(QWidget *parent = 0);
    ~MacPreferencesWindow();

    void addPreferencesPanel(const QIcon &icon, const QString &title, QWidget *widget);

    int currentPanelIndex() const;
    void setCurrentPanelIndex(int currentPanelIndex);

signals:
private slots:
    void toolButtonClicked();

protected:
    bool event(QEvent *event);

private:
    MacPreferencesWindowPrivate *d;
};

#endif // MACPREFERENCESWINDOW_H
