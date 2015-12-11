//
//  MyDataManager.m
//  StudyDrive
//
//  Created by MAC on 15-11-3.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "MyDataManager.h"
#import "FMDatabase.h"
#import "SecModel.h"
#import "AnswerModel.h"
@implementation MyDataManager
+(NSArray *)getData:(DataType)type{
    static FMDatabase *dataBase;
    NSMutableArray *mutableArray=[[NSMutableArray alloc]init];
    if (dataBase==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
        dataBase=[[FMDatabase alloc]initWithPath:path];
    };
    if ([dataBase open]) {
        NSLog(@"open success.");
    }else
    {
        return mutableArray;
    }
    switch (type) {
        case chapter:
        {
        NSString *sql=@"select pid,pname,pcount FROM firstlevel";
            FMResultSet *result=[dataBase executeQuery:sql];
            while ([result next]) {
                SecModel *model=[[SecModel alloc]init];
                model.pid=[NSString stringWithFormat:@"%d",[result intForColumn:@"pid"]];
                model.pname=[result stringForColumn:@"pname"];
                model.pcount=[NSString stringWithFormat:@"%d",[result intForColumn:@"pcount"]];
                [mutableArray addObject:model];
            }
        }
            break;
        case answer:
        {
            NSString *sql=@"select mquestion,mdesc,mid,manswer,mimage,pid,pname,sid,sname,mtype FROM Leaflevel";
            FMResultSet *result=[dataBase executeQuery:sql];
            while ([result next]) {
                AnswerModel *model=[[AnswerModel alloc]init];
                model.mquestion=[result stringForColumn:@"mquestion"];
                 model.mdesc=[result stringForColumn:@"mdesc"];
                 model.mid=[NSString stringWithFormat:@"%d",[result intForColumn:@"mid"]];
                 model.manswer=[result stringForColumn:@"manswer"];
                 model.mimage=[result stringForColumn:@"mimage"];
                model.pid=[NSString stringWithFormat:@"%d",[result intForColumn:@"pid"]];
                 model.pname=[result stringForColumn:@"pname"];
                 model.sid=[NSString stringWithFormat:@"%d",[result intForColumn:@"sid"]];
                 model.sname=[result stringForColumn:@"sname"];
                 model.mtype=[NSString stringWithFormat:@"%d",[result intForColumn:@"mtype"]];
                [mutableArray addObject:model];
            }
        }
            break;
        default:
            break;
    }
    return mutableArray;
}
@end
