//
//  Tool.m
//  StudyDrive
//
//  Created by MAC on 15-11-21.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "Tool.h"

@implementation Tool
//字符串解析
+(NSArray *)getAnswerWithString:(NSString *)str{
    NSMutableArray *marray=[[NSMutableArray alloc]init];
    NSArray *array=[str componentsSeparatedByString:@"<BR>"];
    [marray addObject:array[0]];
    for (int i=0; i<4;i++) {
        [marray addObject:[array[i+1] substringFromIndex:2]];
    }
    return marray;
}
+(CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize:(CGSize)size{
    CGSize newSize=[str sizeWithFont:font constrainedToSize:size];
    return newSize;
}
@end
