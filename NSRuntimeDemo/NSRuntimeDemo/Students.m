//
//  Students.m
//  RuntimeDemo
//
//  Created by JLee Chen on 16/7/7.
//  Copyright © 2016年 NanJin Chen. All rights reserved.
//

#import "Students.h"
#import <objc/runtime.h>

@implementation Students

/******************************************************************************************
 
                                    字典转模型
 
 ******************************************************************************************/

+ (instancetype) initWithDictionary:(NSDictionary *) dic
{
    Students *stu = [[self alloc] init];
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++ ) {
        
        Ivar ivar = ivarList[i];
        
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        NSString *propertyType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        NSString *key = [propertyName substringFromIndex:1];
        
        id value = dic[key];
        
        if (value) {
            [stu setValue:value forKey:key];
        }
        
    }
    
    return stu;
}
@end
