//
//  RJTextField.h
//  RJTextField
//
//  Created by ChangRJey on 2017/7/28.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RJTextField : UIView

/** 文本输入框 */
@property (nonatomic, strong) UITextField * textField;


/** 占位符文本 */
@property (nonatomic, copy) NSString * placeholder;
/** 图片名称 */
@property (nonatomic, copy) NSString * leftIconName;
/** 文本颜色(默认DarkGray) */
@property (nonatomic,strong) UIColor *textColor;
/** 错误提示信息 */
@property (nonatomic, copy) NSString * errorStr;
/** 错误提示信息字体颜色 */
@property (nonatomic, strong) UIColor * errorLableColor;
/** 最大字数(必填) */
@property (nonatomic,assign) NSInteger maxLength;
/** 字数限制文本颜色(默认灰色) */
@property (nonatomic,strong) UIColor *textLengthLabelColor;
/** 底部分割线默认颜色 */
@property (nonatomic, strong) UIColor * lineDefaultColor;
/** 底部线条错误警告颜色(默认红色) */
@property (nonatomic,strong) UIColor *lineWarningColor;
/** 底部线条选中颜色(默认深绿色) */
@property (nonatomic,strong) UIColor *lineSelectedColor;


@end
