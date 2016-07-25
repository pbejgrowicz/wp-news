//
//  NewsTableViewCell.h
//  wppl
//
//  Created by Speednet on 25.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewsTableViewCellDelegate;

@interface NewsTableViewCell : UITableViewCell

@property (nonatomic, assign) id <NewsTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@protocol NewsTableViewCellDelegate <NSObject>
- (void)cellTapped:(NewsTableViewCell*)cell;
@end
