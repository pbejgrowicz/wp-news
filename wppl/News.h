//
//  News.h
//  wppl
//
//  Created by Speednet on 25.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *desc;

@end
