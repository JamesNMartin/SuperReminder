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
//#import "SettingsTableViewController.h"
#import <Chameleon.h>
#import <CRToast.h>
#import <IonIcons.h>
//#import <Realm.h>
//#import <KVNProgress/KVNProgress.h>
#import "RealmDataTableViewCell.h"
//#import "NewEntryTableViewController.h"
//#import <DGActivityIndicatorView.h>
//#import <Crashlytics/Crashlytics.h>

#define DARK_GRAY_COLOR [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1.00]
#define LIGHT_GRAY_COLOR [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1.00]
#define PURPLE_COLOR [UIColor colorWithRed:0.59 green:0.38 blue:0.91 alpha:1.00]
#define BRIGHT_PURPLE [UIColor colorWithRed:0.70 green:0.52 blue:1.00 alpha:1.00]
#define DARK_PURPLE [UIColor colorWithRed:0.51 green:0.37 blue:0.72 alpha:1.00]

@interface RealmDataTableViewController () <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {

    RLMResults *data;
    RealmDataTableViewCell *cell;
    RLMRealm *realm;
    NSDate *todaysDate;
}

@end

@implementation RealmDataTableViewController

- (void)viewDidLoad {
    NSLog([self getTodaysDate]);
//    NSString *testString = @"THIS IS A TEST";
//    [self testMethod:testString];
    //THIS WILL PRINT THE REALM FILE URL
    //NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    
    [super viewDidLoad];
}
//-(void)testMethod: (NSString *)theTest {
//    NSLog(theTest);
//}
-(NSString *)getTodaysDate {

    NSDate *theDate = [[NSDate alloc]init];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *todaysDateFormatter = [[NSDateFormatter alloc]init];
    [todaysDateFormatter setTimeZone:timeZone];
    [todaysDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *localDateString = [todaysDateFormatter stringFromDate:theDate];

    return localDateString;

}
- (IBAction)sortingOptionsButton:(id)sender {

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Sorting Order" message:@"Sort by..." preferredStyle:UIAlertControllerStyleActionSheet];
    actionSheet.view.tintColor = PURPLE_COLOR;

    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //TODO Add action for cancel button
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];

    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Name" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //TODO Add action for name order
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];

    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Price" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //TODO Add action for price order
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];

    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Due Date" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //TODO Add action for due date order
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];

    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];

//    UINavigationController *sVC = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsViewController"];
//    [self presentViewController:sVC animated:YES completion:nil];

    //UNCOMMENT TO RE-ADD THE MASS DELETE REALM DATA FILE
    //##############################################################################################################
    //    realm = [RLMRealm defaultRealm];
    //    [CRToastManager showNotificationWithOptions:[self successToast]
    //                                 apperanceBlock:^(void) {
    //                                     [realm beginWriteTransaction];
    //                                     [realm deleteAllObjects];
    //                                     [realm commitWriteTransaction];
    //                                     _totalMonthlyBill.text = @"Total Monthly Bill Cost $0";
    //                                     [self.tableView reloadData];
    //
    //                                 }
    //                                completionBlock:^(void) {
    //                                }];
    //##############################################################################################################
}

