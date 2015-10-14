#include "NMEAppDelegate+ExtensionFacebook.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>


@implementation NMEAppDelegate (ExtensionFacebook)

-(id)init {
    self = [super init];

    //didFinishLaunchingWithOptions
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApplicationDidLaunchWithOptions:)
                                                 name:UIApplicationDidFinishLaunchingNotification object:nil];
    
    //didBecomeActive
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApplicationDidBecomeActive:)
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

-(void)onApplicationDidLaunchWithOptions:(NSNotification *)notification {
    NSDictionary* options = [notification userInfo];
    UIApplication* application = [UIApplication sharedApplication];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:options];
}

-(void)onApplicationDidBecomeActive: (NSNotification *)notification {
    [FBSDKAppEvents activateApp];
}
@end