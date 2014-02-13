#include "macstandardicon.h"

#include <QtMacExtras>
#include <QDebug>

#import <Cocoa/Cocoa.h>

static NSString *macIconNames[] = {

    NSImageNameQuickLookTemplate,
    NSImageNameBluetoothTemplate,
    NSImageNameIChatTheaterTemplate,
    NSImageNameSlideshowTemplate,
    NSImageNameActionTemplate,
    NSImageNameSmartBadgeTemplate,
    NSImageNameIconViewTemplate,
    NSImageNameListViewTemplate,
    NSImageNameColumnViewTemplate,
    NSImageNameFlowViewTemplate,
    NSImageNamePathTemplate,
    NSImageNameInvalidDataFreestandingTemplate,
    NSImageNameLockLockedTemplate,
    NSImageNameLockUnlockedTemplate,
    NSImageNameGoRightTemplate,
    NSImageNameGoLeftTemplate,
    NSImageNameRightFacingTriangleTemplate,
    NSImageNameLeftFacingTriangleTemplate,
    NSImageNameAddTemplate,
    NSImageNameRemoveTemplate,
    NSImageNameRevealFreestandingTemplate,
    NSImageNameFollowLinkFreestandingTemplate,
    NSImageNameEnterFullScreenTemplate,
    NSImageNameExitFullScreenTemplate,
    NSImageNameStopProgressTemplate,
    NSImageNameStopProgressFreestandingTemplate,
    NSImageNameRefreshTemplate,
    NSImageNameRefreshFreestandingTemplate,
    NSImageNameBonjour,
    NSImageNameComputer,
    NSImageNameFolderBurnable,
    NSImageNameFolderSmart,
    NSImageNameFolder,
    NSImageNameNetwork,
    NSImageNameDotMac,
    NSImageNameMobileMe,
    NSImageNameMultipleDocuments,
    NSImageNameUserAccounts,
    NSImageNamePreferencesGeneral,
    NSImageNameAdvanced,
    NSImageNameInfo,
    NSImageNameFontPanel,
    NSImageNameColorPanel,
    NSImageNameUser,
    NSImageNameUserGroup,
    NSImageNameEveryone,
    NSImageNameUserGuest,
    NSImageNameMenuOnStateTemplate,
    NSImageNameMenuMixedStateTemplate,
    NSImageNameApplicationIcon,
    NSImageNameTrashEmpty,
    NSImageNameTrashFull,
    NSImageNameHomeTemplate,
    NSImageNameBookmarksTemplate,
    NSImageNameCaution,
    NSImageNameStatusAvailable,
    NSImageNameStatusPartiallyAvailable,
    NSImageNameStatusUnavailable,
    NSImageNameStatusNone,
    NSImageNameShareTemplate,

    nil
};

QIcon MacStandardIcon::icon(MacStandardIconType icon)
{
    NSImage *image = [NSImage imageNamed:macIconNames[icon]];

    QList<NSRect> desiredRects;

    NSRect imageRect = NSMakeRect(0, 0, image.size.width, image.size.height);
    desiredRects.append(imageRect);
    while (imageRect.size.width > 32) {
        imageRect.size.width /= 2;
        imageRect.size.height /= 2;
        desiredRects.append(imageRect);
    }

    QIcon result;

    foreach (NSRect rect, desiredRects) {
        CGImageRef cgimage = [image CGImageForProposedRect:&rect context:nil hints:nil];
        QPixmap pixmap = QtMac::fromCGImageRef(cgimage);
        CFRelease(cgimage);

        result.addPixmap(pixmap);
    }

    return result;
}
