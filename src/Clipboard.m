#include <Cocoa/Cocoa.h>
#include <rfb/rfb.h>

#import "Clipboard.h"

@interface Clipboard ()

- (NSString *)readClipboard;
- (void)writeClipboard:(NSString *)text;
- (void)checkClipboard;

@end

@implementation Clipboard

- (instancetype)initWithObject:(rfbScreenInfoPtr)server
                      onChange:(nonnull clipOnChangeProcPtr)onChange {

    if (self = [super init]) {

        _cachedContent = nil;
        _server = server;
        _onChangeProc = onChange;
        _active = FALSE;
        _stopRequested = FALSE;

        [self startMonitoring];
    }
    return self;
}

- (NSString *)readClipboard {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSString *clipboardContent = [pasteboard stringForType:NSPasteboardTypeString];
    return clipboardContent ? clipboardContent : @"";
}

- (void)writeClipboard:(NSString *)text {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard declareTypes:@[NSPasteboardTypeString] owner:nil];
    [pasteboard setString:text forType:NSPasteboardTypeString];
    _cachedContent = [text copy];
}

- (void)checkClipboard {
    NSString *currentClipboardData = [self readClipboard];
    if (![currentClipboardData isEqualToString:_cachedContent]) {
        if (_cachedContent && _onChangeProc) {
            _onChangeProc(currentClipboardData);
        }
        _cachedContent = [currentClipboardData copy];
    }
}
 
- (void)startMonitoring {

    if (_active) return;

    _stopRequested = FALSE;

    dispatch_queue_t clipboardQueue = dispatch_queue_create(NULL, NULL);
 
    dispatch_async(clipboardQueue, ^{
        _active = TRUE;
        while (rfbIsActive(_server) && !_stopRequested) {
            [self checkClipboard];
            usleep(100000);
        }
        _active = FALSE;
    });
}

- (void)stopMonitoring {
    while (_active) {
        _stopRequested = TRUE;
        usleep(100000);
    }
}

- (void)setClipboard:(NSString *)text {
    [self writeClipboard:text];
}

@end
