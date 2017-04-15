//
//  PerformSelectorViewController.m
//  PLHPerformDemo
//
//  Created by peilinghui on 2017/4/15.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PerformSelectorViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>


typedef struct ParameterStruct{
    int a;
    int b;
}MyStruct;

@interface PerformSelectorViewController ()


@end

@implementation PerformSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *firstBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 100, 50)];
    [firstBtn setTitle:@"NoParemeter" forState:UIControlStateNormal];
    [firstBtn setBackgroundColor:[UIColor blueColor]];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [firstBtn addTarget:self action:@selector(NoParameterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    
    
    UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(140, 100, 100, 50)];
    [secondBtn setTitle:@"OneParemeter" forState:UIControlStateNormal];
    [secondBtn setBackgroundColor:[UIColor blueColor]];
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [secondBtn addTarget:self action:@selector(OneParameterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
    
    UIButton *thirdBtn = [[UIButton alloc]initWithFrame:CGRectMake(260, 100, 100, 50)];
    [thirdBtn setTitle:@"TwoParemeter" forState:UIControlStateNormal];
    [thirdBtn setBackgroundColor:[UIColor blueColor]];
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [thirdBtn addTarget:self action:@selector(TwoParameterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];

    UIButton *forthBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 180, 100, 50)];
    [forthBtn setTitle:@"DynamicClick" forState:UIControlStateNormal];
    [forthBtn setBackgroundColor:[UIColor blueColor]];
    forthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forthBtn addTarget:self action:@selector(DynamicClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forthBtn];

    UIButton *fifthBtn = [[UIButton alloc]initWithFrame:CGRectMake(140, 180, 100, 50)];
    [fifthBtn setTitle:@"NSInvocation" forState:UIControlStateNormal];
    [fifthBtn setBackgroundColor:[UIColor redColor]];
    fifthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [fifthBtn addTarget:self action:@selector(NSInvocationClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fifthBtn];

    UIButton *sixthBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 180, 100, 50)];
    [sixthBtn setBackgroundColor:[UIColor redColor]];
    [sixthBtn setTitle:@"objc_msgSend" forState:UIControlStateNormal];
    sixthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sixthBtn addTarget:self action:@selector(ObjcMsgSendClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sixthBtn];
    
    UIButton *seventhBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 260, 100, 50)];
    [seventhBtn setBackgroundColor:[UIColor redColor]];
    [seventhBtn setTitle:@"StructParameter" forState:UIControlStateNormal];
    seventhBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [seventhBtn addTarget:self action:@selector(StruckClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seventhBtn];
    
    UIButton *eighth = [[UIButton alloc] initWithFrame:CGRectMake(140, 260, 150, 50)];
    [eighth setBackgroundColor:[UIColor redColor]];
    [eighth setTitle:@"StructParameter_Two" forState:UIControlStateNormal];
    eighth.titleLabel.font = [UIFont systemFontOfSize:13];
    [eighth addTarget:self action:@selector(StruckTwoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eighth];

}

#pragma mark --Click Method
-(void)NoParameterClick{
    [self performSelector:@selector(SelectorNoParamter)];
}

-(void)OneParameterClick{
    [self performSelector:@selector(SelectorOneParameter:) withObject:@"firstNumber"];
}

-(void)TwoParameterClick{
    [self performSelector:@selector(SelectorFirstParameter:SecondParameter:) withObject:@"firstNumber" withObject:@"SecondNumber"];
    
}

-(void)DynamicClick{
    //把多个参数封装成一个参数：用字典或集合数组
    NSArray *object = @[
                            @{@"methodName":@"DynamicParameterString:",@"value":@"调用DynamicParameterString方法"},
                            @{@"methodName":@"DynamicParameterNumber:",@"value":@22},
                            @{@"methodName":@"DynamicParameterString:",@"value":@"调用DynamicParameterString方法" }
                            ];
    for (NSDictionary *dic in object) {
        [self performSelector:NSSelectorFromString([dic objectForKey:@"methodName"]) withObject:[dic objectForKey:@"value"]];
    }
}

//传递三个及以上的参数用NSInvocation
-(void)NSInvocationClick{
    NSString *str = @"使用NSInvocation来传入多个参数";
    NSNumber *num = @3;
    NSArray *arr = @[@"数组1",@"数组2",@"数组3"];
    
    SEL sel = NSSelectorFromString(@"NSinvocationWithString:withNum:withArray:");
    NSArray *objects = [NSArray arrayWithObjects:str,num,arr, nil];
    [self performSelectorOnMainThread:sel withObject:objects waitUntilDone:YES];
}

-(void)ObjcMsgSendClick{
    NSString *str = @"使用objc_msgSend来传入多个参数";
    NSNumber *num = @4;
    NSArray *arr = @[@"数组1",@"数组2",@"数组3"];
    
    SEL sel = NSSelectorFromString(@"ObjcMsgSendWithString:withNum:withArray:");
    
    ((void(*)(id,SEL,NSString *,NSNumber *,NSArray *))objc_msgSend)(self,sel,str,num,arr);
    
}

-(void)StruckClick{
    NSString *str = @"使用objc_msgSend来传入结构体";
    NSNumber *num = @5;
    NSArray *arr = @[@"数组1",@"数组2",@"数组3"];
    MyStruct myStruct = {10,20};
    
    SEL sel = NSSelectorFromString(@"ObjcMsgSendWithString:withNum:withArray:withStruct:");
    
    ((void(*)(id,SEL,NSString *,NSNumber *,NSArray *,MyStruct))objc_msgSend)(self,sel,str,num,arr,myStruct);
    

}

-(void)StruckTwoClick{
    NSString *str = @"字符串 把结构体转换为对象";
    NSNumber *num = @20;
    NSArray *arr = @[@"数组值1", @"数组值2"];
    
    MyStruct mystruct = {10,20};

    NSValue *value = [NSValue valueWithBytes:&mystruct objCType:@encode(MyStruct)];
    
    SEL sel = NSSelectorFromString(@"NSinvocationWithString:withNum:withArray:withValue:");
    NSArray *objs = [NSArray arrayWithObjects:str,num,arr,value, nil];
    
    [self performSelector:sel withObjects:objs];
}


#pragma mark --PerformSelector
-(void)SelectorNoParamter{
    NSLog(@"SelectorNoParamter");
}

-(void)SelectorOneParameter:(NSString *)first{
    NSLog(@"SelectorOneParameter:%@",first);
}

-(void)SelectorFirstParameter:(NSString *)first SecondParameter:(NSString *)second{
    NSLog(@"SeletorTwoParameter:%@, %@",first,second);
}

//动态点击调用的两个方法
-(void)DynamicParameterString:(NSString *)string{
    NSLog(@"根据dic的 key调用方法DynamicParameterString：%@",string);
}
-(void)DynamicParameterNumber:(NSNumber *)number{
    NSLog(@"根据dic的 key调用方法DynamicParameterNumber：%@",number);
}


//传递三个及以上的参数用NSInvocation
-(void)NSinvocationWithString:(NSString *)string withNum:(NSNumber *)num withArray:(NSArray *)array{
    NSLog(@"调用NSInvocationWithString传递的3个参数string:%@,num:%@,array:%@",string,num,array[0]);
}

//在主线程上调用
-(void)performSelectorOnMainThread:(SEL)aSelector withObject:(NSArray *)objects waitUntilDone:(BOOL)wait{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    if (signature == nil) {
        
        //可以抛出异常也可以不操作。
    }
    
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:aSelector];
    
    //设置参数
    NSInteger paramsCounter = signature.numberOfArguments-2;// 除self、_cmd以外的参数个数
    paramsCounter = MIN(paramsCounter,objects.count);
    for (NSInteger i=0; i<paramsCounter; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i+2];
    }
        [invocation retainArguments];
    [invocation performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:wait];
}

//ObjcMsgSendClick点击调用的SEL
- (void)ObjcMsgSendWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array {
    NSLog(@"调用ObjcMsgSendWithString%@,num: %@, array:%@", string, number, array[0]);
}

-(void)ObjcMsgSendWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array withStruct:(MyStruct)mystruct{
    NSLog(@"调用ObjcMsgSendWithString处理结构体：%@，num:%@, array:%@,struct:%d",string,number,array[1],mystruct.b);
}

-(void)NSinvocationWithString:(NSString *)string withNum:(NSNumber *)num withArray:(NSArray *)array withValue:(NSValue *)value{
    MyStruct structGroup;
    [value getValue:&structGroup];
    NSLog(@"NSinvocationWithString传递的参数string:%@，num:%@,array:%@,结构体的值：%d",string,num,array[1],structGroup.a);
}

//多个参数objects
-(id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects{
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (signature == nil) {
        
        //可以抛出异常也可以不操作。
    }
    
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, objects.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    // 调用方法
    [invocation invoke];

    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
}


@end
