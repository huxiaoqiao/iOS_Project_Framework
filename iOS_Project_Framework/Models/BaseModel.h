//
//  BaseModel.h
//  iOS项目的目录结构和开发流程_OC
//
//  Created by 胡晓桥 on 15/5/1.
//  Copyright (c) 2015年 胡晓桥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (id)initWithDataDic:(NSDictionary *)data;
- (NSDictionary *)attributeMapDictionary;
- (void)setAttribute:(NSDictionary *)dataDic;
- (NSString *)customDescription;
- (NSString *)description;
- (NSData *)getArchivedData;
- (NSString *)cleanString:(NSString *)str;//清除除\n和\r的字符串

@end
