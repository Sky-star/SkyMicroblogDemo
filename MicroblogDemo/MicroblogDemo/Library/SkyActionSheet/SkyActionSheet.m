//
//  SkyActionSheet.m
//  MicroblogDemo
//
//  Created by Sky on 15/4/17.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import "SkyActionSheet.h"
#import "UIView+AutoLayout.h"
#import "SkyActionSheetButton.h"

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

#define UIControlStateAll UIControlStateNormal & UIControlStateSelected & UIControlStateHighlighted
#define SYSTEM_VERSION_LESS_THAN(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending)



@implementation SkyActionSheet

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
        self.backgroundColor=[UIColor clearColor];
        self.buttons = [[NSMutableArray alloc] init];
        self.shouldCancelOnTouch = YES;
        self.cancelButtonIndex = -1;
        self.transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
        self.transparentView.backgroundColor = [UIColor blackColor];
        self.transparentView.alpha = 0.0f;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelSelection)];
        tap.numberOfTapsRequired = 1;
        [self.transparentView addGestureRecognizer:tap];
    }
    return self;
}


-(instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle andOtherButtonTitlesArray:(NSArray *)otherTitlesArray
{
    self=[self init];
    
    NSMutableArray* titles=[otherTitlesArray mutableCopy];
    
    // set up cancel button
    if (cancelTitle)
    {
        SkyActionSheetButton *cancelButton = [[SkyActionSheetButton alloc] initWithButtonWithCornerType:SkyActionSheetButtonCornerTypeAllCornersRounded];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:21];
        [cancelButton setTitle:cancelTitle forState:UIControlStateAll];
        [self.buttons addObject:cancelButton];
        self.hasCancelButton = YES;
    }
    else
    {
        self.shouldCancelOnTouch = NO;
        self.hasCancelButton = NO;
    }
    
    
    switch (titles.count) {
            
        case 0: {
            break;
        }
            
        case 1: {
            
            SkyActionSheetButton *otherButton;
            
            if (title)
            {
                otherButton = [[SkyActionSheetButton alloc] initWithButtonWithCornerType:SkyActionSheetButtonCornerTypeBottomCornersRounded];
            } else
            {
                otherButton = [[SkyActionSheetButton alloc] initWithButtonWithCornerType:SkyActionSheetButtonCornerTypeAllCornersRounded];
            }
            
            [otherButton setTitle:[titles objectAtIndex:0] forState:UIControlStateAll];
            [self.buttons insertObject:otherButton atIndex:0];
            
            break;
            
        } case 2: {
            
            SkyActionSheetButton *otherButton = [[SkyActionSheetButton alloc] initWithButtonWithCornerType:SkyActionSheetButtonCornerTypeBottomCornersRounded];
            [otherButton setTitle:[titles objectAtIndex:1] forState:UIControlStateAll];
            
            SkyActionSheetButton *secondButton;
            
            if (title) {
                secondButton = [[SkyActionSheetButton alloc] init];
            } else {
                secondButton = [[SkyActionSheetButton alloc] initWithButtonWithCornerType:SkyActionSheetButtonCornerTypeTopCornersRounded];
            }
            
            [secondButton setTitle:[titles objectAtIndex:0] forState:UIControlStateAll];
            [self.buttons insertObject:secondButton atIndex:0];
            [self.buttons insertObject:otherButton atIndex:1];
            
            break;
            
        } default: {
            
            SkyActionSheetButton *bottomButton = [[SkyActionSheetButton alloc] initWithButtonWithCornerType:SkyActionSheetButtonCornerTypeBottomCornersRounded];
            [bottomButton setTitle:[titles lastObject] forState:UIControlStateAll];
            
            SkyActionSheetButton *topButton;
            
            if (title) {
                topButton = [[SkyActionSheetButton alloc] init];
            } else {
                topButton = [[SkyActionSheetButton alloc] initWithButtonWithCornerType:SkyActionSheetButtonCornerTypeTopCornersRounded];
            }
            
            [topButton setTitle:[titles objectAtIndex:0] forState:UIControlStateAll];
            [self.buttons insertObject:topButton atIndex:0];
            
            int whereToStop = (int)titles.count - 1;
            for (int i = 1; i < whereToStop; ++i) {
                SkyActionSheetButton *middleButton = [[SkyActionSheetButton alloc] init];
                [middleButton setTitle:[titles objectAtIndex:i] forState:UIControlStateAll];
                [self.buttons insertObject:middleButton atIndex:i];
            }
            
            [self.buttons insertObject:bottomButton atIndex:(titles.count - 1)];
            
            break;
        }
    }
    
    if (self.hasCancelButton) {
        self.cancelButtonIndex = self.buttons.count - 1;
    } else {
        self.cancelButtonIndex = -1;
    }
    
    [self setUpTheActions];
    
    for (int i = 0; i < self.buttons.count; ++i) {
        [[self.buttons objectAtIndex:i] setIndex:i];
    }
    
    if (title) {
        self.title = title;
    } else {
        [self setUpTheActionSheet];
    }
    
    return self;

    
    return self;
}


