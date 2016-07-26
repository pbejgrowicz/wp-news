//
//  ViewController.m
//  wp news
//
//  Created by Speednet on 25.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *_objects;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Polska - wiadomości";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerNib:[UINib
                                 nibWithNibName:NSStringFromClass([NewsTableViewCell class]) bundle:
                                 [NSBundle mainBundle]] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self loadNews];
    [self.tableView reloadData];
}

-(void)loadNews
{
    NSURL *newsUrl = [NSURL URLWithString:@"http://wiadomosci.wp.pl/kat,1342,name,Polska,kategoria.html"];
    NSData *newsHtmlData = [NSData dataWithContentsOfURL:newsUrl];
    
    TFHpple *newsParser  = [TFHpple hppleWithHTMLData:newsHtmlData];
    NSString *newsXpath = @"//ul[@class='wiadomosciLst']/li[@class='first']/p/a";
    NSString *imageNewsXpath = @"//ul[@class='wiadomosciLst']/li[@class='first']/a[@class='ikonka']/img";
    NSArray *imageNodes = [newsParser searchWithXPathQuery:imageNewsXpath];
    NSArray *newsNodes = [newsParser searchWithXPathQuery:newsXpath];
    NSMutableArray *newNews = [[NSMutableArray alloc] initWithCapacity:0];
    NSUInteger count = 0;
    for (TFHppleElement *element in newsNodes) {
        News *news = [[News alloc] init];
        //nie dodawanie podwójnych newsów
        if([[[element firstChild] content] isEqualToString:@"."])
            continue;
        [newNews addObject:news];
        
        news.title = [element objectForKey:@"title"];
        news.url = [element objectForKey:@"href"];
        news.desc = [[element firstChild] content];
        news.imageUrl = [[imageNodes objectAtIndex:count] objectForKey:@"src"];
        count++;
        //NSLog(@"%@\n", news.imageUrl);
    }
    
    
    _objects = newNews;
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)reloadTable:(id)sender
{
    [self.tableView reloadData];
    [self loadNews];
}

//table view methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"NewsTableViewCell";
    
    NewsTableViewCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    
    if (cell == nil)
    {
        cell = [NewsTableViewCell new];
    }
    
    UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,cell.frame.size.height-10,cell.frame.size.width*5,10)];
    
    additionalSeparator.backgroundColor = [UIColor lightGrayColor];
    [cell addSubview:additionalSeparator];
    News *news = [_objects objectAtIndex:indexPath.row];
    cell.news = news;
    cell.titleLabel.text = news.title;
    cell.descLabel.text = news.desc;
    NSURL * imageURL = [NSURL URLWithString:news.imageUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    cell.iconView.image = image;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
(NSIndexPath *)indexPath
{
    return 350;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return;
    [self cellTapped:[self.tableView cellForRowAtIndexPath:indexPath]];
}

- (void)cellTapped:(NewsTableViewCell*)cell
{
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://wiadomosci.wp.pl%@",cell.news.url]];
    //[[UIApplication sharedApplication] openURL:url];
    
    NewsTableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsTableViewController"];
    viewController.url = [NSString stringWithFormat:@"http://wiadomosci.wp.pl%@",cell.news.url];
    [self.navigationController pushViewController:viewController animated:YES];
    
    
    // return;
}



@end
