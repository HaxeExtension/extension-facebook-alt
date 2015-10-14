#include "LoginWrapper.h"
#include "ExtensionFacebook.h"

#include <hx/CFFI.h>

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
                        NSString * errorString = [error localizedDescription];
                        const char * errorChar = [errorString UTF8String];
                        val_call1(facebookExt::loginFailCb->get(), alloc_string(errorChar));
                    } else if (result.isCancelled) {
                        val_call0(facebookExt::loginCancelCb->get());
                    } else {
                        val_call0(facebookExt::loginSuccessCb->get());
                    }
                }];
}

@end