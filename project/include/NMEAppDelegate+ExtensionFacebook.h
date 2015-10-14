#ifndef NMEAppDelegate_ExtensionFacebook_h
#define NMEAppDelegate_ExtensionFacebook_h

#import <UIKit/UIKit.h>

@interface NMEAppDelegate : NSObject <UIApplicationDelegate>
@end


@interface NMEAppDelegate (ExtensionFacebook)

-(id)init;

-(void)onApplicationDidLaunchWithOptions:(NSNotification *)notification;
-(void)onApplicationDidBecomeActive: (NSNotification *)notification;

@end

#endif