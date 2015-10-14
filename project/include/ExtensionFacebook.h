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
    
    static LoginWrapper* mLoginWrapper;
    
    static void init(value haxeInstance);
    static void loginWithReadPermissions(value permissions);
    
}

#endif
