//
//  AppDelegate.h
//  XYZTextField
//
//  Created by xieyingze on 16/7/23.
//  Copyright © 2016年 xieyingze. All rights reserved.
//


#import "XHFormatTextFiled.h"


@implementation XHFormattter


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(_formatType == FormatTypePhone)
    {
        return [self shouldChangePhone:textField shouldChangeCharactersInRange:range replacementString:string];
        
    }else if(_formatType == FormatTypeCard)
    {
        return [self shouldChangeCard:textField shouldChangeCharactersInRange:range replacementString:string];
    }else if(_formatType == FormatTypeTelephone)
    {
        return [self shouldChangeTelephone:textField shouldChangeCharactersInRange:range replacementString:string];
    }else if(_formatType == FormatTypeIDCard)
    {
        return [self shouldChangeIDCard:textField shouldChangeCharactersInRange:range replacementString:string];
    }else if(_formatType == FormatTypeSms)
    {
        return [self shouldChangeSms:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

#pragma mark - 代理

-(BOOL)shouldChangePhone:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    __block NSString *text = [textField text];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    
    
    BOOL isFirstThree = YES;
    int length = 4;
    while (text.length > 0) {
        NSString *subString = nil;
        //第一次三位
        if(isFirstThree)
        {
            length = 3;
            isFirstThree = NO;
        }else{

            length = 4;        }
        subString = [text substringToIndex:MIN(text.length, length)];
        
        newString = [newString stringByAppendingString:subString];
        if (subString.length == length) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, length)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    //11为电话号码长度 2为空格
    if (newString.length >= 14) {
        return NO;
    }
    
    [textField setText:newString];
    return NO;
}


-(BOOL)shouldChangeCard:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
#if 0
    NSLog(@"%ld",(long)textField.tag);
    if([textField isKindOfClass:[XHFormatTextFiled class]]){
       
        if(textField.tag==1001 && textField.text.length>0){
            if([string isEqual:@""]|| string.length==0){
                //银行卡修改次数
//                self.cnt_bank_modify=self.cnt_bank_modify+1;
                XHLog(@"您修改了%ld次",self.cnt_bank_modify);
                NSNumber *temp=[[NSUserDefaults standardUserDefaults]objectForKey:@"cnt_bank_modify"];
                NSInteger tempInt=[temp integerValue];
                tempInt=tempInt+1;
                NSNumber *tempnum=[NSNumber numberWithInteger:tempInt];
                [[NSUserDefaults standardUserDefaults]setObject:tempnum forKey:@"cnt_bank_modify"];
                NSNumber *temp2=[[NSUserDefaults standardUserDefaults]objectForKey:@"cnt_bank_modify"];
                XHLog(@"最后保存的数据：%ld",[temp2 integerValue]);
            }
        }     
    }
#endif
     __block NSString *text = [textField text];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    //银行卡16-19位，
    //4*4 + 4 + 3
    if (newString.length >= 24) {
        return NO;
    }
    
    [textField setText:newString];
    return NO;
}

-(BOOL)shouldChangeTelephone:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag==101 && textField.text.length>0){
//        static int cnt_supinfo_modif;
        if([string isEqual:@""]|| string.length==0){
            //其他信息修改次数
//            cnt_supinfo_modif=cnt_supinfo_modif+1;
            
            NSNumber *temp=[[NSUserDefaults standardUserDefaults]objectForKey:@"cnt_supinfo_modif"];
            NSInteger tempInt=[temp integerValue];
            tempInt=tempInt+1;
            NSNumber *tempnum=[NSNumber numberWithInteger:tempInt];
            [[NSUserDefaults standardUserDefaults]setObject:tempnum forKey:@"cnt_supinfo_modif"];
        }
    }

    __block NSString *text = [textField text];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";

    if(text.length<=2)
    {
        [textField setText:text];
        return NO;
    }
    
    NSString* firstNumber= [text substringToIndex:1];
    NSString* secondNumber = [[text substringFromIndex:1]substringToIndex:1];
    BOOL isDicstrict = YES;
    int districtLength = 3;
    int length = 4;
    while (text.length > 0) {
        NSString *subString = nil;
        //第一次三位
        if(isDicstrict)
        {
            //表示国内电话
            if([firstNumber isEqualToString:@"0"])
            {
                if([secondNumber isEqualToString:@"1"] || [secondNumber isEqualToString:@"2"])
                {
                    length = 3;
                }else{
                    length = 4;
                }
            }else{
                //国外电话
                length = 3;
            }
            isDicstrict = NO;
            districtLength = length;
        }else{
            length = 8;
        }
        
        subString = [text substringToIndex:MIN(text.length, length)];
        
        newString = [newString stringByAppendingString:subString];
        if (subString.length == length) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, length)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    //11为电话号码长度 2为空格
    if (newString.length >= districtLength+2+13) {
        return NO;
    }
    
    [textField setText:newString];
    return NO;
}

-(BOOL)shouldChangeIDCard:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    __block NSString *text = [textField text];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    
    
    BOOL isFirstSix = YES;
    int length = 4;
    while (text.length > 0) {
        NSString *subString = nil;
        //第一次三位
        if(isFirstSix)
        {
            length = 6;
            isFirstSix = NO;
        }else{
            
            length = 4;        }
        subString = [text substringToIndex:MIN(text.length, length)];
        
        newString = [newString stringByAppendingString:subString];
        if (subString.length == length) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, length)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    //11为电话号码长度 2为空格
    if (newString.length >= 22) {
        return NO;
    }
    
    [textField setText:newString];
    return NO;
}

