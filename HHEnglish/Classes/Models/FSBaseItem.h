//
//  FSBaseItem.h
//  HHEnglish
//
//  Created by 付森 on 2018/12/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSBaseItem : NSObject

+ (instancetype)itemWithDict:(NSDictionary *)dict;

- (NSDictionary *)toDictionary;

@end
