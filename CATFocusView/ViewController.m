//
//  ViewController.m
//  CATFocusView
//
//  Created by zengcatch on 16/6/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "ViewController.h"
#import "CATFocusView.h"

@interface ViewController ()<CATFocusViewDelegate>

@property (weak, nonatomic) IBOutlet CATFocusView *focusView;
@property (nonatomic, strong) UIView* customView;
@property (nonatomic, strong) CATFocus* focus;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _focusView.delegate = self;
    _focus = [_focusView addCircleFocusWithCenterPoint:CGPointMake(200, 200) radius:25];
    
    [_focusView addRectFocusOnRect:CGRectMake(0,0, 100,100)];
    
    [_focusView addRectFocusOnRect:CGRectMake(100,100, 100,30) cornerRadius:10.0f];
    
    _customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _customView.backgroundColor = [UIColor redColor];
    
    [_focusView addCustomView:_customView withFocus:_focus position:CATFocusPositionRight offset:CATOffsetMake(0,0)];
}

- (void)focusView:(CATFocusView *)focusView didSelectFocusAtIndex:(NSUInteger)index{
    [focusView removeCustomView:_customView];
}

- (void)focusView:(CATFocusView *)focusView didSelectCustomView:(UIView *)view{
    [focusView removeFocus:_focus];
}

@end