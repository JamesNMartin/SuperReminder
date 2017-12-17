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
//#import <IQKeyboardManager.h>
//#import <IQUIView+IQKeyboardToolbar.h>
//#import <IQUITextFieldView+Additions.h>

@interface NewEntryTableViewController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation NewEntryTableViewController
{
    bool monthlyBOOL;
    bool autoPayBOOL;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated {

    //[super viewWillAppear:YES]; // This line is needed for the 'auto slide up'
    //self.saveButton.enabled = FALSE;
    self.navigationController.navigationBar.tintColor = FlatWhite;

    [self.closeButton setTitle:nil];
    //OG icon size 30
    [self.closeButton setImage:[IonIcons imageWithIcon:ion_ios_close_empty size:38.0f color:FlatWhite]];

    [self.saveButton setTitle:nil];
    //OG icon size 32
    [self.saveButton setImage:[IonIcons imageWithIcon:ion_ios_checkmark_empty size:40.0f color:FlatWhite]];

    monthlyBOOL = false;

    self.navigationController.navigationBar.barTintColor = FlatNavyBlueDark;
    self.navigationController.navigationBar.translucent = NO;

    _customTaxLabel.enabled = false; // THIS IS TO ENABLE LATER SO WE CAN HAVE A TOGGLE FOR CUSTOM
    _customTaxTextField.enabled = false; // SAME AS ABOVE
    
    //COLORS ###########################################################################################################
    _nameLabel.textColor = FlatNavyBlueDark;
    _priceLabel.textColor = FlatNavyBlueDark;
    _monthlyLabel.textColor = FlatNavyBlueDark;
    _autoPayLabel.textColor = FlatNavyBlueDark;
    _monthlyLabel.textColor = FlatNavyBlueDark;
    _contactLabel.textColor = FlatNavyBlueDark;
    _dueLabel.textColor = FlatNavyBlueDark;
    _customTaxLabel.textColor = FlatNavyBlue;
    _taxSegemntControl.tintColor = FlatNavyBlueDark;
    //##################################################################################################################
    
    dispatch_main_after(0.5f, ^{
        [_nameTextField becomeFirstResponder];
    });
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

    return 7;
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
                              kCRToastBackgroundColorKey : FlatRedDark,
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
        options[kCRToastInteractionRespondersKey] = @[
                [CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                                                                      automaticallyDismiss:YES
                                                                               block:^(CRToastInteractionType interactionType){
                                                                                   NSLog(@"Dismissed with %@ interaction",
                                                                                           NSStringFromCRToastInteractionType
                                                                                                   (interactionType));
                                                                                                                     }]];
    }
    return [NSDictionary dictionaryWithDictionary:options];
}
-(NSDictionary*)successToast {
    
    NSMutableDictionary *options = [@{
                                      kCRToastTextKey: @"Bill Reminder Added",
                                      kCRToastFontKey :[UIFont fontWithName:@"HelveticaNeue" size:12],
                                      kCRToastImageKey:[IonIcons imageWithIcon:ion_ios_checkmark_empty size:20.0 color:[UIColor whiteColor]],
                                      kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                      kCRToastImageAlignmentKey: @(NSTextAlignmentCenter),
                                      kCRToastBackgroundColorKey : FlatNavyBlue,
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
        options[kCRToastInteractionRespondersKey] = @[
                [CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                                                                      automaticallyDismiss:YES
                                                                               block:^(CRToastInteractionType interactionType){
                                                                                   NSLog(@"Dismissed with %@ interaction",
                                                                                           NSStringFromCRToastInteractionType
                                                                                                   (interactionType));
                                                                                                                     }]];
    }
    return [NSDictionary dictionaryWithDictionary:options];
}


- (IBAction)saveData:(id)sender {
    
    ReminderObject *reminder = [[ReminderObject alloc]init];
    
    
    NSDate *dueDate = _dueDatePicker.date;
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dueString = [dateFormatter stringFromDate:dueDate];
    NSDate *dd = [dateFormatter dateFromString:dueString];
    
    if ([self.nameTextField.text isEqual:@""]) {
        
        
        [CRToastManager showNotificationWithOptions:[self errorToast]
                                     apperanceBlock:^(void) {
                                         self.nameLabel.textColor = FlatRedDark;
                                     }
                                    completionBlock:^(void) {
                                        self.nameLabel.textColor = [UIColor blackColor];
                                    }];
    } else {
        
        NSString *priceStringToDouble = self.priceTextField.text;
        
        reminder.name = self.nameTextField.text;
        //reminder.price = [priceStringToDouble doubleValue];
        reminder.dueDate = dd;
        reminder.monthlyCheck = monthlyBOOL;
        reminder.autoPay = autoPayBOOL;
        
        if (_taxSegemntControl.selectedSegmentIndex == 0) {
            double taxRate = 0.09;
            double priceWithTax = [priceStringToDouble doubleValue] * taxRate + [priceStringToDouble doubleValue];
            
            reminder.price = priceWithTax;
        }
        if (_taxSegemntControl.selectedSegmentIndex == 1) {
            reminder.price = [priceStringToDouble doubleValue];
        }
        if (_taxSegemntControl.selectedSegmentIndex == 2) {
            printf("NOTHING HANDLED HERE YET");
        }
//        NSLog(@"NAME: %@", self.nameTextField.text);
//        NSLog(@"PRICE: %@", self.priceTextField.text);
//        NSLog(@"DUE DATE: %@", dueString);
//        NSLog(@"MONTHLY CHECK: %hhu", monthlyBOOL);
//        NSLog(@"AUTO PAY CHECK: %hhu", autoPayBOOL);
//        printf("\n");
        
        [self addToRealm:reminder];
        
        
        
        [CRToastManager showNotificationWithOptions:[self successToast]
                                     apperanceBlock:^(void) {
                                         [self dismissViewControllerAnimated:YES completion:nil];
                                     }
                                    completionBlock:^(void) {
                                    }];
    }
}
- (IBAction)closeButton:(id)sender {
    [self.view endEditing:YES];
    dispatch_main_after(0.25f, ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}
- (IBAction)monthlyTapped:(id)sender {
    if (!monthlyBOOL) {
        monthlyBOOL = true;
        _monthlyCell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        monthlyBOOL = false;
        _monthlyCell.accessoryType = UITableViewCellAccessoryNone;
    }
}
- (IBAction)autoPayTapped:(id)sender {
    if (!autoPayBOOL) {
        autoPayBOOL = true;
        _autoPayCell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        autoPayBOOL = false;
        _autoPayCell.accessoryType = UITableViewCellAccessoryNone;
    }
}
- (IBAction)nameCheck:(id)sender {
    while(_nameTextField.text != NULL) {
        _saveButton.enabled = TRUE;
        break;
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
- (IBAction)taxSegmentControl:(id)sender {
    if (_taxSegemntControl.selectedSegmentIndex == 2) {
        _customTaxLabel.enabled = true;
        _customTaxTextField.enabled = true;
    } else {
        _customTaxLabel.enabled = false;
        _customTaxTextField.enabled = false;
    }
}
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
@end
