//
//  NewEntryTableViewController.h
//  SuperReminder
//
//  Created by James Martin on 2/8/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewEntryTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic)   IBOutlet UILabel *nameLabel;
@property (weak, nonatomic)   IBOutlet UILabel *dueLabel;
@property (weak, nonatomic)   IBOutlet UILabel *priceLabel;
@property (weak, nonatomic)   IBOutlet UILabel *autoPayLabel;
@property (weak, nonatomic)   IBOutlet UILabel *monthlyLabel;
@property (weak, nonatomic)   IBOutlet UILabel *contactLabel;
@property (weak, nonatomic)   IBOutlet UITextField *nameTextField;
@property (weak, nonatomic)   IBOutlet UIDatePicker *dueDatePicker;
@property (weak, nonatomic)   IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *taxSegemntControl;
- (IBAction)taxSegmentControl:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *customTaxTextField;
@property (strong, nonatomic) IBOutlet UILabel *customTaxLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
//@property (strong, nonatomic) IBOutlet UITextField *contactNumberTextField;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveData;
- (IBAction)saveData:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
- (IBAction)closeButton:(id)sender;


@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *monthlyTapped;
- (IBAction)monthlyTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UITableViewCell *monthlyCell;


@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *autoPayTapped;
- (IBAction)autoPayTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITableViewCell *autoPayCell;


- (IBAction)nameCheck:(id)sender;





@end
