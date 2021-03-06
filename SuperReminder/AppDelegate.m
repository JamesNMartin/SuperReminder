//
//  AppDelegate.m
//  SuperReminder
//
//  Created by James Martin on 2/8/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import "AppDelegate.h"
//#import <IQKeyboardManager.h>
//#import <IQUIView+IQKeyboardToolbar.h>
//#import <IQUITextFieldView+Additions.h>
#import <Chameleon.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Fabric with:@[[Crashlytics class]]];
    
    
    /* THIS FOR SOME REASON IS NO LONGER WORKING. BUTTON APPEAR TO BE INVISABLE.
    [[IQKeyboardManager sharedManager] setToolbarTintColor:FlatNavyBlueDark];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:800];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    */
    
    
    
    
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00]}];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : FlatWhite}];
    
//    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
//                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
//                              if (!error) {
//                                  NSLog(@"request authorization succeeded!");
//                              }
//                          }];
    
    
//    UITextField *lagFreeField = [[UITextField alloc] init];
//    [self.window addSubview:lagFreeField];
//    [lagFreeField becomeFirstResponder];
//    [lagFreeField resignFirstResponder];
//    [lagFreeField removeFromSuperview];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
