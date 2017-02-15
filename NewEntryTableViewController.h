//
//  NewEntryTableViewController.h
//  SuperReminder
//
//  Created by James Martin on 2/8/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewEntryTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dueLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *autoPayLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthlyLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *dueDatePicker;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
// AUTOPAY AND MONTHLY WILL BE A CHECK FOR TABLEVIEW CELL IS SELECTED AS BOOL
@property (strong, nonatomic) IBOutlet UITextField *contactNumberTextField;


@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveData;
- (IBAction)saveData:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *closeButton;
- (IBAction)closeButton:(id)sender;


@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *monthlyTapped;
- (IBAction)monthlyTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UITableViewCell *monthlyCell;


@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *autoPayTapped;
- (IBAction)autoPayTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UITableViewCell *autoPayCell;







@end
