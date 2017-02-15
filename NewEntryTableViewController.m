//
//  NewEntryTableViewController.m
//  SuperReminder
//
//  Created by James Martin on 2/8/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import "NewEntryTableViewController.h"
#import <Realm.h>
#import "ReminderObject.h"
#import <CRToast.h>
#import <IonIcons.h>
#import <KVNProgress/KVNProgress.h>
#import <Chameleon.h>

@interface NewEntryTableViewController ()

@end

@implementation NewEntryTableViewController
{
    Boolean monthlyBOOL;
    Boolean autoPayBOOL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = FlatBlue;
    
    monthlyBOOL = false;
    
    //self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.74 green:0.75 blue:0.74 alpha:1.00];
    self.navigationController.navigationBar.translucent = NO;
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00];
    
    //self.view.backgroundColor =  [UIColor colorWithRed:0.49 green:0.51 blue:0.52 alpha:1.00];
    
    //[self.tableView setSeparatorColor:[UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00]];
    
    //LABEL COLORS ###################################################################################################
    _nameLabel.textColor =    [UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00];
    _priceLabel.textColor =   [UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00];
    _monthlyLabel.textColor = [UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00];
    _autoPayLabel.textColor = [UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00];
    _monthlyLabel.textColor = [UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00];
    _contactLabel.textColor = [UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00];
    _dueLabel.textColor =     [UIColor colorWithRed:0.23 green:0.24 blue:0.25 alpha:1.00];
    //################################################################################################################
    [_nameTextField becomeFirstResponder];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    //cell.backgroundColor = [UIColor colorWithRed:0.74 green:0.75 blue:0.74 alpha:1.00];
    
    
    return cell;
    
}


-(NSDictionary*)errorToast {

    NSMutableDictionary *options = [@{
                              kCRToastTextKey: @"Whoops! We're missing something",
                              //kCRToastSubtitleTextKey: @"We're gonna need a name",
                              kCRToastFontKey :[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:17],
                              kCRToastImageKey:[IonIcons imageWithIcon:ion_ios_help_outline size:36.0 color:[UIColor whiteColor]],
                              kCRToastTextAlignmentKey : @(NSTextAlignmentLeft),
                              kCRToastBackgroundColorKey : FlatRed,
                              kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                              kCRToastNotificationPresentationTypeKey:@(CRToastPresentationTypePush),
                              kCRToastSubtitleTextAlignmentKey: @(NSTextAlignmentLeft),
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeSpring),
                              kCRToastAnimationSpringDampingKey : @(0.5),
                              kCRToastTimeIntervalKey: @(8),
                              kCRToastInteractionRespondersKey: @(CRToastInteractionTypeTapOnce),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)}mutableCopy];
    Boolean tappable = true;
    
    if (tappable == true) {
        options[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                                                                      automaticallyDismiss:YES
                                                                                                                     block:^(CRToastInteractionType interactionType){
                                                                                                                         NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
                                                                                                                     }]];
    }
    return [NSDictionary dictionaryWithDictionary:options];
}
-(NSDictionary*)successToast {
    
    NSMutableDictionary *options = [@{
                                      kCRToastTextKey: @"Reminder Added",
                                      kCRToastFontKey :[UIFont fontWithName:@"HelveticaNeue" size:12],
                                      kCRToastImageKey:[IonIcons imageWithIcon:ion_ios_checkmark_empty size:20.0 color:[UIColor whiteColor]],
                                      kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                      kCRToastImageAlignmentKey: @(NSTextAlignmentCenter),
                                      kCRToastBackgroundColorKey : FlatBlue,
                                      kCRToastNotificationTypeKey : @(CRToastTypeStatusBar),
                                      kCRToastNotificationPresentationTypeKey:@(CRToastPresentationTypePush),
                                      kCRToastSubtitleTextAlignmentKey: @(NSTextAlignmentLeft),
                                      kCRToastAnimationInTypeKey : @(CRToastAnimationTypeSpring),
                                      kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeSpring),
                                      kCRToastAnimationSpringDampingKey : @(0.5),
                                      kCRToastTimeIntervalKey: @(3),
                                      kCRToastInteractionRespondersKey: @(CRToastInteractionTypeTapOnce),
                                      kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                      kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)}mutableCopy];
    Boolean tappable = true;
    
    if (tappable == true) {
        options[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                                                                      automaticallyDismiss:YES
                                                                                                                     block:^(CRToastInteractionType interactionType){
                                                                                                                         NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
                                                                                                                     }]];
    }
    return [NSDictionary dictionaryWithDictionary:options];
}


