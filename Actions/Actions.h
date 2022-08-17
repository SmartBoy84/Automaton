#import "../Globals.h"

@interface SBMediaController
+ (id)sharedInstance;
- (BOOL)isPaused;
- (BOOL)isPlaying;
@end