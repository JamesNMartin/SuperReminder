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
#import <DGActivityIndicatorView.h>

#define kBrown [UIColor colorWithRed:0.39 green:0.23 blue:0.11 alpha:1.00]
#define kRed [UIColor colorWithRed:0.94 green:0.32 blue:0.16 alpha:1.00]
#define kOrange [UIColor colorWithRed:0.96 green:0.51 blue:0.17 alpha:1.00]
#define kBlue [UIColor colorWithRed:0.52 green:0.94 blue:0.86 alpha:1.00]
#define kYellow [UIColor colorWithRed:0.97 green:0.87 blue:0.42 alpha:1.00]

@interface RealmDataTableViewController () <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate> {
    
    RLMResults *data;
    RealmDataTableViewCell *cell;
    RLMRealm *realm;
}

@end

@implementation RealmDataTableViewController

- (void)viewDidLoad {
    //THIS WILL PRINT THE REALM FILE URL
    //NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    [super viewDidLoad];
}
- (IBAction)clearButton:(id)sender {
    realm = [RLMRealm defaultRealm];
    [CRToastManager showNotificationWithOptions:[self successToast]
                                 apperanceBlock:^(void) {
                                     [realm beginWriteTransaction];
                                     [realm deleteAllObjects];
                                     [realm commitWriteTransaction];
                                     _totalMonthlyBill.text = @"Total Monthly Bill Cost $0";
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
                                      kCRToastBackgroundColorKey : FlatNavyBlue,
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
-(void)viewWillAppear:(BOOL)animated {
    
    data=[ReminderObject allObjects];
    [[UINavigationBar appearance] setBackgroundImage: [UIImage new]
                                       forBarMetrics: UIBarMetricsDefault];
    
    [UINavigationBar appearance].shadowImage = [UIImage new];
    
    self.navigationController.navigationBar.barTintColor = FlatNavyBlueDark;
    self.navigationController.navigationBar.tintColor = kBrown;
    
    [self.addButton setTitle:nil];
    [self.addButton setImage:[IonIcons imageWithIcon:ion_ios_compose_outline size:30.0f color:FlatWhite]];
    
    [self.clearButton setTitle:nil];
    [self.clearButton setImage:[IonIcons imageWithIcon:ion_ios_gear_outline size:30.0f color:FlatWhite]];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.totalMonthlyBill setTextColor:FlatNavyBlueDark];

    [self.tableView reloadData];
    
    NSNumber *sum = [data sumOfProperty:@"price"];
    NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
    [decimalStyleFormatter setMaximumFractionDigits:2];
    NSString *sumString = [decimalStyleFormatter stringFromNumber:sum];
    NSString *totalString = [[NSString alloc] initWithFormat: @"Total Monthly Bill Cost $%@", sumString];
    _totalMonthlyBill.text = totalString;
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    
    /*cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[IonIcons imageWithIcon:ion_ios_checkmark_empty size:36.0f color:FlatWhite] backgroundColor:FlatGreen],
                         [MGSwipeButton buttonWithTitle:@"" icon:[IonIcons imageWithIcon:ion_ios_close_empty size:30.0f color:FlatWhite] backgroundColor:FlatRed]];
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;*/
    
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
    //NSLog(@"TODAYS DATE: %@", td);
    //NSLog(@"DIFFERENCE IN DATE FROM TODAY: %ld", labs(diff));
    
    
    
    NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
    //[decimalStyleFormatter setNumberStyle:@"##.##"];
    [decimalStyleFormatter setMaximumFractionDigits:2];

    NSString *priceString = [decimalStyleFormatter stringFromNumber:data[(NSUInteger) indexPath.row][@"price"]];
    NSString *formattedPrice = [[[NSString alloc] initWithFormat: @"$%@ - ", priceString] stringByAppendingString: dueString];
    
    [cell.nameLabel setText:[NSString stringWithFormat:@"%@",data[(NSUInteger) indexPath.row][@"name"]]];
    [cell.priceLabel setText:formattedPrice];
    [cell.statusLabel setText:[NSString stringWithFormat:@"%ldd",(long)labs(diff)]];
    
    
    cell.nameLabel.textColor   = FlatNavyBlueDark;
    cell.priceLabel.textColor  = FlatGray;
    cell.autoPayCheck.textColor = FlatGray;
    cell.backgroundColor = [UIColor whiteColor];
    
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
        cell.statusLabel.textColor = FlatGreenDark;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    //[self reoccur:selectedIndexPath];
    
    ReminderObject *newReminder = [[ReminderObject alloc]init];
    
    NSString *newName = data[indexPath.row][@"name"];
    double newPrice = [data[indexPath.row][@"price"]doubleValue];
    NSDate *oldDate = data[indexPath.row][@"dueDate"];
    NSNumber *mb = data[indexPath.row][@"monthlyCheck"];
    NSNumber *ab = data[indexPath.row][@"autoPay"];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:oldDate options:0];
    
    
    
    UIAlertController *alert = [UIAlertController
                                 alertControllerWithTitle:newName
                                 message:@""
                                preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Mark As Paid"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    NSNumberFormatter *decimalStyleFormatter = [[NSNumberFormatter alloc] init];
                                    [decimalStyleFormatter setMaximumFractionDigits:2];
                                    NSString *p = [decimalStyleFormatter stringFromNumber:data[(NSUInteger) indexPath.row][@"price"]];
                                    NSString *alertTitle = [[[NSString alloc] initWithFormat: @"%@ - $", newName] stringByAppendingString: p];
                                    
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
                                                                    [[RLMRealm defaultRealm] deleteObject:[data objectAtIndex:indexPath.row]];
                                                                    [[RLMRealm defaultRealm] commitWriteTransaction];
                                                                    
                                                                    [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
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
                                                                    actionWithTitle:@"Remove"
                                                                    style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        [[RLMRealm defaultRealm] beginWriteTransaction];
                                                                        [[RLMRealm defaultRealm] deleteObject:[data objectAtIndex:indexPath.row]];
                                                                        [[RLMRealm defaultRealm] commitWriteTransaction];
                                                                        data=[ReminderObject allObjects];
                                                                        
                                                                        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
                                                                        [tableView setEditing:NO animated:YES];
                                                                        [self.tableView reloadData];
                                                                        [self updateTotalMonthPrice];
                                                                        //HANDLE DONT ADD
                                                                    }];
                                        UIAlertAction* hideForever = [UIAlertAction
                                                                    actionWithTitle:@"Don't Show This Again"
                                                                    style:UIAlertActionStyleDefault
                                                                    handler:^(UIAlertAction * action) {
                                                                        //HANDLE DONT SHOW AGAIN
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
                                        [al addAction:readd];
                                        [al addAction:dontReadd];
                                        [al addAction:editButton];
                                        [al addAction:hideForever];
                                        [al addAction:cancel];
                                        [self presentViewController:al animated:YES completion:nil];
                                        
//                                        bool mBOOL;
//                                        bool aBOOL;
//                                        [[RLMRealm defaultRealm] beginWriteTransaction];
//                                        [[RLMRealm defaultRealm] deleteObject:[data objectAtIndex:indexPath.row]];
//                                        [[RLMRealm defaultRealm] commitWriteTransaction];
//                                        
//                                        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
//                                        [tableView setEditing:NO animated:YES];
//                                        [self.tableView reloadData];
//                                        
//                                        newReminder.name = newName;
//                                        newReminder.price= newPrice;
//                                        newReminder.dueDate = newDate;
//                                        
//                                        mBOOL = 1;
//                                        newReminder.monthlyCheck = mBOOL;
//                                        if (ab.boolValue == 1) {
//                                            aBOOL = 1;
//                                            newReminder.autoPay = aBOOL;
//                                        } else {
//                                            aBOOL = 0;
//                                            newReminder.autoPay = aBOOL;
//                                        }
//
//                                        [self addToRealm:newReminder];
                                        
                                    } else {
                                        [[RLMRealm defaultRealm] beginWriteTransaction];
                                        [[RLMRealm defaultRealm] deleteObject:[data objectAtIndex:indexPath.row]];
                                        [[RLMRealm defaultRealm] commitWriteTransaction];
                                        data=[ReminderObject allObjects];
                                        
                                        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
                                        [tableView setEditing:NO animated:YES];
                                        [self.tableView reloadData];
                                    }
                                    [self.tableView reloadData];
                                    [self updateTotalMonthPrice];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    UIAlertAction* editButton = [UIAlertAction
                               actionWithTitle:@"Edit"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //UINavigationController *bVC = [self.storyboard instantiateViewControllerWithIdentifier:@"billViewController"];
                                   //[self presentViewController:bVC animated:YES completion:nil];
                                   
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:editButton];
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
}
//-(void)reoccur:(NSIndexPath *)indexPath {
//    
//    ReminderObject *newReminder = [[ReminderObject alloc]init];
//    
//    NSString *newName = data[indexPath.row][@"name"];
//    double newPrice = [data[indexPath.row][@"price"]doubleValue];
//    NSDate *oldDate = data[indexPath.row][@"dueDate"];
//    NSNumber *mb = data[indexPath.row][@"monthlyCheck"];
//    
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    [dateComponents setMonth:1];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:oldDate options:0];
//}
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
    //if(_billTypeSelector.selectedSegmentIndex == 0) {
        
        UINavigationController *bVC = [self.storyboard instantiateViewControllerWithIdentifier:@"billViewController"];
        [self presentViewController:bVC animated:YES completion:nil];
    //} else {
    //    UINavigationController *iVC = [self.storyboard instantiateViewControllerWithIdentifier:@"iouViewController"];
    //    [self presentViewController:iVC animated:YES completion:nil];
    //}
}
@end
