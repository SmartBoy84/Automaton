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

NSArray *screenModes = @[
  @"Allow",
  @"Prevent"
];

NSString *wakeKey = @"State";
NSString *maxWake = @"Max preventions";

@interface RequestWakePrevention : PCAction
@end
@implementation RequestWakePrevention
-(void) performActionForIdentifier:(NSString*)identifier withParameters:(NSDictionary*)parameters success:(void (^)(id _Nullable output))success fail:(void (^)(NSString *error))fail {
    
        if ([screenModes indexOfObject:parameters[wakeKey]] == 0){
            setToken(0);
            success(NULL);
            return;
        }

        else if ([screenModes indexOfObject:parameters[wakeKey]] == 1 && [parameters[maxWake] integerValue] > 0){
            setToken([parameters[maxWake] integerValue]);
            success(NULL);
            return;
        }
    
    fail(@"Incorrect parameters for 'prevent wake'");
}

-(NSString*) nameForIdentifier:(NSString*)identifier {
    return @"Disable/enable screen wakeup";
}

-(NSString*) descriptionSummaryForIdentifier:(NSString*)identifier {
    return @"Disable/enable screen wake";
}

-(NSArray*) parametersDefinitionForIdentifier:(NSString*)identifier {
    return @[
        @{
            @"type" : @"enum",
            @"key" : wakeKey,
            @"defaultValue": @"Prevent",
            @"items" : @[@"Allow", @"Prevent"]
        },
        @{
            @"type" : @"number",
            @"key" : maxWake,
            @"label" : maxWake,
            @"allowsDecimalNumbers" : @(NO),
            @"allowsNegativeNumbers" : @(NO),
            @"defaultValue" : @(1),
            @"condition" : @{
                @"key" : wakeKey,
                @"value" : @"Prevent"
            }
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
