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
                return alloc_bool(false);
            }
            else{
                return alloc_bool(true);
            }
            
        }
            
    }
    
    static value getPermissions() {
        if(mAccessToken == NULL)
            return alloc_string("");
        else {
            NSSet * permissions = [mAccessToken permissions];
            NSMutableArray* perms = [[NSMutableArray alloc] init];
            for(NSString* perm in permissions)
                [perms addObject:perm];
            
            NSString* rep = [perms componentsJoinedByString:@","];
            
            const char * utfRep = [rep UTF8String];
            return alloc_string(utfRep);
        }
    }
    
    static value getDeclinedPermissions() {
        if(mAccessToken == NULL)
            return alloc_string("");
        else {
            NSSet* declinedPermissions = [mAccessToken declinedPermissions];
            NSMutableArray* declinedPerms = [[NSMutableArray alloc] init];
            for(NSString* perm in declinedPermissions)
                [declinedPerms addObject:perm];
            
            NSString * rep = [declinedPerms componentsJoinedByString:@","];
            
            const char * utfRep = [rep UTF8String];
            return alloc_string(utfRep);
        }
    }
    
}