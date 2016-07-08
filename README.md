`NSRuntime`运行时，可以在程序运行时创建，检查，修改类，对象和它们的方法,在项目中用的很多，在此不多做介绍，这个Demo介绍了其中几种较为常用的场景方法。

####交换方法
系统自带的方法功能不够，给系统自带的方法扩展一些功能，并且保持原有的功能。
在UIViewController+category.h中
```
+ (void) load
{

Method originMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
Method newMethod = class_getInstanceMethod(self, @selector(myViewWillAppear));


//当运行方法 -（void）viewWillAppear:(BOOL)animated时会调用- (void) myViewWillAppear方法的实现方法
method_exchangeImplementations(originMethod, newMethod);
}

- (void) myViewWillAppear
{
//统一设置背景色
if (![self isKindOfClass:NSClassFromString(@"UIInputWindowController")]) {
NSLog(@"it's myViewWillAppear %@",NSStringFromClass([self class]));
self.view.backgroundColor = [UIColor redColor];

//调用原方法-（void）viewWillAppear:(BOOL)animated的实现方法
[self myViewWillAppear];
}

}
```

####给类动态添加方法
在UIView+category.h中
```
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
```
在ViewController中使用name属性
```
//给类UIView动态添加属性
UIView *v = [[UIView alloc] init];
v.name = @"it's a new property";
NSLog(@"%@",v.name);
```

####给类动态添加方法
在UIView+category.h中
```
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
```
在ViewController中使用newMethod方法
```
[v newMethod];
```

####字典转模型
在项目中经常会用到把json数据转为模型,如对象Student
```
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
```
在ViewController中把字典转为对象模型
```
NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
@"jin",@"name",
@"20",@"age", nil];
Students *stu = [Students initWithDictionary:dic];
```

此外，NSRunTime还有很多其他的用途等，如消息发送等，NSRunTime功能强大，用好了对项目有很大改进。

有问题欢迎指出，以后会更新添加其他功能。QQ：1553877174    微信：cnj901212 邮箱：1553877174@qq.com