//
//  SettingsTableViewController.h
//  SuperReminder
//
//  Created by James Martin on 7/23/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
- (IBAction)closeButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITableViewCell *lightThemeCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *darkThemeCell;



@end
