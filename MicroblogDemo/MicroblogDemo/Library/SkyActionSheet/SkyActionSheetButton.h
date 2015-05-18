//
//  SkyActionSheetButton.h
//  MicroblogDemo
//
//  Created by Sky on 15/4/17.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  @brief  按钮圆角类型
 */
typedef NS_ENUM(NSInteger, SkyActionSheetButtonCornerType){
    /*!
     *  @brief  无圆角
     */
    SkyActionSheetButtonCornerTypeNoCornersRounded,
    /*!
     *  @brief  顶部圆角
     */
    SkyActionSheetButtonCornerTypeTopCornersRounded,
    /*!
     *  @brief  底部圆角
     */
    SkyActionSheetButtonCornerTypeBottomCornersRounded,
    /*!
     *  @brief  全部圆角
     */
    SkyActionSheetButtonCornerTypeAllCornersRounded
};



@interface SkyActionSheetButton : UIButton

/*!
 *  @brief  button index
 */
@property (nonatomic,assign) NSInteger                      index;
/*!
 *  @brief  cornerType
 */
@property (nonatomic,assign) SkyActionSheetButtonCornerType cornerType;

/*!
 *  @brief  init buuton with cornertype what you want
 *
 *  @param conrnerType  button corner type
 *
 *  @return action sheet button instantiate the object
 */
- (instancetype)initWithButtonWithCornerType:(SkyActionSheetButtonCornerType) cornerType;


/*!
 *  @brief  set button text color under normal state or highlight state
 *
 *  @param normalColor    normal  text state color
 *  @param highlightColor highlight text state color
 */
-(void)setTextNormalColor:(UIColor*) normalColor andHighlightColor:(UIColor*) highlightColor;


/*!
 *  @brief  set button background color
 *
 *  @param normalColor    background color
 */
-(void)setButtonBackgroundColor:(UIColor*) normalColor;

/*!
 *  @brief  set button image under normal state or highlight state
 *
 *  @param normalImage    normal state image
 *  @param highlightImage highlight state image
 */
-(void)setButtonNormalImage:(UIImage*) normalImage andHighlightImage:(UIImage*) highlightImage;


/*!
 *  @brief  set button background iamge under normal state or highlight state
 *
 *  @param normal         normal state background image
 *  @param highlightImage hightlight state background image
 */
-(void)setButtonBackgroundNormalImage:(UIImage*) normal andHightlightBackgroundImage:(UIImage*) highlightImage;





@end
