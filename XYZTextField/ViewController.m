//
//  ViewController.m
//  XYZTextField
//
//  Created by xieyingze on 16/7/23.
//  Copyright © 2016年 xieyingze. All rights reserved.
//

#import "ViewController.h"
#import "XHFormatTextFiled.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet XHFormatTextFiled *tfPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbResult;
@property (weak, nonatomic) IBOutlet UILabel *lbType;

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configuration];
}

#pragma mark - configuration

- (void)configuration
{
    self.tfPhone.formatType = FormatTypeNone;
    self.lbType.text = @"FormatTypeNone";
}

#pragma mark - BaseMethods


#pragma mark - Delegate


#pragma mark - EventResponse

- (IBAction)clickShowBtn:(id)sender {
    
    [self.tfPhone resignFirstResponder];
    self.lbResult.text = [self.tfPhone formatText];
}
- (IBAction)clickSelectType:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            self.tfPhone.formatType = FormatTypeNone;
            self.lbType.text = @"FormatTypeNone";
            break;
        case 2:
            self.tfPhone.formatType = FormatTypePhone;
            self.lbType.text = @"FormatTypePhone";
            break;
        case 3:
            self.tfPhone.formatType = FormatTypeCard;
            self.lbType.text = @"FormatTypeCard";
            break;
        case 4:
            self.tfPhone.formatType = FormatTypeTelephone;
            self.lbType.text = @"FormatTypeTelephone";
            break;
        case 5:
            self.tfPhone.formatType = FormatTypeIDCard;
            self.lbType.text = @"FormatTypeIDCard";
            break;
        case 6:
            self.tfPhone.formatType = FormatTypeSms;
            self.lbType.text = @"FormatTypeSms";
            break;
            
        default:
            break;
    }
}

#pragma mark - GettersAndSetters

@end
