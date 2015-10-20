#include "LoginWrapper.h"

// if I don't add those line , prim are not found!
@implementation LoginWrapper : NSObject
@end

namespace facebookExt {
    
    static void initLogin(value onLoginSucess, value onLoginFail, value onLoginCancel){
        if(onLoginSucess != NULL)
            loginSuccessCb = new AutoGCRoot(onLoginSucess);
        
        if(onLoginFail != NULL)
            loginFailCb = new AutoGCRoot(onLoginFail);
        
        if(onLoginCancel != NULL)
            loginCancelCb = new AutoGCRoot(onLoginCancel);
        
        mLoginManager = [[FBSDKLoginManager alloc] init];
        mViewController = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
    }
    
    static void loginWithReadPermissions(value permissions){
        const char* perms = val_string(permissions);
        
        NSString* str = [[NSString alloc] initWithUTF8String:perms];
        NSArray* arr = [str componentsSeparatedByString:@","];
        
        [mLoginManager logInWithReadPermissions:arr
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
    
    static void loginWithPublishPermissions(value permissions){
        const char* perms = val_string(permissions);
        
        NSString* str = [[NSString alloc] initWithUTF8String:perms];
        NSArray* arr = [str componentsSeparatedByString:@","];
        
        [mLoginManager logInWithPublishPermissions:arr
                                fromViewController:mViewController
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
    
    static void logOut(){
        [mLoginManager logOut];
    }
    
}