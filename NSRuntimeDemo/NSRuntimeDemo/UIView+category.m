//
//  UIView+category.m
//  RuntimeDemo
//
//  Created by JLee Chen on 16/7/7.
//  Copyright © 2016年 NanJin Chen. All rights reserved.
//

#import "UIView+category.h"
#import <objc/runtime.h>

@implementation UIView (category)

/******************************************************************************************
 
                                        给类动态添加属性
 
 ******************************************************************************************/

- (void) setName:(NSString *)name
{
    // 第一个参数：给哪个对象添加关联
    // 第二个参数：关联的key，通过这个key获取
    // 第三个参数：关联的value
    // 第四个参数:关联的策略
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *) name
{
    // 根据关联的key，获取关联的值。
    return objc_getAssociatedObject(self, @"name");
}

/******************************************************************************************
 
                                            给类动态添加方法
 
 ******************************************************************************************/
void newMethod(id self,SEL sel)
{
     NSLog(@"it's %@",NSStringFromSelector(sel));
}

+ (BOOL) resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(newMethod)) {
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号(名字)
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(newMethod), newMethod, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

@end
