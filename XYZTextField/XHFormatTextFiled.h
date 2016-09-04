//
//  AppDelegate.h
//  XYZTextField
//
//  Created by xieyingze on 16/7/23.
//  Copyright © 2016年 xieyingze. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FormatTypeNone,
    FormatTypePhone,
    FormatTypeCard,
    FormatTypeTelephone,
    FormatTypeIDCard,
    FormatTypeSms
} FormatType;


@interface XHFormattter : NSObject<UITextFieldDelegate>

@property(nonatomic,assign) FormatType formatType;
#warning add 添加字断
//进入添加银行卡修改银行卡号的次数
@property(nonatomic,assign) NSInteger   cnt_bank_modify;

@end

@interface XHFormatTextFiled : UITextField

@property(nonatomic,assign) FormatType formatType;

-(NSString*)formatText;

-(void)setFormatText:(NSString *)text;

@end
