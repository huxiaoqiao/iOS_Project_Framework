//
//  BaseModel.m
//  iOS项目的目录结构和开发流程_OC
//
//  Created by 胡晓桥 on 15/5/1.
//  Copyright (c) 2015年 胡晓桥. All rights reserved.
//
/**
 使用方法：将Model文件继承BaseModel类 然后重写- (void)setAttributes:(NSDictionary *)jsonDic方法
 */

#import "BaseModel.h"

@implementation BaseModel

- (id)initWithDataDic:(NSDictionary *)data
{
    if (self == [super init]) {
        [self setAttribute:data];
    }
    return self;
}
- (void)setAttribute:(NSDictionary *)dataDic
{
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    if (attrMapDic == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[dataDic count]];
        for(NSString *key in dataDic)
        {
            [dic setValue:key forKey:key];
            attrMapDic = dic;
        }
    }
    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    id attributeName;
    while ((attributeName = [keyEnum nextObject])) {
        SEL sel = [self getSetterSelWithAttributeName:attributeName];
        if ([self respondsToSelector:sel]) {
            NSString *dataDicKey = [attrMapDic objectForKey:attributeName];
            id attributeValue = [dataDic objectForKey:dataDicKey];
            [self performSelectorOnMainThread:sel withObject:attributeValue waitUntilDone:[NSThread isMainThread]];
        }
    }
}
- (NSDictionary *)attributeMapDictionary
{
    return nil;
}

- (SEL)getSetterSelWithAttributeName:(NSString *)atrributeName
{
    NSString *captial = [[atrributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@",captial,[atrributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        NSDictionary *attrMapDic = [self attributeMapDictionary];
        if (attrMapDic == nil) {
            return self;
        }
        NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
        id attributeName;
        while ((attributeName = [keyEnum nextObject])) {
            SEL sel = [self getSetterSelWithAttributeName:attributeName];
            
            if ([self respondsToSelector:sel]) {
                id obj = [decoder decodeObjectForKey:attributeName];
                [self performSelectorOnMainThread:sel withObject:obj waitUntilDone:[NSThread isMainThread]];
            }
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    if (attrMapDic == nil) {
        return;
    }
}

- (NSString *)customDescription
{
    return nil;
}
- (NSString *)description
{
    NSMutableString *attrsDesc = [NSMutableString stringWithCapacity:100];
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    id attributeName;
    while (attributeName = [keyEnum nextObject]) {
        SEL getSel = NSSelectorFromString(attributeName);
        if ([self respondsToSelector:getSel]) {
            NSMethodSignature *signature = nil;
            signature = [self methodSignatureForSelector:getSel];
            NSInvocation *invacation = [NSInvocation invocationWithMethodSignature:signature];
            [invacation setTarget:self];
            [invacation setSelector:getSel];
            NSObject *valueObj = nil;
            [invacation invoke];
            [invacation getReturnValue:&valueObj];
            
            if (valueObj) {
                [attributeName appendFormat:@"[%@=%@]",attributeName,valueObj];
                
            }else
            {
                [attrsDesc appendFormat:@"[%@=nil]",attributeName];
            }
        }
    }
    NSString *customDesc = [self customDescription];
    NSString *desc;
    if (customDesc && [customDesc length] > 0) {
        desc = [NSString stringWithFormat:@"%@:{%@,%@}",[self class],attrsDesc,customDesc];
    }else
    {
        desc = [NSString stringWithFormat:@"%@:{%@}",[self class],attrsDesc];
    }
    
    return desc;
    
}
- (NSData *)getArchivedData
{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}
- (NSString *)cleanString:(NSString *)str
{
    if (str == nil) {
        return @"";
    }
    NSMutableString *cleanString = [NSMutableString stringWithString:str];
    [cleanString replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [cleanString length])];
    [cleanString replaceOccurrencesOfString:@"\r" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [cleanString length])];
    return cleanString;
}

#ifdef _FOR_DEBUG_
- (BOOL)respondsToSelector:(SEL)aSelector
{
    [NSStringFromSelector(aSelector) UTF8String];
    return [super respondsToSelector:aSelector];
}
#endif

@end
