//
//  NotificationsManager.h
//  TemplateAVV
//
//  Created by Anita Vasilieva on 14/11/2016.
//  Copyright © 2016 avv. All rights reserved.
//

#ifndef NotificationsManager_h
#define NotificationsManager_h

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

#define SYSTEM_VERSION_GE(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


@interface NotificationsManager : NSObject
- (instancetype)init;
+ (instancetype)sharedInstance;
- (void)configureUserNotifications;
- (void)presentNotification:(NSString *)bodyStr :(NSDictionary *)userInfo :(NSString *)categoryID :(NSString *)requestID;
- (void)removeAllNotifications;
@end

#endif /* NotificationsManager_h */
