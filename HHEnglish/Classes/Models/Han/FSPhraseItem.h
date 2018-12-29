//
//  FSPhraseItem.h
//  HHEnglish
//
//  Created by 付森 on 2018/12/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSHanItem.h"

@interface FSPhraseItem : FSHanItem

@property (nonatomic, assign, readonly) NSInteger rowId;

@property (nonatomic, copy) NSString *chinese;

@property (nonatomic, copy) NSString *english;

/// 格式YYYYMMdd
@property (nonatomic, copy) NSString *operateDate;

@end
