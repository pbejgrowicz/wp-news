//
//  News.h
//  wppl
//
//  Created by Speednet on 25.07.2016.
//  Copyright © 2016 Speednet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *url;
@property (weak, nonatomic) NSString *imageUrl;
@property (weak, nonatomic) NSString *desc;

@end
