#import <Foundation/Foundation.h>
#include <rfb/rfb.h>

typedef void (^clipOnChangeProcPtr) (NSString * _Nonnull text);

@interface Clipboard : NSObject {
    NSString *_cachedContent;
    rfbScreenInfoPtr _server;
    clipOnChangeProcPtr _onChangeProc;
    rfbBool _active;
    rfbBool _stopRequested;
}

- (_Nonnull instancetype)initWithObject:(nonnull rfbScreenInfoPtr)server
                               onChange:(nonnull clipOnChangeProcPtr)onChange;

- (void)setClipboard:(NSString * _Nonnull)text;

- (void)startMonitoring;
- (void)stopMonitoring;

@end
