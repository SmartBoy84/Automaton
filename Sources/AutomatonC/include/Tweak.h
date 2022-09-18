#import <AVKit/AVKit.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <dispatch/dispatch.h>
#import <libactivator/libactivator.h>
#import <libpowercuts/libpowercuts.h>
#import <notify.h>
#import <objc/runtime.h>

// Set up le interfaces
@interface SpringBoard: UIApplication
+(id)sharedApplication;
-(void)_simulateLockButtonPress;
@end

@interface SBAirplaneModeController : NSObject
+ (id) sharedInstance;
- (void) setInAirplaneMode: (bool) arg0;
- (bool) isInAirplaneMode;
@end

@interface _CDBatterySaver: NSObject
+ (id) sharedInstance;
- (bool) setPowerMode: (long long) arg0 error: (NSString *) arg1;
- (long long) getPowerMode;
@end

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

// Let's get the classes now
id __getSharedApplication(NSString * className) {
     return [objc_getClass([className UTF8String]) sharedApplication];
}

id __getSharedInstance(NSString * className) {
     return [objc_getClass([className UTF8String]) sharedInstance];
}