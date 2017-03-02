//
//  RealmDataTableViewController.h
//  SuperReminder
//
//  Created by James Martin on 2/8/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RealmDataTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearButton;
- (IBAction)clearButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UILabel *totalMonthlyBill;


@end
