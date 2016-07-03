//
//  JXItemStore.h
//  JXHomepwner
//
//  Created by 王加祥 on 16/7/3.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//  存放所有的JXItem对象

#import <Foundation/Foundation.h>

@class JXItem;

@interface JXItemStore : NSObject

/** 存放 JXItem 对象数组 */
@property (nonatomic,readonly) NSArray * allItem;

+ (instancetype)sharedStore;

- (JXItem *)createItem;

/**
 *  删除对象
 *
 *  @param item 需要删除的对象
 */
- (void)removeItem:(JXItem *)item;

/**
 *  移动对象
 *
 *  @param fromIndex 移动对象的起始位置
 *  @param toIndex   移动后的位置
 */
- (void)moveItemAtIndex:(NSInteger)fromIndex
                toIndex:(NSInteger)toIndex;
@end
