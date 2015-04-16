//
//  NSAttributedString+Emotion.m
//  LinkTest
//
//  Created by joywii on 14/12/9.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "NSAttributedString+Emotion.h"

@implementation SkyTextAttachment

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    //return CGRectMake( 0 , 0 , lineFrag.size.height + 6, lineFrag.size.height + 6);
    return CGRectMake( 0 , -5, 20, 20);
}
@end

@implementation NSAttributedString (Emotion)



/*
 * 返回表情数组
 */
+ (NSArray *)emojiStringArray
{
    
    NSString* path=[[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"];
    
    NSDictionary* emojiDict=[[NSDictionary alloc]initWithContentsOfFile:path];
    
    return [emojiDict allKeys];
}



/*
 * 返回Emotion替换过的 NSAttributedString
 */
+ (NSAttributedString *)emotionAttributedStringFrom:(NSString *)string attributes:(NSDictionary *)attrs
{
    NSMutableAttributedString *attributedEmotionString = [[NSMutableAttributedString alloc] initWithString:string attributes:attrs];
    
    NSArray *attachmentArray = [NSAttributedString attachmentsForAttributedString:attributedEmotionString];
    for (SkyTextAttachment *attachment in attachmentArray)
    {
        NSAttributedString *emotionAttachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
        [attributedEmotionString replaceCharactersInRange:attachment.range withAttributedString:emotionAttachmentString];
    }
    return attributedEmotionString;
}

/*
 * 查找所有表情文本并替换
 */
+ (NSArray *)attachmentsForAttributedString:(NSMutableAttributedString *)attributedString
{
    NSString *markL       = @"[";
    NSString *markR       = @"]";
    NSString *string      = attributedString.string;
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *stack = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < string.length; i++)
    {
        NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
        
        if (([s isEqualToString:markL]) || ((stack.count > 0) && [stack[0] isEqualToString:markL]))
        {
            if (([s isEqualToString:markL]) && ((stack.count > 0) && [stack[0] isEqualToString:markL]))
            {
                [stack removeAllObjects];
            }
            
            [stack addObject:s];
            
            if ([s isEqualToString:markR] || (i == string.length - 1))
            {
                NSMutableString *emojiStr = [[NSMutableString alloc] init];
                for (NSString *c in stack)
                {
                    [emojiStr appendString:c];
                }
                
                if ([[NSAttributedString emojiStringArray] containsObject:emojiStr])
                {
                    NSRange range = NSMakeRange(i + 1 - emojiStr.length, emojiStr.length);
                    
                    [attributedString replaceCharactersInRange:range withString:@" "];
                    SkyTextAttachment *attachment = [[SkyTextAttachment alloc] initWithData:nil ofType:nil];
                    attachment.range = NSMakeRange(i + 1 - emojiStr.length, 1);
                    
                    /*!
                     *  @author Sky
                     *
                     *  @brief  读取字典中相应匹配的表情
                     */
                    NSString* path=[[NSBundle mainBundle] pathForResource:@"expression" ofType:@"plist"];
                    
                    NSDictionary* emojiDict=[[NSDictionary alloc]initWithContentsOfFile:path];
                    
                    NSString* imageName=[emojiDict objectForKey:emojiStr];
                    
                   
                    /*!
                     *  @brief  由于Plist文件中的图片名称有问题所以在这里做了一个处理，可以根据需求修改此处
                     */
                    
                    attachment.image = [UIImage imageNamed:[imageName substringToIndex:[imageName rangeOfString:@"@2x"].location]];
                    
                    i -= ([stack count] - 1);
                    [array addObject:attachment];
                }
                [stack removeAllObjects];
            }
        }
    }
    return array;
}
@end
