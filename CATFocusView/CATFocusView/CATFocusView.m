//
//  CATFocusView.m
//  CATFocusView
//
//  Created by zengcatch on 16/6/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "CATFocusView.h"

@interface CATFocusView()

@property (nonatomic, strong) NSMutableArray *arrayFocus;
@property (nonatomic, strong) NSMutableArray *arrayCustomView;

@end

@implementation CATFocusView

#pragma mark -- init

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    self.backgroundColor = [UIColor clearColor];
    _arrayFocus = [NSMutableArray array];
    _arrayCustomView = [NSMutableArray array];
    if (!_bgColor) {
        _bgColor = [UIColor colorWithWhite:0.0 alpha:0.7];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleTap:)];
    [self addGestureRecognizer:tapGesture];
}

#pragma mark -- public methods

-(CATCircleFocus *)addCircleFocusWithCenterPoint:(CGPoint)centerPoint radius:(CGFloat)radius{
    CATCircleFocus* focus = [[CATCircleFocus alloc]initWithCenterPoint:centerPoint radius:radius];
    [self _addFocus:focus];
    return focus;
}

-(CATRectFocus *)addRectFocusOnRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius{
    CATRectFocus* focus = [[CATRectFocus alloc]initWithFrame:rect cornerRadius:cornerRadius];
    [self _addFocus:focus];
    return focus;
}

-(CATRectFocus *)addRectFocusOnRect:(CGRect)rect{
    return [self addRectFocusOnRect:rect cornerRadius:0.0f];
}

-(void)addCustomView:(UIView *)view{
    [_arrayCustomView addObject:view];
    [self setNeedsDisplay];
}

-(void)addCustomView:(UIView *)view onRect:(CGRect)rect{
    view.frame = rect;
    [self addCustomView:view];
}

-(void)addCustomView:(UIView *)view withFocus:(CATFocus *)focus position:(CATFocusPosition)position offset:(CATOffset)offset{
    CGRect frame = focus.frame;
    CGFloat centerX = frame.origin.x+frame.size.width*0.5f;
    CGFloat centerY = frame.origin.y+frame.size.height*0.5f;
    
    CGRect newFrame = CGRectZero;
    if (position == CATFocusPositionBottom) {
        CGFloat x = centerX - view.frame.size.width*0.5f;
        newFrame = CGRectMake(x,frame.origin.y+frame.size.height, view.frame.size.width, view.frame.size.height);
        
    }else if(position == CATFocusPositionTop){
        CGFloat x = centerX - view.frame.size.width*0.5f;
        newFrame = CGRectMake(x,frame.origin.y-view.frame.size.height, view.frame.size.width, view.frame.size.height);
        
    }else if(position == CATFocusPositionLeft){
        CGFloat x = focus.frame.origin.x - view.frame.size.width;
        CGFloat y = centerY - view.frame.size.height*0.5f;
        newFrame = CGRectMake(x,y,view.frame.size.width, view.frame.size.height);
        
    }else if(position == CATFocusPositionRight){
        CGFloat x = focus.frame.origin.x+focus.frame.size.width;
        CGFloat y = centerY - view.frame.size.height*0.5f;
        newFrame = CGRectMake(x,y,view.frame.size.width, view.frame.size.height);
    }
    view.frame = CATRectWithOffset(newFrame,offset);
    
    [_arrayCustomView addObject:view];
    
    [self setNeedsDisplay];
}

-(void)removeFocus:(CATFocus *)focus{
    if (_arrayFocus && _arrayFocus.count > 0 && [_arrayFocus containsObject:focus]) {
        [_arrayFocus removeObject:focus];
        [self setNeedsDisplay];
    }
}

-(void)removeCustomView:(UIView *)view{
    if (_arrayCustomView && _arrayCustomView.count > 0 && [_arrayCustomView containsObject:view]) {
        [view removeFromSuperview];
        [_arrayCustomView removeObject:view];
        [self setNeedsDisplay];
    }
}

-(void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
    [self setNeedsDisplay];
}

#pragma mark -- override methods

- (void)drawRect:(CGRect)rect{
    [self _removeAllCustomViewsFromSuperview];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == nil) {
        return;
    }
    
    [_bgColor setFill];
    UIRectFill(rect);
    
    for (CATFocus* focus in _arrayFocus) {
        [[UIColor clearColor] setFill];
        
        if (focus.type == CATFocusTypeCirle) {
            CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
            CGContextSetBlendMode(context, kCGBlendModeClear);
            CGContextFillEllipseInRect(context, focus.frame);
            
        }else if (focus.type == CATFocusTypeRoundedRect) {
            CATRectFocus* rectFocus = (CATRectFocus *)focus;
            CGRect focusRect = CGRectIntersection(focus.frame, self.frame);
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:focusRect cornerRadius:rectFocus.cornerRadius];
            CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor clearColor] CGColor]);
            CGContextAddPath(UIGraphicsGetCurrentContext(), bezierPath.CGPath);
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
            CGContextFillPath(UIGraphicsGetCurrentContext());
            
        } else if (focus.type == CATFocusTypeRect) {
            CGRect focusRect = CGRectIntersection(focus.frame,self.frame);
            UIRectFill(focusRect);
        }
    }
    
    [self _addCustomViewsToSuperview];
}


#pragma mark -- private methods

-(void)_addFocus:(CATFocus *)focus{
    [_arrayFocus addObject:focus];
    focus.index = [_arrayFocus indexOfObject:focus];
    [self setNeedsDisplay];
}

-(void)_removeAllCustomViewsFromSuperview{
    if (!_arrayCustomView ||  _arrayCustomView.count < 1) {
        return;
    }
    for (UIView* view in _arrayCustomView) {
        [view removeFromSuperview];
    }
}

-(void)_addCustomViewsToSuperview{
    if (!_arrayCustomView ||  _arrayCustomView.count < 1) {
        return;
    }
    for (UIView* view in _arrayCustomView) {
        [self addSubview:view];
    }
}

- (void)_handleTap:(UITapGestureRecognizer *)gesture{
    if (!_delegate) return;
    
    CGPoint poingt = [gesture locationInView:self];
    
    if ([_delegate respondsToSelector:@selector(focusView:didSelectFocusAtIndex:)]) {
        NSUInteger index = [self _focusIndexAtPoint:poingt];
        if (index != NSNotFound) {
            [_delegate focusView:self didSelectFocusAtIndex:index];
        }
    }
    if ([_delegate respondsToSelector:@selector(focusView:didSelectCustomView:)]) {
        UIView* selView = [self _customViewAtPoint:poingt];
        if (selView) {
            [_delegate focusView:self didSelectCustomView:selView];
        }
    }
}

- (NSUInteger)_focusIndexAtPoint:(CGPoint)point{
    __block NSUInteger idxToReturn = NSNotFound;
    [_arrayFocus enumerateObjectsUsingBlock:^(CATFocus *focus, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(focus.frame, point)) {
            idxToReturn = idx;
            *stop = YES;
        }
    }];
    return idxToReturn;
}

- (UIView *)_customViewAtPoint:(CGPoint)point{
    __block UIView* selView = nil;
    [_arrayCustomView enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(view.frame, point)) {
            selView = view;
            *stop = YES;
        }
    }];
    return selView;
}

#pragma mark -- helper methods

UIKIT_STATIC_INLINE CGRect CATRectWithOffset(CGRect rect, CATOffset offset) {
    rect.origin.x    += offset.horizontal;
    rect.origin.y    += offset.vertical;
    return rect;
}

@end