//
//  SettingsTableViewController.m
//  SuperReminder
//
//  Created by James Martin on 7/23/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import "SettingsTableViewController.h"
#import <Chameleon.h>
#import <IonIcons.h>
#import "RealmSettings.h"

#define DARK_GRAY_COLOR [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1.00]
#define LIGHT_GRAY_COLOR [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1.00]
#define PURPLE_COLOR [UIColor colorWithRed:0.59 green:0.38 blue:0.91 alpha:1.00]

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController
{
    bool lightThemeBOOL;
    bool darkThemeBOOL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES]; // This line is needed for the 'auto slide up'
    //self.saveButton.enabled = FALSE;
    self.navigationController.navigationBar.tintColor = PURPLE_COLOR;
    
//    [self.closeButton setTitle:nil];
//    [self.closeButton setImage:[IonIcons imageWithIcon:ion_ios_close_empty size:30.0f color:FlatWhite]];
    
    //[self.saveButton setTitle:nil];
    //[self.saveButton setImage:[IonIcons imageWithIcon:ion_ios_checkmark_empty size:32.0f color:FlatWhite]];
    
    self.navigationController.navigationBar.barTintColor = DARK_GRAY_COLOR;
    self.navigationController.navigationBar.translucent = NO;
    
     self.view.backgroundColor = DARK_GRAY_COLOR;
}
- (IBAction)closeButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(IBAction)lightThemeSelected:(id)sender {
    
}
-(IBAction)darkThemeSelected:(id)sender {
    
}

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
