//
//  ExtensionFacebook.h
//  DevExtensionFacebook
//
//  Created by thomas baudon on 05/10/2015.
//  Copyright (c) 2015 thomas baudon. All rights reserved.
//

#ifndef ExtensionFacebook_h
#define ExtensionFacebook_h

#include <hx/CFFI.h>

#include "LoginWrapper.h"

namespace facebookExt {
    
    LoginWrapper* mLoginWrapper;
    
    AutoGCRoot* loginSuccessCb = 0;
    AutoGCRoot* loginFailCb = 0;
    AutoGCRoot* loginCancelCb = 0;
    
    static void initLogin(value onLoginSucess, value onLoginFail, value onLoginCancel);
    static void loginWithReadPermissions(value permissions);
    
}

#endif
