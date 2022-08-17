#include <dispatch/dispatch.h>
#import <libactivator/libactivator.h>
#import <Foundation/Foundation.h>

#define LASendEventWithName(eventName) \
	[LASharedActivator sendEventToListener:[LAEvent eventWithName:eventName mode:[LASharedActivator currentEventMode]]]

static NSString *pausedetector_eventName = @"PauseDetector";

@interface eventtestDataSource : NSObject <LAEventDataSource>

+ (instancetype)sharedInstance;

@end

@implementation eventtestDataSource

+ (instancetype)sharedInstance {
	static eventtestDataSource * sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
	});
	return sharedInstance;
}

+ (void)load {
	[self sharedInstance];
}

- (id)init {
	if ((self = [super init])) {
		// Register our event
		if (LASharedActivator.isRunningInsideSpringBoard) {
			[LASharedActivator registerEventDataSource:self forEventName:pausedetector_eventName];
		}
	}
	return self;
}

- (void)dealloc {
	if (LASharedActivator.isRunningInsideSpringBoard) {
		[LASharedActivator unregisterEventDataSourceWithEventName:pausedetector_eventName];
	}
}

- (NSString *)localizedTitleForEventName:(NSString *)eventName {
	return @"Media playback toggled";
}

- (NSString *)localizedGroupForEventName:(NSString *)eventName {
	return @"Media playback";
}

- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
	return @"Fires when user pauses/unpauses media playback";
}

- (BOOL)eventWithName:(NSString *)eventName isCompatibleWithMode:(NSString *)eventMode {
	return YES;
}

@end

////////////////////////////////////////////////////////////////

%hook SBMediaController
-(void)_mediaRemoteNowPlayingApplicationIsPlayingDidChange:(id)arg1 {
    %orig;
    LASendEventWithName(pausedetector_eventName);
    // NSLog(@"[pausedetector] media was [un]paused");
}
%end
