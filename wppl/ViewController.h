//
//  ViewController.h
//  wp news
//
//  Created by Speednet on 25.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TFHpple.h>
#import "News.h"
#import "NewsTableViewCell.h"
#import "NewsTableViewController.h"



@interface ViewController : UIViewController <UITableViewDelegate, NewsTableViewCellDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadButton;

-(IBAction)reloadTable:(id)sender;

@end
