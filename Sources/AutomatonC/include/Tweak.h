#import <AVKit/AVKit.h>
#import <SpringBoard/SpringBoard.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <dispatch/dispatch.h>
#import <libactivator/libactivator.h>
#import <libpowercuts/libpowercuts.h>
#import <notify.h>

@interface NSTask : NSObject

- (void)launch;

- (id)arguments;
- (id)init;
- (void)setArguments:(id)arg1;
- (void)setLaunchPath:(id)arg1;

@end

@interface SBMediaController : NSObject
// https://github.com/ginsudev/Gradi/blob/11e22879f2287380478d48ca93798eb93df204f6/Sources/GradiC/include/Tweak.h
+ (instancetype)sharedInstance;
- (BOOL)isPaused;
- (BOOL)isPlaying;
@end

@interface SBBacklightController
- (void)turnOnScreenFullyWithBacklightSource:(long long)arg0;
@end