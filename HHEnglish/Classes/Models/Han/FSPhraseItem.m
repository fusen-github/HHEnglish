//
//  FSPhraseItem.m
//  HHEnglish
//
//  Created by 付森 on 2018/12/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSPhraseItem.h"

@implementation FSPhraseItem

+ (instancetype)itemWithDict:(NSDictionary *)dict
{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    FSPhraseItem *item = [[FSPhraseItem alloc] init];
    
    item->_rowId = [[dict objectForKey:@"rowid"] integerValue];
    
    item.chinese = [dict objectForKey:@"chinese"];
    
    item.english = [dict objectForKey:@"english"];
    
    item.operateDate = [dict objectForKey:@"operate_date"];
    
    return item;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@(self.rowId) forKey:@"rowid"];
    
    [dict setObject:self.chinese forKey:@"chinese"];
    
    [dict setObject:self.english forKey:@"english"];
    
    [dict setObject:self.operateDate forKey:@"operate_date"];
    
    return dict;
}

@end
