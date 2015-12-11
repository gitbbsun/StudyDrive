//
//  Tool.h
//  StudyDrive
//
//  Created by MAC on 15-11-21.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tool : NSObject
//解析字符串
+(NSArray *)getAnswerWithString:(NSString *)str;

+(CGSize)getSizeWithString:(NSString *)str with:(UIFont *)font withSize:(CGSize)size;
@end
