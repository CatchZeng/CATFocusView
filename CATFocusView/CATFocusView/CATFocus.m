//
//  CATFocus.m
//  CATFocusView
//
//  Created by zengcatch on 16/6/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "CATFocus.h"

@implementation CATFocus

@end


@implementation CATCircleFocus

-(instancetype)init{
    self = [super init];
    if (self) {
        self.type = CATFocusTypeCirle;
    }
    return self;
}

-(instancetype)initWithCenterPoint:(CGPoint)centerPoint radius:(CGFloat)radius{
    self = [super init];
    if (self) {
        self.type = CATFocusTypeCirle;
        self.centerPoint = centerPoint;
        self.radius = radius;
        self.frame = CGRectMake(centerPoint.x - radius,centerPoint.y - radius, radius*2.0f,radius*2.0f);
    }
    return self;
}

@end


@implementation CATRectFocus

-(instancetype)init{
    self = [super init];
    if (self) {
        self.type = CATFocusTypeRect;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius{
    self = [super init];
    if (self) {
        self.type = cornerRadius > 0 ? CATFocusTypeRoundedRect :CATFocusTypeRect;
        self.frame = frame;
        self.cornerRadius = cornerRadius;
    }
    return self;
}

@end