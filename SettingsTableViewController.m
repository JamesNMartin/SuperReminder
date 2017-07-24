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
    self.navigationController.navigationBar.tintColor = FlatWhite;
    
    [self.closeButton setTitle:nil];
    [self.closeButton setImage:[IonIcons imageWithIcon:ion_ios_close_empty size:30.0f color:FlatWhite]];
    
    //[self.saveButton setTitle:nil];
    //[self.saveButton setImage:[IonIcons imageWithIcon:ion_ios_checkmark_empty size:32.0f color:FlatWhite]];
    
    self.navigationController.navigationBar.barTintColor = FlatNavyBlueDark;
    self.navigationController.navigationBar.translucent = NO;
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
