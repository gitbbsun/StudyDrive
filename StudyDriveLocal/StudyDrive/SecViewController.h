//
//  SecViewController.h
//  StudyDrive
//
//  Created by MAC on 15-11-1.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "ViewController.h"

@interface SecViewController : ViewController
@property(nonatomic,copy)NSString *myTitle;//property 自动回生成get,set方法
@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,assign)int type;//type＝1 章节练习 2:专项
@end
