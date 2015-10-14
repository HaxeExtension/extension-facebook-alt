#ifndef LoginWrapper_h
#define LoginWrapper_h

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginWrapper : NSObject

@property(assign) FBSDKLoginManager * mLoginManager;
@property(assign) UIViewController * mViewController;

-(id)init;
-(void)loginWithReadPermission:(NSArray *)permissions;

@end

#endif