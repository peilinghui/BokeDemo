//
//  PLHDBHandle.m
//  示例Table
//
//  Created by peilinghui on 2017/6/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHDBHandle.h"
#import "FMDatabase.h"
@implementation PLHDBHandle

static FMDatabase *_db;

+(void)initialize
{
    //打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"searchModel.sqilte"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    //创建表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_searchModel (id integer PRIMARY KEY, searchModel blob NOT NULL, searchModel_idstr varchar NOT NULL)"];
}

+ (NSDictionary *)statusesWithParams:(NSDictionary *)params
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
    if (params[@"category"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_searchModel WHERE searchModel_idstr = %@ ;", params[@"category"]];
    }else{
        sql = @"SELECT * FROM t_searchModel;";
    }
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"searchModel"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        return status;
    }
    return @{};
}


+ (void)saveStatuses:(NSDictionary *)statuses andParam:(NSDictionary *)ParamDict
{
    NSString *category = ParamDict[@"category"];
    
    [PLHDBHandle delect:ParamDict[@"category"]];
    
    NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:statuses];
    [_db executeUpdateWithFormat:@"INSERT INTO t_searchModel(searchModel, searchModel_idstr) VALUES (%@, %@);", statusData, category];
}

+ (BOOL)delect:(NSString *)searchModel_idstr
{
    BOOL success = YES ;
    NSString * newSql = [NSString stringWithFormat:@"DELETE  FROM t_searchModel WHERE searchModel_idstr = ?"];
    BOOL isCan =  [_db executeUpdate:newSql,searchModel_idstr];
    if (!isCan) {
        success = NO;
    }
    return success;
}


@end
