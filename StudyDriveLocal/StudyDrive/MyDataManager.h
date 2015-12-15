//
//  MyDataManager.h
//  StudyDrive
//
//  Created by MAC on 15-11-3.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    chapter//章节练习数据
    ,answer//答题数据
    ,subChapter//专项练习
}DataType;

@interface MyDataManager : NSObject


+(NSArray *)getData:(DataType)type;

@end
