//
//  AnswerViewController.h
//  StudyDrive
//
//  Created by MAC on 15-11-21.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController
@property(nonatomic,assign)int number;
@property(nonatomic,copy)NSString *SubStrNumber;
//1=章节 2=顺序 3＝随机 4=专项
@property(nonatomic,assign)int type;
@end
