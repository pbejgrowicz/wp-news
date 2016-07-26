//
//  TitleTableViewCell.h
//  wppl
//
//  Created by Speednet on 26.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TitleTableViewCellDelegate;

@interface TitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic, assign) id <TitleTableViewCellDelegate> delegate;

@end
@protocol TitleTableViewCellDelegate <NSObject>
- (void)cellTapped:(TitleTableViewCell*)cell;
@end
