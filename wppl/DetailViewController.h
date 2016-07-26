//
//  DetailViewController.h
//  wppl
//
//  Created by Speednet on 26.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TFHpple.h>

@interface DetailViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic, readwrite) NSString *url;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@end
