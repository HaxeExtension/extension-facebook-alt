#include "ExtensionFacebook.h"

namespace facebookExt {
    
    static void init(value haxeInstance){
        mLoginWrapper = [[LoginWrapper alloc] init];
    }
    DEFINE_PRIM(init, 1);
    
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