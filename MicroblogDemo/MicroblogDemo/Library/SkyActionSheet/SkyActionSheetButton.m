//
//  SkyActionSheetButton.m
//  MicroblogDemo
//
//  Created by Sky on 15/4/17.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "SkyActionSheetButton.h"


#define UIControlStateAll UIControlStateNormal & UIControlStateSelected & UIControlStateHighlighted

@interface SkyActionSheetButton ()

/*!
 *  @brief  Create a mask for the button becomes rounded corners
 *
 *  @param view    which view you want to mask
 *  @param corners four corners Type to chose
 */
- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners;

@end


@implementation SkyActionSheetButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    if (self=[super init])
    {
        float width;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self setTitleColor:[UIColor colorWithRed:0.000 green:0.500 blue:1.000 alpha:1.000]  forState:UIControlStateAll];
        [self setAlpha:0.95f];
        [self setCornerType:SkyActionSheetButtonCornerTypeNoCornersRounded];
    }
    return self;
}


#pragma mark - Outside Method
-(instancetype)initWithButtonWithCornerType:(SkyActionSheetButtonCornerType)cornerType
{
    self=[self init];
    self.cornerType=cornerType;
    switch (cornerType)
    {
        case SkyActionSheetButtonCornerTypeTopCornersRounded:
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
            break;
        case SkyActionSheetButtonCornerTypeBottomCornersRounded:
            [self setMaskTo:self byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        case SkyActionSheetButtonCornerTypeAllCornersRounded:
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        default:
            break;
    }
    return self;
    
}


-(void)setTextNormalColor:(UIColor *)normalColor andHighlightColor:(UIColor *)highlightColor
{
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:highlightColor forState:UIControlStateHighlighted];
}


-(void)setButtonBackgroundColor:(UIColor *)normalColor
{
    [self setBackgroundColor:normalColor];
}


-(void)setButtonNormalImage:(UIImage *)normalImage andHighlightImage:(UIImage *)highlightImage
{
   //wait for code
}

-(void)setButtonBackgroundNormalImage:(UIImage *)normal andHightlightBackgroundImage:(UIImage *)highlightImage
{
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    [self setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
}

#pragma mark - Inside Method
- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(4.0, 4.0)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}


@end
