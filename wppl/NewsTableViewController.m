//
//  NewsTableViewController.m
//  wppl
//
//  Created by Speednet on 26.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import "NewsTableViewController.h"

@interface NewsTableViewController ()

@end

@implementation NewsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib
                                 nibWithNibName:NSStringFromClass([TitleTableViewCell class]) bundle:
                                 [NSBundle mainBundle]] forCellReuseIdentifier:@"TitleTableViewCell"];
    [self.tableView registerNib:[UINib
                                 nibWithNibName:NSStringFromClass([ImageTableViewCell class]) bundle:
                                 [NSBundle mainBundle]] forCellReuseIdentifier:@"ImageTableViewCell"];
    [self.tableView registerNib:[UINib
                                 nibWithNibName:NSStringFromClass([TextTableViewCell class]) bundle:
                                 [NSBundle mainBundle]] forCellReuseIdentifier:@"TextTableViewCell"];
    _newsItems  = @[@"title", @"image", @"text"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
       [self loadNews];
        [self.tableView reloadData];
}

-(void)loadNews
{
    
    NSURL *newsUrl = [NSURL URLWithString:self.url];
    NSData *newsHtmlData = [NSData dataWithContentsOfURL:newsUrl];
    TFHpple *newsParser  = [TFHpple hppleWithHTMLData:newsHtmlData];
    NSString *titleXpath = @"//header[@class='narrow']/div[@class='h1']";
    
    // NSString *imageNewsXpath = @"//ul[@class='wiadomosciLst']/li[@class='first']/a[@class='ikonka']/img";
    //NSArray *imageNodes = [newsParser searchWithXPathQuery:imageNewsXpath];
    NSArray *titleNode = [newsParser searchWithXPathQuery:titleXpath];
    NSLog(@"%@", titleNode);
    for (TFHppleElement *element in titleNode) {
       _titleText = [[element firstChild] content];
        NSLog(@"%@", [[element firstChild] content]);
    }
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

    return _newsItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if(indexPath.row == 0)
    {
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        
        
        if (cell == nil)
        {
            cell = [TitleTableViewCell new];
        }
        cell.title.text = _titleText;
        
        return cell;
    } else if (indexPath.row == 1)
    {
        ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageTableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        
        
        if (cell == nil)
        {
            cell = [ImageTableViewCell new];
        }
        cell.image.image = nil;
        
        return cell;

    }
    else if (indexPath.row == 2)
    {
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextTableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        
        
        if (cell == nil)
        {
            cell = [TextTableViewCell new];
        }
        cell.textField.text = nil;
        
        return cell;
        
    }

    else
    {
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        
        
        if (cell == nil)
        {
            cell = [TitleTableViewCell new];
        }
        cell.title.text = _titleText;
        
        return cell;

    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 106;
    }
    else if (indexPath.row == 1)
    {
        return 178;
    }
    else if (indexPath.row == 2)
    {
        return 204;
    }
    else
    {
        return 60;
    }
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
