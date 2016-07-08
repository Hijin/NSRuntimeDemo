//
//  ViewController.m
//  NSRuntimeDemo
//
//  Created by JLee Chen on 16/7/8.
//  Copyright © 2016年 NanJin Chen. All rights reserved.
//

#import "ViewController.h"
#import "UIView+category.h"
#import "SecondVC.h"
#import "Students.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *bt  = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [bt setTitle:@"nextVC" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(gotoNextVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    
    
    //给类UIView动态添加属性
    UIView *v = [[UIView alloc] init];
    v.name = @"it's a new property";
    NSLog(@"%@",v.name);
    
    [v newMethod];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"jin",@"name",
                         @"20",@"age", nil];
    Students *stu = [Students initWithDictionary:dic];
    
    NSLog(@"stu's name:%@    stu's age:%ld",stu.name,stu.age);
}

- (void) viewWillAppear:(BOOL)animated
{
    NSLog(@"origin ViewWillAppear");
}

- (void)gotoNextVC
{
    SecondVC *secondVC = [[SecondVC alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
