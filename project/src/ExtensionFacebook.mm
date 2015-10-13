#include "ExtensionFacebook.h"

#include <hx/CFFI.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ExtensionFacebook : NSObject
+ (ExtensionFacebook *)intances;
@end

@interface NMEAppDelegate : NSObject <UIApplicationDelegate>
@end

@implementation ExtensionFacebook
-(id)init {
    self = [super init];
    return self;
}
@end

@implementation NMEAppDelegate (ExtensionFacebook)

-(id)init {
    self = [super init];
    NSLog(@"init delegate");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onApplicationDidLaunchWithOptions:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    return self;
}

- (BOOL)application         : (UIApplication *) application
        openURL             : (NSURL *)url
        sourceApplication   : (NSString *)sourceApplication
        annotation          : (id)annotation
{
    NSLog(@"openUrl");
    return true;
}

-(void)onApplicationDidLaunchWithOptions:(NSNotification *)notification {
    NSLog(@"Finish launching with options");
}

@end



namespace facebookExt {
    
}

extern "C" {

    void facebook_main() {
        val_int(0);
    }
    DEFINE_ENTRY_POINT(facebook_main);
    
    int facebook_register_prims(){return 0;}
}