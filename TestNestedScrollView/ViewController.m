//
//  ViewController.m
//  TestNestedScrollView
//
//  Created by liujing on 8/24/16.
//  Copyright © 2016 liujing. All rights reserved.
//

#import "ViewController.h"
#define SCROLLVIEW_HEIGHT 400
#define SCROLLVIEW_LEFT_PADDING 80
#define CELL_COUNT 12
#define CELL_HEIGHT 40

@interface ViewController ()
{
    UIScrollView *scrollview;
    UIScrollView *bigScrollView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addScrollview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addScrollview{
    
    bigScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), SCROLLVIEW_HEIGHT)];
    [self.view addSubview:bigScrollView];
    
    
    //此时scrollview的frame相对的是bigScrollView的内容视图而不是其frame，所以高度应设置为CELL_HEIGHT*CELL_COUNT才不会显示不全
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(SCROLLVIEW_LEFT_PADDING, 0, CGRectGetWidth(self.view.frame)-SCROLLVIEW_LEFT_PADDING, CELL_HEIGHT*CELL_COUNT)];
    [bigScrollView addSubview:scrollview];
    
    
    bigScrollView.delegate = self;
    scrollview.delegate = self;
    
    
    //content宽设置为屏宽则无法左右滑动
    bigScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CELL_COUNT*CELL_HEIGHT);
    
    bigScrollView.showsHorizontalScrollIndicator = NO;
    bigScrollView.showsVerticalScrollIndicator = NO;
    bigScrollView.bounces = NO;//弹簧效果
    bigScrollView.directionalLockEnabled = YES;//定向锁定
    
    
    //content高设置为scrollview的frame的高度则无法上下滑动
    scrollview.contentSize = CGSizeMake(1.5*scrollview.frame.size.width, CELL_COUNT*CELL_HEIGHT);
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.bounces = NO;//弹簧效果
    scrollview.directionalLockEnabled = YES;//定向锁定
    
    [self addSubViewsForBigScrollView];
    [self addSubViewsForScrollView];
    
}

-(void)addSubViewsForScrollView{
    for (int i =0; i<CELL_COUNT; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i*CELL_HEIGHT, 1.5*scrollview.frame.size.width, CELL_HEIGHT)];
        label.text = [NSString stringWithFormat:@"%d~~~~~~~~~~~~~~~~%d",i,i];
        label.textColor = [UIColor orangeColor];
        label.backgroundColor = [UIColor grayColor];
        [scrollview addSubview:label];
    }
}

-(void)addSubViewsForBigScrollView{
    for (int i =0; i<CELL_COUNT; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i*CELL_HEIGHT, SCROLLVIEW_LEFT_PADDING, CELL_HEIGHT)];
        label.text = [NSString stringWithFormat:@"header%d",i];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor darkGrayColor];
        [bigScrollView addSubview:label];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    if (scrollView1==bigScrollView) {
        NSLog(@"big scrollview");
    }
    else
    {
        NSLog(@"scrollview");
    }
}
@end
