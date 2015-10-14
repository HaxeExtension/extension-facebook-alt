#include "ExtensionFacebook.h"

namespace facebookExt {
    
    static void initLogin(value onLoginSucess, value onLoginFail, value onLoginCancel){
        if(onLoginSucess != NULL)
            loginSuccessCb = new AutoGCRoot(onLoginSucess);
        
        if(onLoginFail != NULL)
            loginFailCb = new AutoGCRoot(onLoginFail);
        
        if(onLoginCancel != NULL)
            loginCancelCb = new AutoGCRoot(onLoginCancel);
        
        mLoginWrapper = [[LoginWrapper alloc] init];
    }
    DEFINE_PRIM(initLogin, 3);
    
    static void loginWithReadPermissions(value permissions){
        const char* perms = val_string(permissions);
        
        NSString* str = [[NSString alloc] initWithUTF8String:perms];
        NSArray* arr = [str componentsSeparatedByString:@","];
        
        [mLoginWrapper loginWithReadPermission: arr];
    }
    DEFINE_PRIM(loginWithReadPermissions, 1);
    
}

extern "C" {

    void facebook_main() {
        val_int(0);
    }
    DEFINE_ENTRY_POINT(facebook_main);
    
    int facebook_register_prims(){return 0;}
}