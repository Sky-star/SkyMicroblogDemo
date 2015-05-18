//
//  SkyActionSheet.h
//  MicroblogDemo
//
//  Created by Sky on 15/4/17.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>



//ActionSheet显示样式
typedef NS_ENUM(NSInteger, SkyActionSheetStyle)
{
  SkyActionSheetNormalStyle,//类似原生的Actionsheet
  SkyActionSheetHorizontalScrollStyle,//可水平滚动的ActionSheet
};


@class SkyActionSheet,SkyActionSheetButton,SkyActionSheetTitleView;

/*!
 *  @brief  actionsheet press block
 *
 *  @param actionSheet      self actionSheet
 *  @param actionSheetStyle which style in actionsheet
 *  @param buttonIndex      which index of button have been pressed
 */
typedef void(^SkyActionSheetHandler)(SkyActionSheet* actionSheet,SkyActionSheetStyle actionSheetStyle, NSInteger buttonIndex);


@interface SkyActionSheet : UIView

/*!
 *  @brief  action sheet button clicked callback
 */
@property (nonatomic,copy  ) SkyActionSheetHandler   actionSheetPressHndler;

/*!
 *  @brief  style of action sheet  default is Normal
 */
@property (nonatomic,assign) SkyActionSheetStyle     actionSheetStyle;

/*!
 *  @brief  need transform  parent view
 */
@property (nonatomic,strong) UIView                  *transparentView;

/*!
 *  @brief  all buttons in action sheet
 */
@property (nonatomic,strong) NSMutableArray          *buttons;

/*!
 *  @brief  action sheet title
 */
@property (nonatomic,strong) NSString                *title;

/*!
 *  @brief  action sheet titleView
 */
@property (nonatomic,strong) SkyActionSheetTitleView *titleView;

/*!
 *  @brief  is should be visible
 */
@property (nonatomic,assign) BOOL                    visible;

/*!
 *  @brief  should show cancel Button
 */
@property (nonatomic,assign) BOOL                    hasCancelButton;

/*!
 *  @brief  should allow cancel on touch
 */
@property (nonatomic,assign) BOOL                    shouldCancelOnTouch;

/*!
 *  @brief  Background Blur is only currently availble on iOS 8.
 */
@property (nonatomic,assign) BOOL                    blurBackground;

/*!
 *  @brief  Cancel button Index
 */
@property (nonatomic,assign) NSInteger               cancelButtonIndex;

/*!
 *  @brief  show view
 *
 *  @param theView displayed in any view
 */
-(void)showInView:(UIView*) theView;

/*!
 *  @brief  add SkyActionButton with title or image
 *
 *  @param title       button title
 *  @param buttonImage button image at leading in button , could be nil
 *
 *  @return indx of button
 */
-(NSInteger)addButtonWithTitle:(NSString*) title andImage:(UIImage*) buttonImage;


/*!
 *  @brief  init action sheet without buton image just like normal
 *
 *  @param title            action sheet title
 *  @param cancelTitle      cancel button title
 *  @param otherTitlesArray other button titles
 */
-(instancetype)initWithTitle:(NSString*) title cancelButtonTitle:(NSString*) cancelTitle andOtherButtonTitlesArray:(NSArray*) otherTitlesArray;

/*!
 *  @brief  init action sheet with image  e.g:QQMusic
 *
 *  @param title            action sheet title
 *  @param cancelTitle      cancel button title
 *  @param otherTitlesArray other button titles
 *  @param otherImagesArray other button images
 */
-(instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle OtherButtonTitlesArray:(NSArray *)otherTitlesArray OtherButtonImagesArray:(NSArray*) otherImagesArray;

/*!
 *  @brief  how many buttons in actionsheet
 *
 *  @return numer of buttons
 */
-(NSInteger)numberOfButtons;

/*!
 *  @brief  button titles
 *
 *  @param index buttonIndex
 *
 *  @return buttonTitle
 */
-(NSString*)buttonTitleAtIndex:(NSInteger) index;



@end


@interface SkyActionSheetTitleView : UIView

/*!
 *  @brief  title view in action sheet
 *
 *  @param title title string
 *  @param font  title font
 *
 *  @return titleView
 */
-(instancetype)initWithTitle:(NSString*) title andFont:(UIFont*) font;

/*!
 *  @brief  titleLabel in title view
 */
@property(nonatomic,strong)UILabel* titleLabel;

@end
