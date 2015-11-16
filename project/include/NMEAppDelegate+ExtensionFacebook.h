#ifndef NME_APP_DELEGATE_EXTENSION_FACEBOOK_H
#define NME_APP_DELEGATE_EXTENSION_FACEBOOK_H

#import <UIKit/UIKit.h>

@interface NMEAppDelegate : NSObject <UIApplicationDelegate>

@end


@interface NMEAppDelegate (ExtensionFacebook)

-(id)init;

-(void)onApplicationDidBecomeActive: (NSNotification *)notification;
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

#endif