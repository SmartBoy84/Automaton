#import <libpowercuts/libpowercuts.h>
#import "Actions.h"

@interface PlayerState : PCAction
@end
@implementation PlayerState
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

NSDictionary *screenModes = @{
  @"Allow": @YES,
  @"Prevent": @NO
};

NSString *wakeKey = @"state";

@interface RequestWakePrevention : PCAction
@end
@implementation RequestWakePrevention
-(void) performActionForIdentifier:(NSString*)identifier withParameters:(NSDictionary*)parameters success:(void (^)(id _Nullable output))success fail:(void (^)(NSString *error))fail {
    if ([[screenModes allKeys] containsObject:parameters[wakeKey]]) {
        setToken(screenModes[parameters[wakeKey]]);
        success(NULL);
    }
    else{
        fail(@"Incorrect parameters for 'prevent wake'");
    }
}

-(NSString*) nameForIdentifier:(NSString*)identifier {
    return @"Prevent wake";
}

-(NSString*) descriptionSummaryForIdentifier:(NSString*)identifier {
    return @"Disable/enable screen wake";
}

-(NSArray*) parametersDefinitionForIdentifier:(NSString*)identifier {
    return @[
        @{
            @"type" : @"enum",
            @"key" : wakeKey,
            @"placeholder": @"Enable"
        }
    ];
}
-(NSString*) parameterSummaryForIdentifier:(NSString*)identifier {
    return [NSString stringWithFormat:@"${%@} screen wakeup", wakeKey];
}
@end

%ctor {
    [[PowercutsManager sharedInstance] registerActionWithIdentifier:@"com.barfie.automaton.action.playerState" action:[PlayerState new]];
    [[PowercutsManager sharedInstance] registerActionWithIdentifier:@"com.barfie.automaton.action.requestWakePrevention" action:[RequestWakePrevention new]];
}