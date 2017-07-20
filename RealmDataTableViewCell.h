//
//  RealmDataTableViewCell.h
//  SuperReminder
//
//  Created by James Martin on 2/13/17.
//  Copyright © 2017 James Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>

@interface RealmDataTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *autoPayCheck;
//@property (weak, nonatomic) IBOutlet UILabel *dateDue;



@end
