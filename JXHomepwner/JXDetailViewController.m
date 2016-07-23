//
//  JXDetailViewController.m
//  JXHomepwner
//
//  Created by 王加祥 on 16/7/4.
//  Copyright © 2016年 Wangjiaxiang. All rights reserved.
//

#import "JXDetailViewController.h"
#import "JXItem.h"
#import "JXImageStore.h"

@interface JXDetailViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation JXDetailViewController

#pragma mark - 视图将要出现的时候显示内容
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
    
    NSString * itemKey = self.item.itemKey;
    
    // 根据 itemKey 从 JXImageStore 对象中获取图片
    UIImage * image = [[JXImageStore shareStore] imageForKey:itemKey];
    
    // 将得到的图片赋值
    self.imageView.image = image;
}

#pragma mark - 视图将要消失的时候更改内容
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

#pragma mark - 重写set方法，将导航栏设定标题
- (void)setItem:(JXItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

#pragma mark - 拍照
- (IBAction)takePicture:(UIBarButtonItem *)sender {
    // 创建对象
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    
    // 如果设备支持相机就使用拍照模式
    // 否则就进入到相册
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    else
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 设置代理
    imagePicker.delegate = self;
    
    // 以模态方式显示
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // 通过info字典获取选中的照片
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    // 以 itemKey 为键，将照片存储到 JXImageStore中
    [[JXImageStore shareStore] setImage:image forKey:self.item.itemKey];
    
    // 将照片放到 UIImageView 对象
    self.imageView.image = image;
    
    // 关闭对象
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Tap手势
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
