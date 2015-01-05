//
//  WIAppKVViewModel.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/28.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    WIAppKVModelTypeSimple,
    WIAppKVModelTypeDictionary,
    WIAppKVModelTypeArray,
}WIAppKVModelType;

//从KV数据中生成一个CellModel数组用于展示
@interface WIAppKVModel : NSObject

@property (nonatomic, retain) id                key;
@property (nonatomic, retain) id                value;

@property (nonatomic, assign) WIAppKVModelType  modelType;
@property (nonatomic, assign) NSUInteger        level;
@property (nonatomic, assign) NSUInteger        childCount;

+ (WIAppKVModel *)model;
+ (WIAppKVModel *)dictModel;
+ (WIAppKVModel *)arrayModel;



@end
