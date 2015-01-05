//
//  WIAppKVUtil.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/31.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppKVUtil.h"
#import "WIAppKVModel.h"

@interface NSObject (WIAppKVExtends)

- (BOOL)isContainer;
- (BOOL)isDictionary;
- (BOOL)isArray;

@end

@implementation WIAppKVUtil

+ (NSArray *)constructKVModel: (id)data
{
    //从kvData -> cellModelList;
    NSMutableArray * mutableModelList = [NSMutableArray array];
    NSUInteger level = 0;
    [self handleDataWithKey:nil value:data workingLevel:level addToArray:mutableModelList];
    return mutableModelList;
}

//数组
//字典
//kv    格式数据
//v     格式数据

+ (void)handleDataWithKey: (id)key value: (id)data workingLevel:(NSUInteger)level addToArray : (NSMutableArray *)results
{
    if([data isContainer]){
        if([data isDictionary]){
            [self handleDictDataWithKey:key value: data workingLevel:level addToArray:results];
        }else if([data isArray]){
            [self handleArrayDataWithKey: key value: data workingLevel:level addToArray:results];
        }
    }else{
        //简单数据
        [self handleSimpleDataWithKey: key value: data workingLevel:level addToArray:results];
    }
}

//Dictionary
+ (void)handleDictDataWithKey: (id)key value: (NSDictionary *)dicValue workingLevel:(NSUInteger)level addToArray : (NSMutableArray *)results
{
    NSAssert([dicValue isDictionary], @"");
    WIAppKVModel * dicModel = [WIAppKVModel dictModel];
    dicModel.key = key;
    dicModel.value = dicValue;
    dicModel.level = level;
    dicModel.childCount = [dicValue count];
    [results addObject:dicModel];
    //枚举
    [dicValue enumerateKeysAndObjectsUsingBlock:^(id key, id data, BOOL *stop) {
        [self handleDataWithKey:key value:data workingLevel:level+1 addToArray:results];
    }];
}

+ (void)handleArrayDataWithKey: (id)key value: (NSArray *)arrayValue workingLevel:(NSUInteger)level addToArray : (NSMutableArray *)results
{
    NSAssert([arrayValue isArray], @"");
    WIAppKVModel * arrayModel = [WIAppKVModel arrayModel];
    arrayModel.key = key;
    arrayModel.value = arrayValue;
    arrayModel.level = level;
    arrayModel.childCount = arrayValue.count;
    [results addObject:arrayModel];
    [arrayValue enumerateObjectsUsingBlock:^(id data, NSUInteger idx, BOOL *stop) {
        [self handleDataWithKey:nil value:data workingLevel:level+1 addToArray:results];
    }];
}

+ (void)handleSimpleDataWithKey: (id)key value: (id)simpleValue workingLevel:(NSUInteger)level addToArray : (NSMutableArray *)results
{
    WIAppKVModel * model = [WIAppKVModel model];
    model.key = key;
    model.value = simpleValue;
    model.level = level;
    model.childCount = 0;
    [results addObject:model];
}

@end


@implementation NSObject (WIAppKVExtends)

- (BOOL)isContainer
{
    return ([self isDictionary] || [self isArray]);
}

- (BOOL)isDictionary
{
    return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)isArray
{
    return [self isKindOfClass:[NSArray class]];
}

@end








