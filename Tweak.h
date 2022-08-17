@interface SpringBoard : UIApplication
- (void) _simulateLockButtonPress;
- (void) _simulateHomeButtonPress;
- (void) reverieSleep;
- (void) reverieWake;
- (double) getCurrentBattery;
@end