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
{
    int titleHeight;
    int textHeight;
}


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
    self.title = _titleText;
        [self.tableView reloadData];
}

-(void)loadNews
{
    
    NSURL *newsUrl = [NSURL URLWithString:self.url];
    NSData *newsHtmlData = [NSData dataWithContentsOfURL:newsUrl];
    TFHpple *newsParser  = [TFHpple hppleWithHTMLData:newsHtmlData];
    
    //title
    NSString *titleXpath = @"//header[@class='narrow']/div[@class='h1']";
    NSArray *titleNode = [newsParser searchWithXPathQuery:titleXpath];
    for (TFHppleElement *element in titleNode) {
       _titleText = [[element firstChild] content];
        NSLog(@"%@", [[element firstChild] content]);
    }
    
    //imageURL
    NSString *imageXpath = @"//main[@class='ST-Artykul']/div[@class='bigFoto']/span/img";
    NSArray *imageNode = [newsParser searchWithXPathQuery:imageXpath];
    for (TFHppleElement *element in imageNode) {
        _imageUrl = [element objectForKey:@"src"];
        NSLog(@"%@", [element objectForKey:@"src"]);
    }
    
    //article
    NSString *artXpath = @"//main[@class='ST-Artykul']/div[@id='intertext1']";
    NSArray *artNode = [newsParser searchWithXPathQuery:artXpath];
    for (TFHppleElement *element in artNode) {
        _article = [[element firstChild] content];
        NSLog(@"rfsd %@", [[element firstChild] content]);
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

- (CGFloat)getLabelHeight:(UILabel*)label
{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if(indexPath.row == 0)
    {
        TitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil)
        {
            cell = [TitleTableViewCell new];
        }
        cell.title.text = _titleText;
        
        titleHeight = [self getLabelHeight:cell.title];
        NSLog(@"%d", titleHeight);
        
        return cell;
    } else if (indexPath.row == 1)
    {
        ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageTableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil)
        {
            cell = [ImageTableViewCell new];
        }
        NSURL * url = [NSURL URLWithString:_imageUrl];
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:imageData];
        cell.image.image = image;

        
        return cell;

    }
    else if (indexPath.row == 2)
    {
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextTableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (cell == nil)
        {
            cell = [TextTableViewCell new];
        }
        cell.textField.text = _article;
        textHeight = [self getLabelHeight:cell.textField];

        
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
        return titleHeight;
    }
    else if (indexPath.row == 1)
    {
        return 178;
    }
    else if (indexPath.row == 2)
    {
        return textHeight;
    }
    return 0;
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
