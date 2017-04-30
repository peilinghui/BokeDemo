//
//  ViewController.m
//  FrameAndBoundsDemo
//
//  Created by peilinghui on 2017/4/21.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buttonView];
//    NSLog(@"对于6s屏幕的self.view.frame = %@,self.view.bounds=%@",NSStringFromCGRect(self.view.frame),NSStringFromCGRect(self.view.bounds));
//    //对于6s屏幕的self.view.frame = {{0, 0}, {375, 667}},self.view.bounds={{0, 0}, {375, 667}}
//    
//#pragma mark --   例子1
//    //旋转一个自定义view后，frame改变了，而bounds没有改变
//    UIView *View1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 50,50)];
//    View1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:View1];
//    NSLog(@"自定义子view的self.view.frame = %@",NSStringFromCGRect(View1.frame));
//    //自定义子view的self.view.frame = {{100, 100}, {50, 50}}
//    NSLog(@"自定义子view的self.view.bounds=%@",NSStringFromCGRect(View1.bounds));
//    //自定义子view的self.view.bounds={{0, 0}, {50, 50}}
//
//    [UIView transitionWithView:View1 duration:2 options:0 animations:^{
//        View1.transform = CGAffineTransformMakeRotation(M_PI_4);
//    }completion:^(BOOL finished){
//    if (finished)
//        {
//            NSLog(@"旋转后子view的self.view.frame = %@",NSStringFromCGRect(View1.frame));
//            //旋转后子view的self.view.frame = {{89.644660940672622, 89.644660940672622}, {70.710678118654755, 70.710678118654755}}
//
//            NSLog(@"旋转后子view的self.view.bounds=%@",NSStringFromCGRect(View1.bounds));
//            //旋转后子view的self.view.bounds={{0, 0}, {50, 50}}
//        }
//    }];
 