-(NSDictionary*)paidToast: (NSString *)theBillName {

    NSString *toastText = [theBillName stringByAppendingString:@" Bill Paid"];


    NSMutableDictionary *options = [@{
                                      kCRToastTextKey: toastText,
                                      kCRToastFontKey :[UIFont fontWithName:@"HelveticaNeue" size:12],
                                      kCRToastTextColorKey: FlatWhite,
                                      kCRToastImageKey:[IonIcons imageWithIcon:ion_ios_checkmark_empty size:22.0 color:FlatWhite],
                                      kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                      kCRToastImageAlignmentKey: @(NSTextAlignmentCenter),
                                      kCRToastBackgroundColorKey : PURPLE_COLOR,
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
    //Boolean tappable = true;

    options[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                                                                  automaticallyDismiss:YES
                                                                                                                 block:^(CRToastInteractionType interactionType){
                                                                                                                     NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
                                                                                                                 }]];
    return [NSDictionary dictionaryWithDictionary:options];
}
-(void)viewWillAppear:(BOOL)animated {

    data=[ReminderObject allObjects];

    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = true;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
        self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName: FlatWhite};
    } else {
        // Fallback on earlier versions
    }
    [UINavigationBar appearance].shadowImage = [UIImage new];

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.59 green:0.38 blue:0.91 alpha:1.00];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1.00];
    [self.addButton setTitle:nil];
    [self.addButton setImage:[IonIcons imageWithIcon:ion_ios_compose_outline size:30.0f color:PURPLE_COLOR]];
    [self.clearButton setTitle:nil];
    [self.clearButton setImage:[IonIcons imageWithIcon:ion_ios_cog_outline size:30.0f color:PURPLE_COLOR]];
    self.navigationController.navigationBar.translucent = NO;
    [self.totalMonthlyBill setTextColor:FlatWhite];
    [self.tableView setSeparatorColor:DARK_GRAY_COLOR];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: FlatWhite}];
    [self.tableView reloadData];
    
    NSNumber *sum = [data sumOfProperty:@"price"];
    NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
    [decimalStyleFormatter setMaximumFractionDigits:2];
    NSString *sumString = [decimalStyleFormatter stringFromNumber:sum];
    NSString *totalString = [[NSString alloc] initWithFormat: @"Total Monthly Bill Cost $%@", sumString];
    _totalMonthlyBill.text = totalString;
    
    self.view.backgroundColor = DARK_GRAY_COLOR;
    //NSLog(@"OBJECTS IN LIST: %lu", (unsigned long)[data count]);
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
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if ( cell == nil ) {
        cell = [[RealmDataTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *dueDate = data[(NSUInteger) indexPath.row][@"dueDate"];
    NSString *dueString = [dateFormatter stringFromDate:dueDate];
    NSDate *endDate = [[NSDate alloc]init];
    NSTimeZone *timeZone = [NSTimeZone defaultTimeZone];
    NSDateFormatter *todaysDateFormatter = [[NSDateFormatter alloc]init];
    [todaysDateFormatter setTimeZone:timeZone];
    [todaysDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *localDateString = [todaysDateFormatter stringFromDate:endDate];
    NSDate *td = [todaysDateFormatter dateFromString:localDateString];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:td
                                                          toDate:dueDate
                                                         options:0];
    NSInteger diff = [components day];
    //NSLog(@"DUE DATE: %@", dueDate);
    //NSLog(@"TODAY'S DATE: %@", td);
    //NSLog(@"DIFFERENCE IN DATE FROM TODAY: %ld", labs(diff));
    
    NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
    //[decimalStyleFormatter setNumberStyle:@"##.##"];
    [decimalStyleFormatter setMaximumFractionDigits:2];
    
    NSString *priceString = [decimalStyleFormatter stringFromNumber:data[(NSUInteger) indexPath.row][@"price"]];
    NSString *formattedPrice = [[[NSString alloc] initWithFormat: @"$%@ • ", priceString] stringByAppendingString: dueString];
    
    [cell.nameLabel setText:[NSString stringWithFormat:@"%@",data[(NSUInteger) indexPath.row][@"name"]]];
    [cell.priceLabel setText:formattedPrice];
    [cell.statusLabel setText:[NSString stringWithFormat:@"%ldd", labs(diff)]];

    cell.nameLabel.textColor   = PURPLE_COLOR;
    cell.priceLabel.textColor  = FlatWhite;
    cell.autoPayCheck.textColor = FlatWhite;
    cell.backgroundColor = LIGHT_GRAY_COLOR;
    
    NSNumber *boolNumber = data[(NSUInteger) indexPath.row][@"autoPay"];
    bool autoPay = boolNumber.boolValue;
    if (autoPay == 1) {
        cell.autoPayCheck.text = @"Auto Pay";
    } else {
        cell.autoPayCheck.text = @"";
    }
    if ((diff) < 0) {
        cell.statusLabel.text = @"Past Due";
        cell.statusLabel.textColor = FlatRedDark;
    }
    if ((diff) == 0) {
        cell.statusLabel.text = @"Due Today";
        cell.statusLabel.textColor = FlatRedDark;
    }
    if ((diff) <= 3) {
        cell.statusLabel.textColor = FlatRedDark;
    }
    if ((diff) >= 4) {
        cell.statusLabel.textColor = FlatYellowDark;
    }
    if ((diff) >= 7) {
        cell.statusLabel.textColor = PURPLE_COLOR;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //[self.view addSubview:blurEffectView];
    //NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    //[self reoccur:selectedIndexPath];
    
    ReminderObject *newReminder = [[ReminderObject alloc]init];

    NSString *newName = data[(NSUInteger) indexPath.row][@"name"];
    double newPrice = [data[(NSUInteger) indexPath.row][@"price"]doubleValue];
    NSDate *oldDate = data[(NSUInteger) indexPath.row][@"dueDate"];
    NSNumber *mb = data[(NSUInteger) indexPath.row][@"monthlyCheck"];
    NSNumber *ab = data[(NSUInteger) indexPath.row][@"autoPay"];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:oldDate options:0];
    
    NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
    [decimalStyleFormatter setMaximumFractionDigits:2];
    NSString *p = [decimalStyleFormatter stringFromNumber:data[(NSUInteger) indexPath.row][@"price"]];
    NSString *alertTitle = [[[NSString alloc] initWithFormat: @"%@ • $", newName] stringByAppendingString: p];
    
    if (mb.boolValue == 1) {
        
        UIAlertController *al = [UIAlertController
                                 alertControllerWithTitle:alertTitle
                                 message:@"If this bill is monthly reoccuring and will be created for the next month automatically."
                                 preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* readd = [UIAlertAction
                                actionWithTitle:@"Continue"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    bool mBOOL;
                                    bool aBOOL;
                                    [[RLMRealm defaultRealm] beginWriteTransaction];
                                    [[RLMRealm defaultRealm] deleteObject:[data objectAtIndex:(NSUInteger) indexPath.row]];
                                    [[RLMRealm defaultRealm] commitWriteTransaction];

                                    [tableView deleteRowsAtIndexPaths:[@[indexPath] mutableCopy] withRowAnimation:UITableViewRowAnimationRight];
                                    [tableView setEditing:NO animated:YES];
                                    [self.tableView reloadData];
                                    
                                    newReminder.name = newName;
                                    newReminder.price= newPrice;
                                    newReminder.dueDate = newDate;
                                    
                                    mBOOL = 1;
                                    newReminder.monthlyCheck = mBOOL;
                                    if (ab.boolValue == 1) {
                                        aBOOL = 1;
                                        newReminder.autoPay = aBOOL;
                                    } else {
                                        aBOOL = 0;
                                        newReminder.autoPay = aBOOL;
                                    }
                                    
                                    [self addToRealm:newReminder];
                                    [self.tableView reloadData];
                                }];
        UIAlertAction* dontReadd = [UIAlertAction
                                    actionWithTitle:@"Delete"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        [[RLMRealm defaultRealm] beginWriteTransaction];
                                        [[RLMRealm defaultRealm] deleteObject:[data objectAtIndex:(NSUInteger) indexPath.row]];
                                        [[RLMRealm defaultRealm] commitWriteTransaction];
                                        data=[ReminderObject allObjects];

                                        [tableView deleteRowsAtIndexPaths:[@[indexPath] mutableCopy] withRowAnimation:UITableViewRowAnimationRight];
                                        [tableView setEditing:NO animated:YES];
                                        [self.tableView reloadData];
                                        [self updateTotalMonthPrice];
                                        //HANDLE DONT ADD
                                    }];
        UIAlertAction* editButton = [UIAlertAction
                                     actionWithTitle:@"Edit"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action) {
                                         //HANDLE EDIT
                                     }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleCancel
                                 handler:^(UIAlertAction * action) {
                                     //HANDLE CANCEL
                                 }];

        al.view.tintColor = PURPLE_COLOR;
        [al addAction:readd];
        [al addAction:dontReadd];
        [al addAction:editButton];
        [al addAction:cancel];
        [self presentViewController:al animated:YES completion:nil];
        
    } else {
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[RLMRealm defaultRealm] deleteObject:[data objectAtIndex:(NSUInteger) indexPath.row]];
        [[RLMRealm defaultRealm] commitWriteTransaction];
        data=[ReminderObject allObjects];

        [tableView deleteRowsAtIndexPaths:[@[indexPath] mutableCopy] withRowAnimation:UITableViewRowAnimationRight];
        [tableView setEditing:NO animated:YES];
        
        [CRToastManager showNotificationWithOptions:[self paidToast:newName]
                                     apperanceBlock:^(void) {
                                         //CAN DO SOME ACTION HERE
                                     }
                                    completionBlock:^(void) {
                                        //WHEN IT DISMISSES CALL SOMETHING ID NEEDED
                                    }];
        [self.tableView reloadData];
    }
    [self.tableView reloadData];
    [self updateTotalMonthPrice];
};
-(void)updateTotalMonthPrice {
    NSNumber *sum = [data sumOfProperty:@"price"];
    NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
    [decimalStyleFormatter setMaximumFractionDigits:2];
    NSString *sumString = [decimalStyleFormatter stringFromNumber:sum];
    NSString *totalString = [[NSString alloc] initWithFormat: @"Total Monthly Bill Cost $%@", sumString];
    _totalMonthlyBill.text = totalString;
}
-(void)addToRealm:(ReminderObject *)re {
    realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:re];
    [realm commitWriteTransaction];
}
//
//THIS IS HOW YOU USE THE DISPATCH_MAIN_AFTER BLOCK
//
//dispatch_main_after(1.0f, ^{
//
//
//});
//static void dispatch_main_after(NSTimeInterval delay, void (^block)(void)){
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        block();
//    });
//}
- (IBAction)addButton:(id)sender {
    UINavigationController *bVC = [self.storyboard instantiateViewControllerWithIdentifier:@"billViewController"];
    [self presentViewController:bVC animated:YES completion:nil];
    //    UINavigationController *iVC = [self.storyboard instantiateViewControllerWithIdentifier:@"iouViewController"];
    //    [self presentViewController:iVC animated:YES completion:nil];
}

@end
