//
//  JXDetailViewController.m
//  JXHomepwner
//
//  Created by 王加祥 on 16/7/4.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "JXDetailViewController.h"
#import "JXItem.h"


@interface JXDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation JXDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.nameField.text = self.item.itemName;
    self.serialField.text = self.item.serialnumber;
    self.valueField.text = [NSString stringWithFormat:@"%zd",self.item.valueInDollars];
    
    // 创建 NSDateFormatter 对象，将NSDate对象转换成简单的日期字符串
    static NSDateFormatter * dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // 将转换后得到的日期字符串显示到dateLabel上
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.createDate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 取消当前第一响应者
    [self.view endEditing:YES];
    
    // 将修改 保存到JXItem对象
    JXItem * item = self.item;
    item.itemName = self.nameField.text;
    item.serialnumber = self.serialField.text;
    item.valueInDollars = [self.valueField.text integerValue];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setItem:(JXItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}


@end
