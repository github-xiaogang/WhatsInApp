//
//  WIAppKVViewModel.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/28.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppKVModel.h"

@implementation WIAppKVModel

+ (WIAppKVModel *)model
{
    return [[[WIAppKVModel alloc] init] autorelease];
}

+ (WIAppKVModel *)modelWithType: (WIAppKVModelType)modelType
{
    WIAppKVModel * model = [WIAppKVModel model];
    model.modelType = modelType;
    return model;
}

+ (WIAppKVModel *)dictModel
{
   return [WIAppKVModel modelWithType:WIAppKVModelTypeDictionary];
}

+ (WIAppKVModel *)arrayModel
{
    return [WIAppKVModel modelWithType:WIAppKVModelTypeArray];
}

- (NSString *)description
{
    NSMutableString * mutableDesc = [NSMutableString string];
    NSString * valueDesc = nil;
    if(self.modelType == WIAppKVModelTypeArray){
        valueDesc = [NSString stringWithFormat:@"[%d]",self.childCount];
    }else if(self.modelType == WIAppKVModelTypeDictionary){
        valueDesc = [NSString stringWithFormat:@"{%d}",self.childCount];
    }else{
        valueDesc = [self.value description];
    }
    for (int i=0; i<self.level; i++) {
        [mutableDesc appendString:@"+-----"];
    }
    [mutableDesc appendFormat:@"'%@' -> %@",self.key ? self.key : @"",valueDesc];
    return mutableDesc;
}

- (void)dealloc
{
    [_key release];
    [_value release];
    [super dealloc];
}

@end




























