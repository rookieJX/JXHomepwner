//
//  JXDetailViewController.h
//  JXHomepwner
//
//  Created by 王加祥 on 16/7/4.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXItem;

@interface JXDetailViewController : UIViewController

/** 接收的数据模型 */
@property (nonatomic,strong) JXItem * item;

@end
