#include "SDLUIKitDelegate+ExtensionFacebook.h"

#import <objc/runtime.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation SDLUIKitDelegate (ExtensionFacebook)

-(id)init {
    self = [super init];
    
    NSLog(@"init category");
    
    //didBecomeActive
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onApplicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    return self;
}

- (BOOL)application         : (UIApplication *) application
        openURL             : (NSURL *)url
        sourceApplication   : (NSString *)sourceApplication
        annotation          : (id)annotation
{
    return [[FBSDKApplicationDelegate sharedInstance] application: application
            openURL: url
            sourceApplication:sourceApplication
            annotation:annotation];
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *) launchOptions
{
    return [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

-(void)onApplicationDidBecomeActive: (NSNotification *)notification {
    [FBSDKAppEvents activateApp];
}
 
@end