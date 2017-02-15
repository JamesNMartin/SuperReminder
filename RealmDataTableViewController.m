//
//  RealmDataTableViewController.m
//  SuperReminder
//
//  Created by James Martin on 2/8/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import "RealmDataTableViewController.h"
#import "ReminderObject.h"
#import "UIScrollView+EmptyDataSet.h"
#import <Chameleon.h>
#import <CRToast.h>
#import <IonIcons.h>
#import <Realm.h>
#import <KVNProgress/KVNProgress.h>
#import "RealmDataTableViewCell.h"
#import "NewEntryTableViewController.h"




@interface RealmDataTableViewController () <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    
    RLMResults *data;
    
}

@end

@implementation RealmDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.addButton setTitle:nil];
    [self.addButton setImage:[IonIcons imageWithIcon:ion_ios_compose_outline size:30.0f color:FlatBlue]];
    
    [self.clearButton setTitle:nil];
    [self.clearButton setImage:[IonIcons imageWithIcon:ion_ios_trash_outline size:32.0f color:FlatBlue]];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.totalMonthlyBill setTextColor:FlatBlue];
    
    //self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //self.tableView.emptyDataSetSource = self;
    //self.tableView.emptyDataSetDelegate = self;
    
    // A little trick for removing the cell separators
    //self.tableView.tableFooterView = [UIView new];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_placeholder"];
}
- (IBAction)clearButton:(id)sender {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [CRToastManager showNotificationWithOptions:[self successToast]
                                 apperanceBlock:^(void) {
                                     [realm beginWriteTransaction];
                                     [realm deleteAllObjects];
                                     [realm commitWriteTransaction];
                                     _totalMonthlyBill.text = @"Total Monthly Bill Cost $0.00";
                                     [self.tableView reloadData];

                                 }
                                completionBlock:^(void) {
                                }];
}
-(NSDictionary*)successToast {
    
    NSMutableDictionary *options = [@{
                                      kCRToastTextKey: @"Cleared",
                                      kCRToastFontKey :[UIFont fontWithName:@"HelveticaNeue" size:12],
                                      kCRToastTextColorKey: FlatWhite,
                                      kCRToastImageKey:[IonIcons imageWithIcon:ion_ios_checkmark_empty size:20.0 color:FlatWhite],
                                      kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                      kCRToastImageAlignmentKey: @(NSTextAlignmentCenter),
                                      kCRToastBackgroundColorKey : FlatBlue,
                                      kCRToastNotificationTypeKey : @(CRToastTypeStatusBar),
                                      kCRToastNotificationPresentationTypeKey:@(CRToastPresentationTypePush),
                                      kCRToastSubtitleTextAlignmentKey: @(NSTextAlignmentLeft),
                                      kCRToastAnimationInTypeKey : @(CRToastAnimationTypeSpring),
                                      kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeSpring),
                                      kCRToastAnimationSpringDampingKey : @(0.5),
                                      kCRToastTimeIntervalKey: @(1.5),
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
-(void)success {
    [KVNProgress showSuccessWithStatus:@"Done!"];
    
    dispatch_main_after(1.0f, ^{
        [self.tableView reloadData];
        [KVNProgress dismiss];
        NSLog(@"DATABASE CLEARED");
        
    });
}
-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    data = [ReminderObject allObjects];
    NSNumber *sum = [data sumOfProperty:@"price"];
    NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
    [decimalStyleFormatter setMaximumFractionDigits:2];
    NSString *sumString = [decimalStyleFormatter stringFromNumber:sum];
    NSString *totalString = [[NSString alloc] initWithFormat: @"Total Monthly Bill Cost $%@", sumString];
    _totalMonthlyBill.text = totalString;
    NSLog(@"OBJECTS IN LIST: %lu", (unsigned long)[data count]);
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
    return [data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RealmDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if ( cell == nil ) {
        cell = [[RealmDataTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *dueDate = data[indexPath.row][@"dueDate"];
    NSString *dueString = [dateFormatter stringFromDate:dueDate];
    
    [cell.nameLabel setText:[NSString stringWithFormat:@"%@",data[indexPath.row][@"name"]]];
    [cell.priceLabel setText:[NSString stringWithFormat:@"%@",data[indexPath.row][@"price"]]];
    [cell.statusLabel setText:dueString];
    
    NSNumber *boolNumber = data[indexPath.row][@"autoPay"];
    BOOL autoPay = boolNumber.boolValue;
    if (autoPay == 1 ) {
        cell.autoPayCheck.text = @"Auto Pay";
    } else {
        cell.autoPayCheck.text = @"";
    }
    cell.statusLabel.textColor = FlatGreen;
    return cell;
}
//
//THIS IS HOW YOU USE THE DISPATCH_MAIN_AFTER BLOCK
//
//dispatch_main_after(1.0f, ^{
//
//    
//});
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void)){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
@end
