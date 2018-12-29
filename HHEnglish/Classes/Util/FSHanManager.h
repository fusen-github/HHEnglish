//
//  FSHanManager.h
//  HHEnglish
//
//  Created by 付森 on 2018/12/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSHanManager : NSObject

+ (instancetype)shareManager;

- (BOOL)insertPhraseForDictionary:(NSDictionary *)dict;

- (BOOL)updatePhraseForDictionary:(NSDictionary *)dict;

- (BOOL)batchSavePhrases:(NSArray <NSDictionary *> *)array;

- (NSArray *)queryPhrases;

- (NSArray *)queryPhrasesBySql:(NSString *)sql;

@end
