#ifndef MAC_STANDARD_ICON_H
#define MAC_STANDARD_ICON_H

#include <QIcon>

//
// NOTE: to make use of retina resolution icons don't forget to set application attribute:
// qapp.setAttribute(Qt::AA_UseHighDpiPixmaps);
//
class MacStandardIcon
{
public:
    enum MacStandardIconType{
        QuickLookTemplate,
        BluetoothTemplate,
        IChatTheaterTemplate,
        SlideshowTemplate,
        ActionTemplate,
        SmartBadgeTemplate,
        IconViewTemplate,
        ListViewTemplate,
        ColumnViewTemplate,
        FlowViewTemplate,
        PathTemplate,
        InvalidDataFreestandingTemplate,
        LockLockedTemplate,
        LockUnlockedTemplate,
        GoRightTemplate,
        GoLeftTemplate,
        RightFacingTriangleTemplate,
        LeftFacingTriangleTemplate,
        AddTemplate,
        RemoveTemplate,
        RevealFreestandingTemplate,
        FollowLinkFreestandingTemplate,
        EnterFullScreenTemplate,
        ExitFullScreenTemplate,
        StopProgressTemplate,
        StopProgressFreestandingTemplate,
        RefreshTemplate,
        RefreshFreestandingTemplate,
        Bonjour,
        Computer,
        FolderBurnable,
        FolderSmart,
        Folder,
        Network,
        DotMac, // informally deprecated
        MobileMe,
        MultipleDocuments,
        UserAccounts,
        PreferencesGeneral,
        Advanced,
        Info,
        FontPanel,
        ColorPanel,
        User,
        UserGroup,
        Everyone,
        UserGuest,
        MenuOnStateTemplate,
        MenuMixedStateTemplate,
        ApplicationIcon,
        TrashEmpty,
        TrashFull,
        HomeTemplate,
        BookmarksTemplate,
        Caution,
        StatusAvailable,
        StatusPartiallyAvailable,
        StatusUnavailable,
        StatusNone,
        ShareTemplate,

        LastIcon = ShareTemplate
    };

    static QIcon icon(MacStandardIconType icon);
};

#endif // MAC_STANDARD_ICON_H
