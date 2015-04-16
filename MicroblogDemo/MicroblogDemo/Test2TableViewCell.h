//
//  Test2TableViewCell.h
//  TableViewHightDemo
//
//  Created by Sky on 15/2/2.
//  Copyright (c) 2015年 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkyLinkLabel.h"

@interface Test2TableViewCell : UITableViewCell


/**
 *  头像
 */
@property(nonatomic,strong)UIImageView* headImageView;


/**
 *  用户名
 */
@property(nonatomic,strong)UILabel* userNameLabel;


/**
 *  多久发送的微博 e.g 1个小时前
 */
@property(nonatomic,strong)UILabel* timeLabel;


/**
 *  自适应label
 */
@property(nonatomic,strong)SkyLinkLabel* bodyLabel;


-(void)setImageswithURLs:(NSArray*) urls;

@end
