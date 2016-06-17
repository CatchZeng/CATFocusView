//
//  ViewController.m
//  CATFocusView
//
//  Created by zengcatch on 16/6/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "ViewController.h"
#import "CATFocusView.h"

@interface ViewController ()<CATFocusViewDelegate,UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet CATFocusView *focusView;
@property (nonatomic, assign) BOOL hasFinishLoaded;
@property (nonatomic, strong) CATFocus* focus1;
@property (nonatomic, strong) UIView* customView1;
@property (nonatomic, strong) CATFocus* focus2;
@property (nonatomic, strong) UILabel* customView2;
@property (nonatomic, strong) CATFocus* focus3;
@property (nonatomic, strong) UILabel* customView3;

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://taobao.com"]]];
    _webView.delegate = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if (_hasFinishLoaded) {
        return;
    }
    _hasFinishLoaded = YES;
    _focusView.delegate = self;
    
    [self _addFocus1];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)_addFocus1{
    _focus1 = [_focusView addCircleFocusWithCenterPoint:CGPointMake(20,40) radius:20];
    _customView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    [_focusView addCustomView:_customView1 withFocus:_focus1 position:CATFocusPositionBottom offset:CATOffsetMake(100,0)];
}

-(void)_addFocus2{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _focus2 = [_focusView addRectFocusOnRect:CGRectMake(.5f*(width-150),20,150,30) cornerRadius:10];
    
    _customView2 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,100,50)];
    _customView2.center = self.view.center;
    _customView2.text = @"Search";
    _customView2.textColor = [UIColor whiteColor];
    _customView2.font = [UIFont systemFontOfSize:30];
    [_focusView addCustomView:_customView2];
}

-(void)_addFocus3{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _focus3 = [_focusView addRectFocusOnRect:CGRectMake(width-100,height-80,100,30)];
    
    _customView3 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,100,50)];
    _customView3.center = self.view.center;
    _customView3.text = @"Finish";
    _customView3.textColor = [UIColor whiteColor];
    _customView3.font = [UIFont systemFontOfSize:30];
    
    [_focusView addCustomView:_customView3 withFocus:_focus3 position:CATFocusPositionTop offset:CATOffsetMake(0,0)];
}

- (void)focusView:(CATFocusView *)focusView didSelectFocusAtIndex:(NSUInteger)index{
    if (index == _focus1.index) {
        [focusView removeFocus:_focus1];
        [focusView removeCustomView:_customView1];
        
        [self _addFocus2];
        
    }else if(index == _focus2.index){
        [focusView removeFocus:_focus2];
        [focusView removeCustomView:_customView2];
        
        [self _addFocus3];
        
    }else if(index == _focus3.index){
        [focusView removeFromSuperview];
    }
}

- (void)focusView:(CATFocusView *)focusView didSelectCustomView:(UIView *)view{
    if (view == _customView1) {
        [focusView removeFocus:_focus1];
        [focusView removeCustomView:_customView1];
        
        [self _addFocus2];
        
    }else if(view == _customView2){
        [focusView removeFocus:_focus2];
        [focusView removeCustomView:_customView2];
        
        [self _addFocus3];
        
    }else if(view == _customView3){
        [focusView removeFromSuperview];
    }
}

@end