#pragma mark --例子2
    //我们把一个子View放到父View中
    UIView *fatherView = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    fatherView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:fatherView];
    
    UIView *sunView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    sunView.backgroundColor = [UIColor redColor];
    [fatherView addSubview:sunView];
    
    NSLog(@"父view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(fatherView.frame),NSStringFromCGRect(fatherView.bounds),NSStringFromCGPoint(fatherView.center));
    //父view的frame = {{100, 100}, {200, 200}},bounds={{0, 0}, {200, 200}},中心点=：{200, 200}
    
    NSLog(@"子view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(sunView.frame),NSStringFromCGRect(sunView.bounds),NSStringFromCGPoint(sunView.center));
    //子view的frame = {{0, 0}, {50, 50}},bounds={{0, 0}, {50, 50}},中心点=：{25, 25}
    
    
//    //1. 改变父View的bounds的位置,父view的bounds改变了
//    [UIView animateWithDuration:4 animations:^{
//        [fatherView setBounds:CGRectMake(30, 30, 200, 200)];
//    }completion:^(BOOL finished){
//        NSLog(@"改变父坐标bounds的位置后父view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(fatherView.frame),NSStringFromCGRect(fatherView.bounds),NSStringFromCGPoint(fatherView.center));
//        // 改变父坐标bounds的位置后父view的frame = {{100, 100}, {200, 200}},bounds={{30, 30}, {200, 200}},中心点=：{200, 200}
//
//        NSLog(@"改变父坐标bounds的位置后子view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(sunView.frame),NSStringFromCGRect(sunView.bounds),NSStringFromCGPoint(sunView.center));
//        //改变父坐标bounds的位置后子view的frame = {{0, 0}, {50, 50}},bounds={{0, 0}, {50, 50}},中心点=：{25, 25}
//    }];

    
//    //2. 改变父View的bounds的大小,父view的frame和bounds都改变了
//    [UIView animateWithDuration:4 animations:^{
//        [fatherView setBounds:CGRectMake(0, 0,100, 100)];
//    }completion:^(BOOL finished){
//        NSLog(@"改变父坐标bounds的大小后父view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(fatherView.frame),NSStringFromCGRect(fatherView.bounds),NSStringFromCGPoint(fatherView.center));
//        //改变父坐标bounds的大小后父view的frame = {{150, 150}, {100, 100}},bounds={{0, 0}, {100, 100}},中心点=：{200, 200}
//
//        NSLog(@"改变父坐标bounds的大小后子view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(sunView.frame),NSStringFromCGRect(sunView.bounds),NSStringFromCGPoint(sunView.center));
//        //改变父坐标bounds的大小后子view的frame = {{0, 0}, {50, 50}},bounds={{0, 0}, {50, 50}},中心点=：{25, 25}
//    }];

    
  // 3. 修改子视图的bounds的位置,子view的bounds改变了。但是图像并没有改变
//    [UIView animateWithDuration:4 animations:^{
//        [sunView setBounds:CGRectMake(-30, -30, 50, 50)];
//    }completion:^(BOOL finished){
//        NSLog(@"改变子坐标bounds的位置后父view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(fatherView.frame),NSStringFromCGRect(fatherView.bounds),NSStringFromCGPoint(fatherView.center));
//        //改变子坐标bounds的位置后父view的frame = {{100, 100}, {200, 200}},bounds={{0, 0}, {200, 200}},中心点=：{200, 200}
//        
//        NSLog(@"改变子坐标bounds的位置后子view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(sunView.frame),NSStringFromCGRect(sunView.bounds),NSStringFromCGPoint(sunView.center));
//        //改变子坐标bounds的位置后子view的frame = {{0, 0}, {50, 50}},bounds={{30, 30}, {50, 50}},中心点=：{25, 25}
//    }];

 // 4. 修改子视图的bounds的大小,子view的frame,bounds改变了
//    [UIView animateWithDuration:4 animations:^{
//        [sunView setBounds:CGRectMake(0, 0, 80, 80)];
//    }completion:^(BOOL finished){
//        NSLog(@"改变子坐标bounds的位置后父view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(fatherView.frame),NSStringFromCGRect(fatherView.bounds),NSStringFromCGPoint(fatherView.center));
//        //改变子坐标bounds的位置后父view的frame = {{100, 100}, {200, 200}},bounds={{0, 0}, {200, 200}},中心点=：{200, 200}
//        
//        NSLog(@"改变子坐标bounds的位置后子view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(sunView.frame),NSStringFromCGRect(sunView.bounds),NSStringFromCGPoint(sunView.center));
//        //改变子坐标bounds的位置后子view的frame = {{-15, -15}, {80, 80}},bounds={{0, 0}, {80, 80}},中心点=：{25, 25}
//
//    }];

    

    //改变父view的frame的位置,父view的frame改变了，中心点改变了
//    [UIView animateWithDuration:5 animations:^{
//        [fatherView setFrame:CGRectMake(30, 30, 200, 200)];
//    }completion:^(BOOL finished){
//        NSLog(@"改变父坐标frame的位置后父view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(fatherView.frame),NSStringFromCGRect(fatherView.bounds),NSStringFromCGPoint(fatherView.center));
//        //变父坐标frame的位置后父view的frame = {{30, 30}, {200, 200}},bounds={{0, 0}, {200, 200}},中心点=：{130, 130}
//        
//        NSLog(@"改变父坐标frame的位置后子view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(sunView.frame),NSStringFromCGRect(sunView.bounds),NSStringFromCGPoint(sunView.center));
//        //改变父坐标frame的位置后子view的frame = {{0, 0}, {50, 50}},bounds={{0, 0}, {50, 50}},中心点=：{25, 25}
//    }];

    //改变父view的frame的大小,父view的bounds，frame，和中心点都改变了
//    [UIView animateWithDuration:5 animations:^{
//        [fatherView setFrame:CGRectMake(0,0,100,100)];
//    }completion:^(BOOL finished){
//        NSLog(@"改变父坐标frame的大小后父view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(fatherView.frame),NSStringFromCGRect(fatherView.bounds),NSStringFromCGPoint(fatherView.center));
//        //改变父坐标frame的大小后父view的frame = {{100, 100}, {100, 100}},bounds={{0, 0}, {100, 100}},中心点=：{150, 150}
//        
//        NSLog(@"改变父坐标frame的大小后子view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(sunView.frame),NSStringFromCGRect(sunView.bounds),NSStringFromCGPoint(sunView.center));
//        //改变父坐标frame的大小后子view的frame = {{0, 0}, {50, 50}},bounds={{0, 0}, {50, 50}},中心点=：{25, 25}
//    }];
//
    // 修改子视图的frame的位置,子view的frame，中心点改变了。
//        [UIView animateWithDuration:4 animations:^{
//            [sunView setFrame:CGRectMake(30, 30, 50, 50)];
//        }completion:^(BOOL finished){
//            NSLog(@"改变子坐标frame的位置后父view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(fatherView.frame),NSStringFromCGRect(fatherView.bounds),NSStringFromCGPoint(fatherView.center));
//            //改变子坐标frame的位置后父view的frame = {{100, 100}, {200, 200}},bounds={{0, 0}, {200, 200}},中心点=：{200, 200}
//    
//            NSLog(@"改变子坐标frame的位置后子view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(sunView.frame),NSStringFromCGRect(sunView.bounds),NSStringFromCGPoint(sunView.center));
//            //改变子坐标frame的位置后子view的frame = {{30, 30}, {50, 50}},bounds={{0, 0}, {50, 50}},中心点=：{55, 55}
//
//        }];
//
    // 修改子视图的bounds的大小,子view的frame,bounds,中心点改变了
        [UIView animateWithDuration:4 animations:^{
            [sunView setFrame:CGRectMake(0, 0, 80, 80)];
        }completion:^(BOOL finished){
            NSLog(@"改变子坐标frame的位置后父view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(fatherView.frame),NSStringFromCGRect(fatherView.bounds),NSStringFromCGPoint(fatherView.center));
            //改变子坐标frame的位置后父view的frame = {{100, 100}, {200, 200}},bounds={{0, 0}, {200, 200}},中心点=：{200, 200}
    
            NSLog(@"改变子坐标frame的位置后子view的frame = %@,bounds=%@,中心点=：%@",NSStringFromCGRect(sunView.frame),NSStringFromCGRect(sunView.bounds),NSStringFromCGPoint(sunView.center));
            //改变子坐标frame的位置后子view的frame = {{0, 0}, {80, 80}},bounds={{0, 0}, {80, 80}},中心点=：{40, 40}
    
        }];

}


/**
 * 
 (1)bounds的x,y不一定为0，其实默认是(0,0),除非调用了setBounds方法；
 (2)frame的size不一定等于bounds的size，可以把一个view旋转后比较；
 (3)frame的x，y是随意的，是相对于父视图的坐标位置；
 (4)Frame is in terms of superview's coordinate system;
 Bounds is in terms of local coordinate system;
 (5)bounds是修改自己坐标系的原点位置，进而影响到子view的显示位置。
 (6)setBounds也可以修改view的大小，进而修改frame。
 (7)setBounds可以修改子view的位置。setFrame可以主动修改自己在父view中的位置。
 (8)更改bounds的大小，bounds的大小代表当前视图的长和宽，修改长宽后，中心点继续保持不变，长宽进行改变，通过bounds修改长宽就像是以中心点为基准点对长宽两边同时进行缩放。
 (9)frame不管对于位置还是大小，改变的都是自己本身。
 (10)frame的位置是以父视图的坐标系为参照，从而确定当前视图在父视图中的位置。
 (11)frame的大小改变时，当前视图的左上角位置不会发生改变，只是大小发生改变。
 ------
 (12)bounds改变位置时，改变的是子视图的位置，自身没有影响。其实就是改变了本身的坐标系原点。，默认本身坐标系原点是左上角。
 (13)bounds的大小改变时，当前视图的中心点不会发生改变，当前视图的大小发生改变，效果就像是缩放一样。
 (14)更改bounds的位置对于当前视图没有影响，相当于更改了当前视图的坐标系，对于子视图来说当前视图的左上角已经不是(0,0)，而是改变后的坐标，坐标系改了，那么所有子视图的位置也会跟着改变。
 (15)center是根据父容器的相对位置来计算的。无论是修改父容器的bounds或者自身的bounds，都不会改变center。况且使用bounds来缩放View，都是根据center中心点来缩放的，所以center不会改变。
 (16)使用frame改变view大小，center改变，因为缩放参考点为左上角。使用bounds改变view大小，center不变，因为缩放参考点为center。
 (17)个人总结：想修改view的位置而不影响其他，修改自身frame的位置；想修改view的大小，修改frame的大小或者bounds的大小（考虑相对位置的改变）。
 想修改viewA的所有子view的位置，修改viewA的bounds的位置（该父容器的坐标）。
 */

-(void)buttonView{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 390, 50, 50)];
    btn.backgroundColor = [UIColor grayColor];
    btn.titleLabel.text=@"bounds的应用";
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    
    [btn addTarget:self action:@selector(ClickEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}
-(void)ClickEvent{
    SecondViewController *vb = [[SecondViewController alloc]init];
    [self presentViewController:vb animated:YES completion:nil];
}
@end
