#ifndef SDL_APP_DELEGATE_EXTENSION_FACEBOOK_H
#define SDL_APP_DELEGATE_EXTENSION_FACEBOOK_H

#import <UIKit/UIKit.h>

@interface SDLUIKitDelegate : NSObject <UIApplicationDelegate>

@end


@interface SDLUIKitDelegate (ExtensionFacebook)

-(id)init;

-(void)onApplicationDidBecomeActive: (NSNotification *)notification;
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

#endif