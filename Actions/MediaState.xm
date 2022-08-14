#import <libpowercuts/libpowercuts.h>
#import "MediaState.h"

@interface SimpleExampleAction : PCAction
@end
@implementation SimpleExampleAction
-(void) performActionForIdentifier:(NSString*)identifier withParameters:(NSDictionary*)parameters success:(void (^)(id _Nullable output))success fail:(void (^)(NSString *error))fail
{    
    SBMediaController *mediaController = [%c(SBMediaController) sharedInstance];
    success(@([mediaController isPaused] ? "1" : [mediaController isPlaying] ? "2" : "3"));
}

-(NSString*) nameForIdentifier:(NSString*)identifier {
    return @"Get player state";
}

-(NSString*) descriptionSummaryForIdentifier:(NSString*)identifier {
    return @"Returns media player state (paused/playing)";
}

-(NSDictionary*) outputDefinitionForIdentifier:(NSString*)identifier {
    return @{
        @"type" : @"number",
        @"name" : @"Playing state"
    };
}
@end

%ctor {
    [[PowercutsManager sharedInstance] registerActionWithIdentifier:@"com.anthopak.powercuts.action.mediaState" action:[SimpleExampleAction new]];
}