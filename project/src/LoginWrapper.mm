#include "LoginWrapper.h"

@implementation LoginWrapper

@synthesize mLoginManager;
@synthesize mViewController;

-(id)init {
    self = [super init];
    
    mLoginManager = [[FBSDKLoginManager alloc] init];
    mViewController = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
    
    return self;
}

-(void)loginWithReadPermission:(NSArray *)permissions {
    
    [mLoginManager logInWithReadPermissions:permissions
                fromViewController: mViewController
                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                    if (error) {
                        NSLog(@"Process error");
                    } else if (result.isCancelled) {
                        NSLog(@"Cancelled");
                    } else {
                        NSLog(@"Logged in");
                    }
                }];
    NSLog(@"Yo");
}

@end