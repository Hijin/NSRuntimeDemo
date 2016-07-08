//
//  Students.h
//  RuntimeDemo
//
//  Created by JLee Chen on 16/7/7.
//  Copyright © 2016年 NanJin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Students : NSObject

@property (copy , nonatomic) NSString *name;
@property (assign , nonatomic) NSInteger age;

+ (instancetype) initWithDictionary:(NSDictionary *) dic;

@end
