//
//  RJTextField.m
//  RJTextField
//
//  Created by ChangRJey on 2017/7/28.
//  Copyright © 2017年 RenJiee. All rights reserved.
//

#import "RJTextField.h"

@interface RJTextField ()<UITextFieldDelegate>


/** 左侧图标 */
@property (nonatomic, strong) UIImageView * leftIcon;
/** 上浮的占位文本 */
@property (nonatomic, strong) UILabel * headerPlaceLabel;
/** 字数限制文本 */
@property (nonatomic, strong) UILabel * lengthLabel;
/** 底部分割线 */
@property (nonatomic, strong) UIView * bottomLine;
/** 错误提示信息 */
@property (nonatomic, strong) UILabel * errorLabel;

@end

@implementation RJTextField

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.textColor = SELECT_COLOR(85, 85, 85,1);
        self.textLengthLabelColor = SELECT_COLOR(92, 94, 102,1);
        //    self.placeholder = SELECT_COLOR(1, 183, 164,1);
        self.lineDefaultColor = SELECT_COLOR(220, 220, 220,1);
        self.lineSelectedColor = SELECT_COLOR(1, 183, 164,1);
        self.lineWarningColor = SELECT_COLOR(252, 57, 24,1);
        self.errorLableColor = SELECT_COLOR(252, 57, 24, 1);
    }
    return self;
}

#pragma mark -------------------- 在layoutSubviews方法中设置子控件的frame --------------------
- (void)layoutSubviews
{
    [super layoutSubviews];
    WEAKSELF
    
    [self addSubview:self.leftIcon];
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CURRENT_SIZE(13), CURRENT_SIZE(22)));
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(CURRENT_SIZE(10));
    }];
    
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CURRENT_SIZE(280), CURRENT_SIZE(30)));
        make.centerY.equalTo(weakSelf);
        make.left.equalTo(weakSelf.leftIcon.mas_right).offset(CURRENT_SIZE(8));
    }];
    
    [self addSubview:self.headerPlaceLabel];
    [self.headerPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CURRENT_SIZE(100), CURRENT_SIZE(15)));
        make.left.equalTo(weakSelf.leftIcon.mas_left);
        make.bottom.equalTo(weakSelf.textField.mas_top);
    }];
    
    [self addSubview:self.lengthLabel];
    [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CURRENT_SIZE(40), CURRENT_SIZE(15)));
        make.left.equalTo(weakSelf.textField.mas_right);
        make.bottom.equalTo(weakSelf.textField.mas_bottom);
    }];
    
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_SIZE.width-CURRENT_SIZE(10), 1));
        make.left.equalTo(weakSelf.leftIcon.mas_left);
        make.top.equalTo(weakSelf.textField.mas_bottom);
    }];
    
    [self addSubview:self.errorLabel];
    [self.errorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CURRENT_SIZE(100), CURRENT_SIZE(15)));
        make.left.equalTo(weakSelf.leftIcon.mas_left);
        make.top.equalTo(weakSelf.bottomLine.mas_bottom);
    }];
}

#pragma mark -------------------- 懒加载控件 --------------------
- (UITextField *) textField{
    if(!_textField){
        _textField = [UITextField new];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textColor = self.textColor;
        _textField.font = [UIFont systemFontOfSize:CURRENT_SIZE(15)];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.placeholder = self.placeholder;
        _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIImageView *) leftIcon{
    if(!_leftIcon){
        _leftIcon = [UIImageView new];
        _leftIcon.backgroundColor = [UIColor clearColor];
        _leftIcon.image = [UIImage imageNamed:self.leftIconName];
    }
    return _leftIcon;
}

- (UILabel *) headerPlaceLabel{
    if(!_headerPlaceLabel){
        _headerPlaceLabel = [UILabel new];
        _headerPlaceLabel.backgroundColor = [UIColor clearColor];
        _headerPlaceLabel.textColor = SELECT_COLOR(1, 183, 164, 1);
        _headerPlaceLabel.textAlignment = NSTextAlignmentLeft;
        _headerPlaceLabel.font = [UIFont systemFontOfSize:CURRENT_SIZE(14)];
        _headerPlaceLabel.text = self.textField.placeholder;
        _headerPlaceLabel.alpha = 0.0;
    }
    return _headerPlaceLabel;
}

- (UILabel *) lengthLabel{
    if(!_lengthLabel){
        _lengthLabel = [UILabel new];
        _lengthLabel.backgroundColor = [UIColor clearColor];
        _lengthLabel.textColor = SELECT_COLOR(92, 94, 102, 1);
        _lengthLabel.textAlignment = NSTextAlignmentRight;
        _lengthLabel.font = [UIFont systemFontOfSize:CURRENT_SIZE(11)];
        _lengthLabel.text = [[NSString alloc]initWithFormat:@"0/%ld",(long)self.maxLength];
    }
    return _lengthLabel;
}

- (UIView *) bottomLine{
    if(!_bottomLine){
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = self.lineDefaultColor;
    }
    return _bottomLine;
}

- (UILabel *) errorLabel{
    if(!_errorLabel){
        _errorLabel = [UILabel new];
        _errorLabel.backgroundColor = [UIColor clearColor];
        _errorLabel.textColor = self.errorLableColor;
        _errorLabel.font = [UIFont systemFontOfSize:CURRENT_SIZE(12)];
        _errorLabel.textAlignment = NSTextAlignmentLeft;
        _errorLabel.text = self.errorStr;
        _errorLabel.alpha = 0.0;
    }
    return _errorLabel;
}

#pragma mark -------------------- UITextFieldDelegate --------------------
- (void)textFieldEditingChanged:(UITextField *)sender
{
    if (sender.text.length > self.maxLength) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.errorLabel.alpha = 1.0;
            self.errorLabel.textColor = self.lineWarningColor;
            self.bottomLine.backgroundColor = self.lineWarningColor;
            self.lengthLabel.textColor = self.lineWarningColor;
            self.textField.textColor = self.lineWarningColor;
            //self.placeHolderLabel.textColor = self.lineWarningColor;
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.errorLabel.alpha = 0.0;
            self.bottomLine.backgroundColor = self.lineSelectedColor;
            self.lengthLabel.textColor = self.textLengthLabelColor;
            self.textField.textColor = self.textColor;
            //self.placeHolderLabel.textColor = self.placeHolderLabelColor;
        } completion:nil];
    }
    self.lengthLabel.text = [NSString stringWithFormat:@"%zd/%zd",sender.text.length,self.maxLength];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self setPlaceHolderLabelHidden:NO];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [self setPlaceHolderLabelHidden:YES];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    
    [self setPlaceHolderLabelHidden:YES];
    
    return YES;
}

#pragma mark -------------------- 占位符提示 --------------------
- (void)setPlaceHolderLabelHidden:(BOOL)isHidden
{
    if (isHidden) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.headerPlaceLabel.alpha = 0.0f;
            self.textField.placeholder = self.placeholder;
            self.bottomLine.backgroundColor = self.lineDefaultColor;
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.headerPlaceLabel.alpha = 1.0f;
            self.headerPlaceLabel.text = self.placeholder;
            self.textField.placeholder = @"";
            self.bottomLine.backgroundColor = self.lineSelectedColor;
        } completion:nil];
    }
}


@end
