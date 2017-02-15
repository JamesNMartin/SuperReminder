//
//  ReminderObject.h
//  SuperReminder
//
//  Created by James Martin on 2/8/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import <Realm/Realm.h>

@interface ReminderObject : RLMObject

//@property NSString *price;
@property double price;
@property NSString *name;
@property NSDate *dueDate;
@property BOOL monthlyCheck;
@property BOOL autoPay;

@end
