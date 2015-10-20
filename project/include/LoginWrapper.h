#ifndef LoginWrapper_h
#define LoginWrapper_h

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#include <hx/CFFI.h>

@interface LoginWrapper : NSObject
@end

namespace facebookExt {
    
    FBSDKLoginManager* mLoginManager;
    UIViewController* mViewController;
    
    AutoGCRoot* loginSuccessCb = 0;
    AutoGCRoot* loginFailCb = 0;
    AutoGCRoot* loginCancelCb = 0;
    
    static void initLogin(value onLoginSucess, value onLoginFail, value onLoginCancel);
    static void loginWithReadPermissions(value permissions);
    static void loginWithPublishPermissions(value permissions);
    static void logOut();
    
    DEFINE_PRIM(initLogin, 3);
    DEFINE_PRIM(loginWithReadPermissions, 1);
    DEFINE_PRIM(loginWithPublishPermissions, 1);
    DEFINE_PRIM(logOut, 0);

}

#endif