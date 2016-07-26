//
//  NewsTableViewController.h
//  wppl
//
//  Created by Speednet on 26.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TFHpple.h>
#import "TitleTableViewCell.h"
#import "ImageTableViewCell.h"
#import "TextTableViewCell.h"

@interface NewsTableViewController : UITableViewController 
@property (strong, nonatomic, readwrite) NSString *url;
@property (nonatomic, strong) NSArray *newsItems;
@property (strong, nonatomic, readwrite) NSString *titleText;


@end

