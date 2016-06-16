//
//  CATFocusView.h
//  CATFocusView
//
//  Created by zengcatch on 16/6/16.
//  Copyright © 2016年 catch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CATFocus.h"

typedef struct CATOffset{
    CGFloat horizontal,vertical;
} CATOffset;

UIKIT_STATIC_INLINE CATOffset CATOffsetMake(CGFloat horizontal,CGFloat vertical) {
    CATOffset offset = {horizontal,vertical};
    return offset;
}

typedef NS_ENUM(NSInteger, CATFocusPosition){
    CATFocusPositionTop,
    CATFocusPositionBottom,
    CATFocusPositionLeft,
    CATFocusPositionRight,
};

@class CATFocusView;
@protocol CATFocusViewDelegate <NSObject>

@optional
- (void)focusView:(CATFocusView *)focusView didSelectFocusAtIndex:(NSUInteger)index;

- (void)focusView:(CATFocusView *)focusView didSelectCustomView:(UIView *)view;

@end


@interface CATFocusView : UIView

@property (nonatomic, weak) id<CATFocusViewDelegate> delegate;
//backgroud color
@property (nonatomic, strong) UIColor *bgColor;

/**
 *  Add Circle Focus
 *
 *  @param centerPoint  Center Point
 *  @param radius       Radius
 *
 *  @return CATCircleFocus
 */
-(CATCircleFocus *)addCircleFocusWithCenterPoint:(CGPoint)centerPoint radius:(CGFloat)radius;

/**
 *  Add Rect Focus
 *
 *  @param rect          Rect Of Focus
 *  @param cornerRadius  CornerRadius
 *
 *  @return CATRectFocus
 */
-(CATRectFocus *)addRectFocusOnRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;

/**
 *  Add Rect Focus
 *
 *  @param rect          Rect Of Focus
 *
 *  @return CATRectFocus
 */
-(CATRectFocus *)addRectFocusOnRect:(CGRect)rect;

/**
 *  Add CustomView
 *
 *  @param view     CustomView
 *  @param focus    Focus
 *  @param position Position
 *  @param offset   Offset
 */
-(void)addCustomView:(UIView *)view withFocus:(CATFocus *)focus position:(CATFocusPosition)position offset:(CATOffset)offset;

/**
 *  Remove Focus
 *
 *  @param focus    Focus
 */
-(void)removeFocus:(CATFocus *)focus;

/**
 *  Remove CustomView
 *
 *  @param view     CustomView
 */
-(void)removeCustomView:(UIView *)view;

@end