- (void)setUpTheActionSheet {
    
    float height;
    float width;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
    } else {
        width = CGRectGetHeight([UIScreen mainScreen].bounds);
    }
    
    
    // slight adjustment to take into account non-retina devices
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]
        && [[UIScreen mainScreen] scale] == 2.0) {
        
        // setup spacing for retina devices
        if (self.hasCancelButton) {
            height = 59.5;
        } else if (!self.hasCancelButton && self.titleView) {
            height = 52.0;
        } else {
            height = 104.0;
        }
        
        if (self.buttons.count) {
            height += (self.buttons.count * 44.5);
        }
        if (self.titleView) {
            height += CGRectGetHeight(self.titleView.frame) - 44;
        }
        
        self.frame = CGRectMake(0, 0, width, height);
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        CGPoint pointOfReference = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) - 30);
        
        int whereToStop;
        if (self.hasCancelButton) {
            [self addSubview:[self.buttons lastObject]];
            [[self.buttons lastObject] setCenter:pointOfReference];
            [[self.buttons objectAtIndex:0] setCenter:CGPointMake(pointOfReference.x, pointOfReference.y - 52)];
            pointOfReference = CGPointMake(pointOfReference.x, pointOfReference.y - 52);
            whereToStop = (int)self.buttons.count - 2;
        } else {
            [self addSubview:[self.buttons lastObject]];
            [[self.buttons lastObject] setCenter:pointOfReference];
            whereToStop = (int)self.buttons.count - 1;
        }
        
        for (int i = 0, j = whereToStop; i <= whereToStop; ++i, --j) {
            [self addSubview:[self.buttons objectAtIndex:i]];
            [[self.buttons objectAtIndex:i] setCenter:CGPointMake(pointOfReference.x, pointOfReference.y - (44.5 * j))];
        }
        
        if (self.titleView) {
            [self addSubview:self.titleView];
            self.titleView.center = CGPointMake(self.center.x, CGRectGetHeight(self.titleView.frame) / 2.0);
        }
        
    } else {
        
        // setup spacing for non-retina devices
        
        if (self.hasCancelButton) {
            height = 60.0;
        } else {
            height = 104.0;
        }
        
        if (self.buttons.count) {
            height += (self.buttons.count * 45);
        }
        if (self.titleView) {
            height += CGRectGetHeight(self.titleView.frame) - 45;
        }
        
        self.frame = CGRectMake(0, 0, width, height);
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        CGPoint pointOfReference = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) - 30);
        
        int whereToStop;
        if (self.hasCancelButton) {
            [self addSubview:[self.buttons lastObject]];
            [[self.buttons lastObject] setCenter:pointOfReference];
            [[self.buttons objectAtIndex:0] setCenter:CGPointMake(pointOfReference.x, pointOfReference.y - 52)];
            pointOfReference = CGPointMake(pointOfReference.x, pointOfReference.y - 52);
            whereToStop = (int)self.buttons.count - 2;
        } else {
            [self addSubview:[self.buttons lastObject]];
            [[self.buttons lastObject] setCenter:pointOfReference];
            whereToStop = (int)self.buttons.count - 1;
        }
        
        for (int i = 0, j = whereToStop; i <= whereToStop; ++i, --j) {
            [self addSubview:[self.buttons objectAtIndex:i]];
            [[self.buttons objectAtIndex:i] setCenter:CGPointMake(pointOfReference.x, pointOfReference.y - (45 * j))];
        }
        
        if (self.titleView) {
            [self addSubview:self.titleView];
            self.titleView.center = CGPointMake(self.center.x, CGRectGetHeight(self.titleView.frame) / 2.0);
        }
    }
    
}

- (void)setUpTheActions {
    
    for (SkyActionSheetButton *button in self.buttons) {
        if ([button isKindOfClass:[SkyActionSheetButton class]]) {
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button addTarget:self action:@selector(highlightPressedButton:) forControlEvents:UIControlEventTouchDown];
            [button addTarget:self action:@selector(unhighlightPressedButton:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit];
        }
    }
}

- (void)highlightPressedButton:(SkyActionSheetButton *)button {
    
    [UIView animateWithDuration:0.15f animations:^() {
        
         button.transform = CGAffineTransformMakeScale(.98, .95);
    }];
}


