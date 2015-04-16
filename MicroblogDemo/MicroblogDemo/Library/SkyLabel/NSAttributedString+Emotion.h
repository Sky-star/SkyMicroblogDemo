//
//  NSAttributedString+Emotion.h
//  LinkTest
//
//  Created by joywii on 14/12/9.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SkyTextAttachment : NSTextAttachment
@property (nonatomic,assign) NSRange  range;
@end

@interface NSAttributedString (Emotion)


/*
 * 返回Emotion替换过的 NSAttributedString
 */
+ (NSAttributedString *)emotionAttributedStringFrom:(NSString *)string attributes:(NSDictionary *)attrs;

@end
