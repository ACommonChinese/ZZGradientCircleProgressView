//
//  ViewController.m
//  ZZGradientCircleProgressView
//
//  Created by 刘威振 on 12/22/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import "ViewController.h"
#import "ZZGradientCircleProgressView.h"

@interface ViewController ()

@property (nonatomic) ZZGradientCircleProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.progressView = [[ZZGradientCircleProgressView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    
    [self addCrossLine];
    
    _progressView.backgroundColor = [UIColor yellowColor];
    _progressView.trackColor      = [UIColor whiteColor];
    _progressView.progress        = 0.0f;
    _progressView.progressWidth   = 20;
    // _progressView.gradientColors  = @[[UIColor redColor], [UIColor greenColor]];
    _progressView.gradientColor = [UIColor orangeColor];
    [self.view addSubview:_progressView];
}

- (IBAction)click:(id)sender {
    self.progressView.progress += 0.05;
}

- (void)addCrossLine {
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMidY(_progressView.bounds), CGRectGetWidth(_progressView.bounds), 1)];
    hView.backgroundColor = [UIColor redColor];
    [_progressView addSubview:hView];
    
    UIView *yView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(_progressView.bounds), 0, 1, CGRectGetHeight(_progressView.bounds))];
    yView.backgroundColor = [UIColor redColor];
    [_progressView addSubview:yView];
}

@end
