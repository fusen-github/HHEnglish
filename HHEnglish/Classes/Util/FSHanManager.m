//
//  FSHanManager.m
//  HHEnglish
//
//  Created by 付森 on 2018/12/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSHanManager.h"
#import "FMDB.h"

@interface FSHanManager ()
{
    FMDatabase *_dataBase;
}

@end

@implementation FSHanManager

static FSHanManager *_manager;

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *path = [cache stringByAppendingPathComponent:@"honghan.sqlite"];
        
        _dataBase = [FMDatabase databaseWithPath:path];
        
        NSString *hh_phrase =
        @"create table if not exists hh_phrase ("
         "chinese text not null, "
         "english text not null, "
         "operate_date text not null "
         ");";
        
        if (![_dataBase isOpen]) {
            if (![_dataBase open]) {
                return nil;
            }
        }
        
        [_dataBase executeStatements:hh_phrase];
        
        [_dataBase close];
    }
    return self;
}

- (BOOL)insertPhraseForDictionary:(NSDictionary *)dict
{
    if (![_dataBase open]) {
        return NO;
    }
    
    NSString *sql = @"insert into hh_phrase values ("
    ":chinese,   :english,  :operate_date"
    ")";
    
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    [tmpDict removeObjectForKey:@"rowid"];
    
    BOOL executeRet = [_dataBase executeUpdate:sql withParameterDictionary:tmpDict];
    
    [_dataBase close];
    
    return executeRet;
}

- (BOOL)updatePhraseForDictionary:(NSDictionary *)dict
{
    return YES;
}

- (BOOL)batchSavePhrases:(NSArray<NSDictionary *> *)array
{
    return YES;
}

- (NSArray *)queryPhrases
{
    NSString *sql = @"select rowid, * from hh_phrase";
    
    return [self queryPhrasesBySql:sql];
}

- (NSArray *)queryPhrasesBySql:(NSString *)sql
{
    [_dataBase open];
    
    FMResultSet *resultSet = [_dataBase executeQuery:sql];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    while ([resultSet next])
    {
        NSDictionary *dict = [resultSet resultDictionary];
        
        [tmpArray addObject:dict];
    }
    
    [_dataBase close];
    
    return tmpArray;
}



@end
