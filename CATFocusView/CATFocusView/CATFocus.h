//
//  CATFocus.h
//  CATFocusView
//
//  Created by zengcatch on 16/6/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CATFocusType){
    CATFocusTypeCirle,
    CATFocusTypeRect,
    CATFocusTypeRoundedRect,
};

/**
 *  Focus
 */
@interface CATFocus : NSObject

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) CATFocusType type;

@end


/**
 *  Circle Focus
 */
@interface CATCircleFocus : CATFocus

@property (nonatomic, assign) CGFloat radius;

@property (assign) CGPoint centerPoint;

-(instancetype)initWithCenterPoint:(CGPoint)centerPoint radius:(CGFloat)radius;

@end


/**
 *  Rect Focus
 */
@interface CATRectFocus : CATFocus

@property (nonatomic, assign) CGFloat cornerRadius;

-(instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;

@end