//
//  NotificationsManager.m
//  TemplateAVV
//
//  Created by Anita Vasilieva on 15/11/2016.
//  Copyright © 2016 avv. All rights reserved.
//

#import "NotificationsManager.h"
#import "Constants.h"

@implementation NotificationsManager

- (instancetype)init
{
    NSLog(@"NotificationsManager::init");
    self = [super init];
    if (self)
    {
        [self configureUserNotifications];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static NotificationsManager* sharedInstance;
    dispatch_once(&once,
                  ^{
                      sharedInstance = [[self alloc] init];
                  });
    return sharedInstance;
}

- (void)configureUserNotifications {
    if (SYSTEM_VERSION_GE(systemVersion10)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNNotificationAction *action =
        [UNNotificationAction actionWithIdentifier:actionIdentifier
                                             title:actionTitle
                                           options:UNNotificationActionOptionForeground];
        NSArray *notificationActions = @[action];
        
        UNNotificationCategory *notificationCategory =
        [UNNotificationCategory categoryWithIdentifier:connectedNotificationCategoryId
                                               actions:notificationActions
                                     intentIdentifiers:@[]
                                               options:UNNotificationCategoryOptionCustomDismissAction];
        
        NSSet *categories = [NSSet setWithObjects:notificationCategory, nil];
        [center setNotificationCategories:categories];
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
             if (!error)
             {
                 NSLog(@"NotificationsManager::configureUserNotifications: succeed");
             }
             else
             {
                 NSLog(@"NotificationsManager::configureUserNotifications: failed. Suggestions: %s",
                       [error.localizedRecoverySuggestion UTF8String]);
             }
         }];
    }
    else
    {
        NSLog(@"NotificationsManager::configureUserNotifications for pre-iOS 10 is not implemented");
    }
}

- (void)presentNotification:(NSString *)bodyStr :(NSDictionary *)userInfo :(NSString *)categoryID :(NSString *)requestID
{
    if (!bodyStr || !categoryID || !requestID)
    {
        NSLog(@"NotificationsManager::presentNotification is called with wrong arguments");
        return;
    }
    if (SYSTEM_VERSION_GE(systemVersion10))
    {
        UNMutableNotificationContent* notification = [[UNMutableNotificationContent alloc] init];
        if (notification)
        {
            notification.body = bodyStr;
            notification.categoryIdentifier = categoryID;
            notification.userInfo = userInfo;
            // Fire in 30 minutes (60 seconds times 30)
            UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                          triggerWithTimeInterval:2.0 repeats: NO];
            
            UNNotificationRequest* request =
                            [UNNotificationRequest requestWithIdentifier:requestID
                                                                 content:notification
                                                                 trigger:trigger];
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error)
             {
                 if (!error)
                 {
                     NSLog(@"NotificationsManager::presentNotification notification succeed");
                 }
                 else
                 {
                     NSLog(@"NotificationsManager::presentNotification notification failed");
                 }
             }];
        }
        else
        {
            NSLog(@"NotificationsManager::presentNotification init failed");
        }
    }
    else
    {
        NSLog(@"NotificationsManager::presentNotification for pre-iOS 10 is not implemented");
    }
}

- (void)removeAllNotifications {
    if (SYSTEM_VERSION_GE(systemVersion10)) {
        [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
        [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
    }
    else {
        NSLog(@"NotificationsManager::presentNotification for pre-iOS 10 is not implemented");
    }
}

@end
