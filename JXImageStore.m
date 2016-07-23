//
//  JXImageStore.m
//  JXHomepwner
//
//  Created by 王加祥 on 16/7/5.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "JXImageStore.h"

@interface JXImageStore ()

/** 存放照片 */
@property (nonatomic,strong) NSMutableDictionary * dictionary;

@end

@implementation JXImageStore

+ (instancetype)shareStore {
    static JXImageStore * shareStore = nil;
    if (!shareStore) {
        shareStore = [[self alloc] init];
    }
    return shareStore;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key {
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key {
    if (!key) return;
    [self.dictionary removeObjectForKey:key];
}
@end