- (IBAction)saveData:(id)sender {
    
    ReminderObject *reminder = [[ReminderObject alloc]init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *dueDate = _dueDatePicker.date;
    NSString *dueString = [dateFormatter stringFromDate:dueDate];
    
    
    if ([self.nameTextField.text isEqual:@""]) {
        
        //NSLog(@"NAME: %@", self.nameTextField.text);
        //NSLog(@"PRICE: %@", self.priceTextField.text);
        
        [CRToastManager showNotificationWithOptions:[self errorToast]
                                     apperanceBlock:^(void) {
                                     }
                                    completionBlock:^(void) {
                                    }];
        
    } else {
        reminder.name = self.nameTextField.text;
        reminder.price = self.priceTextField.text;
        reminder.dueDate = dueDate;
        reminder.monthlyCheck = monthlyBOOL;
        reminder.autoPay = autoPayBOOL;
        
        
        
        
//        NSLog(@"NAME: %@", self.nameTextField.text);
//        NSLog(@"PRICE: %@", self.priceTextField.text);
//        NSLog(@"DUE DATE: %@", dueString);
//        NSLog(@"MONTHLY CHECK: %hhu", monthlyBOOL);
//        NSLog(@"AUTO PAY CHECK: %hhu", autoPayBOOL);
//        NSLog(@"PHONE NUMBER: %@", self.contactNumberTextField.text);
//        printf("\n");
        
        [self addToRealm:reminder];
        
        
        
        
        
        
        [CRToastManager showNotificationWithOptions:[self successToast]
                                     apperanceBlock:^(void) {
                                          [self dismissViewControllerAnimated:YES completion:nil];
                                     }
                                    completionBlock:^(void) {
                                    }];
//        [KVNProgress showSuccessWithStatus:@"Reminder Added"];
//        
//        dispatch_main_after(1.0f, ^{
//            [self dismissViewControllerAnimated:YES completion:nil];
//            [KVNProgress dismiss];
//            
//        });
        
    }
}
- (IBAction)closeButton:(id)sender {
//
//  THIS IS A MAYBE
//
//        FCAlertView *alert = [[FCAlertView alloc] init];
//        
//        [alert makeAlertTypeWarning];
//        alert.bounceAnimations = YES;
//        alert.animateAlertInFromTop = YES;
//        alert.animateAlertOutToBottom = YES;
//        //[alert setAlertSoundWithFileName:@"Ding.mp3"];
//        [alert showAlertInView:self
//                     withTitle:@"Cancel Entry?"
//                  withSubtitle:@"You will lose all entered data."
//               withCustomImage:nil
//           withDoneButtonTitle:@"Continue"
//                    andButtons:@[@"Cancel"]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)monthlyTapped:(id)sender {
    if (monthlyBOOL == false) {
        monthlyBOOL = true;
        _monthlyCell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        monthlyBOOL = false;
        _monthlyCell.accessoryType = UITableViewCellAccessoryNone;
    }
}
- (IBAction)autoPayTapped:(id)sender {
    if (autoPayBOOL == false) {
        autoPayBOOL = true;
        _autoPayCell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        autoPayBOOL = false;
        _autoPayCell.accessoryType = UITableViewCellAccessoryNone;
    }
}
-(void)addToRealm:(ReminderObject *)re {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:re];
    [realm commitWriteTransaction];
    //NSLog(@"WRITE SUCCESSFUL");
    [self checkIfDone];
}
-(void)checkIfDone {
    
    RLMResults *rewardData = [ReminderObject allObjects];
    if ([rewardData count] > 0)
    {
        //NSLog(@"DATA CHECK SUCCESS");
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"dataStored" object:nil];
    }
}
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
