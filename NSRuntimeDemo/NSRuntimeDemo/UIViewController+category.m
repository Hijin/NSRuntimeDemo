//
//  UIViewController+category.m
//  RuntimeDemo
//
//  Created by JLee Chen on 16/7/7.
//  Copyright © 2016年 NanJin Chen. All rights reserved.
//

#import "UIViewController+category.h"
#import <objc/runtime.h>

@implementation UIViewController (category)

/******************************************************************************************
 
    交换实现方法：系统自带的方法功能不够，给系统自带的方法扩展一些功能，并且保持原有的功能
 
 ******************************************************************************************/

+ (void) load
{
    
    Method originMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method newMethod = class_getInstanceMethod(self, @selector(myViewWillAppear));
    
    
    //当运行方法 -（void）viewWillAppear:(BOOL)animated时会调用- (void) myViewWillAppear方法的实现方法
    method_exchangeImplementations(originMethod, newMethod);
}

- (void) myViewWillAppear
{
    if (![self isKindOfClass:NSClassFromString(@"UIInputWindowController")]) {
        NSLog(@"it's myViewWillAppear %@",NSStringFromClass([self class]));
        self.view.backgroundColor = [UIColor redColor];
        
        //调用原方法-（void）viewWillAppear:(BOOL)animated的实现方法
        [self myViewWillAppear];
    }
    
}

@end
