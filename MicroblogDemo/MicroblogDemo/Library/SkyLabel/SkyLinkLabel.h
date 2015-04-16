//
//  SkyLinkLabel.h
//  MicroblogDemo
//
//  Created by Sky on 15/4/15.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+Emotion.h"

// 链接类型
typedef NS_ENUM(NSInteger, SkyLinkType)
{
    SkyLinkTypeUserHandle,     //用户昵称  eg: @Sky-star
    SkyLinkTypeHashTag,        //内容标签  eg: #hello
    SkyLinkTypeTheme,          //内容话题  eg: #谁最屌#
    SkyLinkTypeURL,            //链接地址  eg: http://www.baidu.com
    SkyLinkTypePhoneNumber     //电话号码  eg: 13888888888
};


// 可用于识别的链接类型
typedef NS_OPTIONS(NSUInteger, SkyLinkDetectionTypes)
{
    SkyLinkDetectionTypeUserHandle  = (1 << 0),
    SkyLinkDetectionTypeHashTag     = (1 << 1),
    SkyLinkDetectionTypeURL         = (1 << 2),
    SkyLinkDetectionTypePhoneNumber = (1 << 3),
    SkyLinkDetectionTypeTheme       = (1 << 4),
    
    SkyLinkDetectionTypeNone        = 0,
    SkyLinkDetectionTypeAll         = NSUIntegerMax
};

/*!
 *  @author Sky
 *
 *  @brief  连接点击代码块
 *
 *  @param linkType 链接类型
 *  @param string   链接内容
 *  @param range    连接所在位置和长度
 */
typedef void(^SkyLinkHandler)(SkyLinkType linkType, NSString *string, NSRange range);


@interface SkyLinkLabel : UILabel<NSLayoutManagerDelegate>

@property (nonatomic, assign, getter = isAutomaticLinkDetectionEnabled) BOOL automaticLinkDetectionEnabled;

@property (nonatomic, strong) UIColor *linkColor;

@property (nonatomic, strong) UIColor *linkHighlightColor;

@property (nonatomic, strong) UIColor *linkBackgroundColor;

@property (nonatomic, assign) SkyLinkDetectionTypes linkDetectionTypes;

@property (nonatomic, copy) SkyLinkHandler linkTapHandler;

@property (nonatomic, copy) SkyLinkHandler linkLongPressHandler;

@end
