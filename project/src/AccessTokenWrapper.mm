#include "AccessTokenWrapper.h"

@implementation AccessTokenWrapper : NSObject
@end

namespace facebookExt {
    
    static value getCurrentToken() {
        mAccessToken = [FBSDKAccessToken currentAccessToken];
        
        if(mAccessToken == NULL)
            return alloc_null();
        
        NSString * tokenString = [mAccessToken tokenString];
        
        const char * utfToken = [tokenString UTF8String];
        
        return alloc_string(utfToken);
    }
    
    static value getUserId(){
        NSString * userIdString = [mAccessToken userID];
        
        const char * utfId = [userIdString UTF8String];
        
        return alloc_string(utfId);
    }
    
    static value getIsExpired(){
        
        if(mAccessToken == NULL)
        {
            return alloc_bool(true);
        }
        else
        {
            NSDate * expireDate = [mAccessToken expirationDate];
            NSDate * now = [NSDate date];
            
            NSComparisonResult result = [now compare:expireDate];
            
            if(result == NSOrderedAscending){
                return alloc_bool(true);
            }
            else{
                return alloc_bool(false);
            }
            
        }
            
    }
    
}