//
//  WIAppKVCell.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/28.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppKVCell.h"
#import "WIAppKVViewModel.h"
#import "WIAppKVModel.h"

NSString * const WIAppKVCellId = @"WIAppKVCellId";

@interface WIAppKVCell ()
{
    IBOutlet UIButton *_indicatorButton;
    IBOutlet UILabel *_textLabel;
}
@end

@implementation WIAppKVCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    UILongPressGestureRecognizer * longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.contentView addGestureRecognizer:longPressGestureRecognizer];
    [longPressGestureRecognizer release];
}

- (void)setData:(WIAppKVViewModel *)viewModel
{
    NSString * indicatorTitle = nil;
    NSString * text = nil;
    WIAppKVModel * model = viewModel.kvModel;
    if(model.modelType == WIAppKVModelTypeArray){
        if(viewModel.isUnFold){
            indicatorTitle = [NSString stringWithFormat:@"-[%d]",model.childCount];
        }else{
            indicatorTitle = [NSString stringWithFormat:@"+[%d]",model.childCount];
        }
        text = model.key;
        _indicatorButton.enabled = YES;
    }else if(model.modelType == WIAppKVModelTypeDictionary){
        if(viewModel.isUnFold){
            indicatorTitle = [NSString stringWithFormat:@"-{%d}",model.childCount];
        }else{
            indicatorTitle = [NSString stringWithFormat:@"+{%d}",model.childCount];
        }
        text = model.key;
        _indicatorButton.enabled = YES;
    }else{
        indicatorTitle = @"·";
        if(model.key){
            text = [NSString stringWithFormat:@"%@: %@",[model.key description], [model.value description]];
        }else{
            text = [NSString stringWithFormat:@"%@",[model.value description]];
        }
        _indicatorButton.enabled = NO;
    }
    [_indicatorButton setTitle:indicatorTitle forState:UIControlStateNormal];
    [_indicatorButton setTitle:indicatorTitle forState:UIControlStateHighlighted];
    if(text.length == 0) text = @"";
    _textLabel.text = text;
    
    [_indicatorButton sizeToFit];
    
    CGFloat levelOffset = WIAppKVIndentationUnit * model.level;
    CGRect indicatorButtonFrame = _indicatorButton.frame;
    CGPoint indicatorButtonOrigin = indicatorButtonFrame.origin;
    indicatorButtonOrigin.x = levelOffset;
    indicatorButtonFrame.origin = indicatorButtonOrigin;
    CGSize indicatorButtonSize = indicatorButtonFrame.size;
    indicatorButtonSize.height = CGRectGetHeight(self.contentView.bounds);
    indicatorButtonSize.width = MAX(indicatorButtonSize.width, 40.0f);
    indicatorButtonFrame.size = indicatorButtonSize;
    _indicatorButton.frame = indicatorButtonFrame;
    CGRect textLabelFrame = _textLabel.frame;
    CGPoint textLabelOrigin = textLabelFrame.origin;
    textLabelOrigin.x =  CGRectGetMaxX(_indicatorButton.frame);
    textLabelFrame.origin = textLabelOrigin;
    CGSize textLabelSize = textLabelFrame.size;
    textLabelSize.width = CGRectGetWidth(self.contentView.frame) - CGRectGetMinX(textLabelFrame) - 8.0f;
    textLabelFrame.size = textLabelSize;
    _textLabel.frame = textLabelFrame;
}

+ (CGFloat)heightForData:(id)data
{
    return 30.0;
}

- (IBAction)actionButtonPressed:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(wiappKVCellActionRequest:)]){
        [_delegate wiappKVCellActionRequest:self];
    }
}

- (void)longPressGestureRecognized: (UILongPressGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
        if(!keyWindow) return;
        CGPoint locationInWindow = [gestureRecognizer locationInView:keyWindow];
        if(_delegate && [_delegate respondsToSelector:@selector(wiappKVCellSeeMoreRequest: triggerPoint:)]){
            [_delegate wiappKVCellSeeMoreRequest:self triggerPoint:locationInWindow];
        }
    }
}

- (void)dealloc {
    [_indicatorButton release];
    [_textLabel release];
    [super dealloc];
}
@end









































