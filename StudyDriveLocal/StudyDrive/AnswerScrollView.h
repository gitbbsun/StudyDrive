//
//  AnswerScrollView.h
//  StudyDrive
//
//  Created by MAC on 15-11-12.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerScrollView : UIView{
@public
    UIScrollView *_scrollView;
}
-(instancetype)initWithFrame:(CGRect)frame withDataArrary:(NSArray *)array;
@property(nonatomic,assign,readonly) int currentPage;
@property(nonatomic,strong) NSMutableArray *hadAnswerArray;
@property(nonatomic,strong)NSArray *dataArray;

@end