-(BOOL)shouldChangeSms:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    __block NSString *text = [textField text];
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    
    
    int length = 3;
    while (text.length > 0) {
        NSString *subString = nil;
        length = 3;
        subString = [text substringToIndex:MIN(text.length, length)];
        
        newString = [newString stringByAppendingString:subString];
        if (subString.length == length) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, length)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    //11为电话号码长度 2为空格
    if (newString.length >= 8) {
        return NO;
    }
    
    [textField setText:newString];
    return NO;
}


@end


@interface XHFormatTextFiled()

@property(nonatomic,retain) XHFormattter*   formatter;

@end

@implementation XHFormatTextFiled

-(XHFormattter*)formatter
{
    if(_formatter == nil)
    {
        _formatter = [[XHFormattter alloc]init];
    }
    
    return _formatter;
}

-(NSString*)formatText{
    if(_formatType != FormatTypeNone)
    {
        NSString* text = [super text];
        return [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return [super text];
}

-(void)setFormatText:(NSString *)text
{
    if(_formatType == FormatTypeNone)
    {
        [super setText:text];
    }
    else if(_formatType == FormatTypePhone)
    {
        [super setText:[self formatTextForPhone:text]];
    }else if(_formatType == FormatTypeCard)
    {
        [super setText:[self formatTextForCard:text]];
    }else if(_formatType == FormatTypeTelephone)
    {
        [super setText:[self formatTextForTelephone:text]];
    }else if(_formatType == FormatTypeIDCard)
    {
        [super setText:[self formatTextForIDCard:text]];
    }else if(_formatType == FormatTypeSms)
    {
        [super setText:[self formatTextForIDCard:text]];
    }
}

-(void)setFormatType:(FormatType)formatType
{
    _formatType = formatType;
    
    if(formatType == FormatTypePhone)
        self.keyboardType = UIKeyboardTypePhonePad;
    else if(formatType == FormatTypeCard)
        self.keyboardType = UIKeyboardTypeNumberPad;
    else if(formatType == FormatTypeTelephone)
        self.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.formatter setFormatType:formatType];
    self.delegate = self.formatter;
}


-(NSString*)formatTextForPhone:(NSString*)srcText
{
    NSMutableString* str = [srcText mutableCopy];
    if(str.length>11)
    {
        NSRange range;
        range.location = 11;
        range.length = str.length-11;
        [str deleteCharactersInRange:range];
        [str insertString:@" " atIndex:7];
        [str insertString:@" " atIndex:3];
    }
    else if(str.length>=8)
    {
        [str insertString:@" " atIndex:7];
        [str insertString:@" " atIndex:3];
    }else if(str.length>=4)
    {
        [str insertString:@" " atIndex:3];
    }
    
    return str;
}

-(NSString*)formatTextForCard:(NSString*)srcText
{
    //（16-19位）
    NSMutableString* str = [srcText mutableCopy];
    if(str.length>19)
    {
        NSRange range;
        range.location = 19;
        range.length = str.length-19;
        [str deleteCharactersInRange:range];
        [str insertString:@" " atIndex:16];
        [str insertString:@" " atIndex:12];
        [str insertString:@" " atIndex:8];
        [str insertString:@" " atIndex:4];
    }
    else if(str.length>16)
    {
        [str insertString:@" " atIndex:16];
        [str insertString:@" " atIndex:12];
        [str insertString:@" " atIndex:8];
        [str insertString:@" " atIndex:4];
    }else if(str.length>12)
    {
        [str insertString:@" " atIndex:12];
        [str insertString:@" " atIndex:8];
        [str insertString:@" " atIndex:4];
    }else if(str.length>8)
    {
        [str insertString:@" " atIndex:8];
        [str insertString:@" " atIndex:4];
    }else if(str.length>4)
    {
        [str insertString:@" " atIndex:4];
    }
    
    return str;
}

-(NSString*)formatTextForTelephone:(NSString*)srcText
{
    // 座机号：0755 88888888 0123
    
    NSMutableString* str = [srcText mutableCopy];
    NSString* firstNumber= [str substringToIndex:1];
    NSString* secondNumber = [[str substringFromIndex:1]substringToIndex:1];
    int districtLength = 3;
    //表示国内电话
    if([firstNumber isEqualToString:@"0"])
    {
        if([secondNumber isEqualToString:@"1"] || [secondNumber isEqualToString:@"2"])
        {
            districtLength = 3;
        }else{
            districtLength = 4;
        }
    }else{
        //国外电话
        districtLength = 3;
    }
    
    if(str.length>districtLength+8+4)
    {
        NSRange range;
        range.location = districtLength+8+4;
        range.length = str.length-range.location;
        [str deleteCharactersInRange:range];
        [str insertString:@" " atIndex:districtLength+8];
        [str insertString:@" " atIndex:districtLength];
    }else if(str.length>districtLength+8)
    {
        [str insertString:@" " atIndex:districtLength+8];
        [str insertString:@" " atIndex:districtLength];
    }else if(str.length>districtLength)
    {
        [str insertString:@" " atIndex:districtLength];
    }
    
    return str;
}

-(NSString*)formatTextForIDCard:(NSString*)srcText
{
    NSMutableString* str = [srcText mutableCopy];
    if(str.length>21)
    {
        NSRange range;
        range.location = 21;
        range.length = str.length-21;
        [str deleteCharactersInRange:range];
        [str insertString:@" " atIndex:14];
        [str insertString:@" " atIndex:10];
        [str insertString:@" " atIndex:6];
    }
    else if(str.length>=8)
    {
        [str insertString:@" " atIndex:10];
        [str insertString:@" " atIndex:6];
    }else if(str.length>=4)
    {
        [str insertString:@" " atIndex:6];
    }
    
    return str;
}

@end
