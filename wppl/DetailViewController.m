//
//  DetailViewController.m
//  wppl
//
//  Created by Speednet on 26.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()


@end

@implementation DetailViewController

@synthesize url = _url;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    
    [self loadNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        //self.titleLabel.text = [[element firstChild] content];
        NSLog(@"dsfdsfds");
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"NewsTableViewCell";
    
   /* NewsTableViewCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.delegate = self;
    
    if (cell == nil)
    {
        cell = [NewsTableViewCell new];
    }
    UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,cell.frame.size.height-3,cell.frame.size.width*5,3)];
    additionalSeparator.backgroundColor = [UIColor grayColor];
    [cell addSubview:additionalSeparator];
    News *news = [_objects objectAtIndex:indexPath.row];
    cell.news = news;
    cell.titleLabel.text = news.title;
    cell.descLabel.text = news.desc;
    NSURL * imageURL = [NSURL URLWithString:news.imageUrl];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    cell.iconView.image = image;*/
    return nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
