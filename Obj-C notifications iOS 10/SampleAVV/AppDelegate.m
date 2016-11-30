//
//  AppDelegate.m
//  TemplateAVV
//
//  Created by Anita Vasilieva on 14/11/2016.
//  Copyright © 2016 avv. All rights reserved.
//

#import "AppDelegate.h"
#import "NotificationsManager.h"
#import "Constants.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NotificationsManager sharedInstance];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[NotificationsManager sharedInstance] presentNotification: @"Tap to go to the app" :nil :connectedNotificationCategoryId : @"notificationIdentificator"];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NotificationsManager sharedInstance] removeAllNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