- (void)unhighlightPressedButton:(SkyActionSheetButton *)button {
    
    [UIView animateWithDuration:0.3f animations:^() {
                         
         button.transform = CGAffineTransformMakeScale(1, 1);

    }];
    
}


#pragma mark - SkyActionSheet Helpful Method

- (void)buttonClicked:(SkyActionSheetButton *)button {
    
    if(self.actionSheetPressHndler) self.actionSheetPressHndler(self,self.actionSheetStyle,button.index);
    self.shouldCancelOnTouch = YES;
    
    [self removeFromView];
}

- (void)showInView:(UIView *)theView {
    
    
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    if (NSClassFromString(@"UIVisualEffectView") && self.blurBackground) {
        UIVisualEffectView *visualEffectView;
        visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = theView.bounds;
        visualEffectView.tag = 821;
        [theView addSubview:visualEffectView];
        visualEffectView.userInteractionEnabled = NO;
    }
    
    [theView addSubview:self];
    
    [theView insertSubview:self.transparentView belowSubview:self];
    
    CGRect theScreenRect = [UIScreen mainScreen].bounds;
    
    float height;
    float x;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        height = CGRectGetHeight(theScreenRect);
        x = CGRectGetWidth(theView.frame) / 2.0;
        self.transparentView.frame = CGRectMake(self.transparentView.center.x, self.transparentView.center.y, CGRectGetWidth(theScreenRect), CGRectGetHeight(theScreenRect));
    } else {
        height = CGRectGetWidth(theScreenRect);
        x = CGRectGetHeight(theView.frame) / 2.0;
        self.transparentView.frame = CGRectMake(self.transparentView.center.x, self.transparentView.center.y, CGRectGetHeight(theScreenRect), CGRectGetWidth(theScreenRect));
    }
    
    self.center = CGPointMake(x, height + CGRectGetHeight(self.frame) / 2.0);
    self.transparentView.center = CGPointMake(x, height / 2.0);
    
    
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        
        
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^() {
                             self.transparentView.alpha = 0.4f;
                             self.center = CGPointMake(x, (height - 20) - CGRectGetHeight(self.frame) / 2.0);
                             
                         } completion:^(BOOL finished) {
                             self.visible = YES;
                         }];
    } else {
        
        [UIView animateWithDuration:0.3f
                              delay:0
             usingSpringWithDamping:0.85f
              initialSpringVelocity:1.0f
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.transparentView.alpha = 0.4f;
                             self.center = CGPointMake(x, height - CGRectGetHeight(self.frame) / 2.0);
                             
                         } completion:^(BOOL finished) {
                             self.visible = YES;
                         }];
    }
}


- (void) cancelSelection {
    if(self.actionSheetPressHndler) self.actionSheetPressHndler(self,self.actionSheetStyle,NSIntegerMax);
    [self removeFromView];
}


- (void)removeFromView {
    
    if (self.shouldCancelOnTouch) {
        
        if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
            
            
            [UIView animateWithDuration:0.3f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^() {
                                 self.transparentView.alpha = 0.0f;
                                 self.center = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) + CGRectGetHeight(self.frame) / 2.0);
                                 
                             } completion:^(BOOL finished) {
                                 [self.transparentView removeFromSuperview];
                                 [self removeFromSuperview];
                                 self.visible = NO;
                             }];
        } else {
            
            UIView *blurView = [self.transparentView.superview viewWithTag:821];
            
            [UIView animateWithDuration:0.3f
                                  delay:0
                 usingSpringWithDamping:0.85f
                  initialSpringVelocity:1.0f
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 
                                 if (blurView) {
                                     blurView.alpha = 0;
                                 }
                                 
                                 self.transparentView.alpha = 0.0f;
                                 self.center = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) + CGRectGetHeight(self.frame) / 2.0);
                                 
                             } completion:^(BOOL finished) {
                                 [self.transparentView removeFromSuperview];
                                 [self removeFromSuperview];
                                 if (blurView) {
                                     [blurView removeFromSuperview];
                                 }
                                 self.visible = NO;
                             }];
        }
        
    }
    
}


@end


@implementation SkyActionSheetTitleView

-(instancetype)initWithTitle:(NSString *)title andFont:(UIFont *)font
{
    if (self=[super init])
    {
        self.alpha= 0.95f;
        self.backgroundColor=[UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initForAutoLayout];
        self.titleLabel.textColor = [UIColor colorWithWhite:0.564 alpha:1.000];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font=font?font:[UIFont systemFontOfSize:13];
        [self.titleLabel sizeToFit];
        [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
        [self addSubview:self.titleLabel];
        self.titleLabel.center = self.center;

    }
    return self;
}


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