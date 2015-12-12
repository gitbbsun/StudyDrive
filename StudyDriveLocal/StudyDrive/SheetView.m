//
//  SheetView.m
//  StudyDrive
//
//  Created by binbinsun on 15/12/12.
//  Copyright © 2015年 MAC. All rights reserved.
//

#import "SheetView.h"
@interface SheetView(){
    UIView * _superView;
    BOOL _startMoving;
    float _height;
    float _width;
    float _y;
    UIScrollView *_scrollView;
    int _count;
}
@end

@implementation SheetView
-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView andQuestionsCount:(int)count{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        _superView=superView;
        _height=self.frame.size.height;
        _width=self.frame.size.width;
        _y=frame.origin.y;
        _count=count;
        [self createView];
    }
    return self;
}
//创建题目的抽屉视图
-(void)createView{
    _backView=[[UIView alloc]initWithFrame:_superView.frame];
    _backView.backgroundColor=[UIColor blackColor];
    _backView.alpha=0;
    [_superView addSubview:_backView];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height-70)];
    _scrollView.backgroundColor=[UIColor redColor];
    [self addSubview:_scrollView];
    for (int i=0; i<_count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.layer.masksToBounds=YES;
        btn.layer.cornerRadius=8;
        btn.frame=CGRectMake((_width-44*6)/2+44*(i%6), 10+44*(i/6), 40, 40);
        btn.backgroundColor=[UIColor colorWithRed:220/225.0 green:220/225.0 blue:220/225.0 alpha:1];
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [_scrollView addSubview:btn];
    }
    int tip=(_count%6)?1:0;
    _scrollView.contentSize=CGSizeMake(0, 20+44*(_count/6+1+tip));
}
//手势触摸移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:[touch view]];
    if (point.y<25) {
        _startMoving=YES;
    }
    if (_startMoving && self.frame.origin.y>=_y-_height && [self convertPoint:point toView:_superView].y>=80) {
        self.frame=CGRectMake(0, [self convertPoint:point toView:_superView].y, _width, _height);
        float offset=(_superView.frame.size.height- self.frame.origin.y)/_superView.frame.size.height*0.8;
        _backView.alpha=offset;
        
    }
}
//手势触摸结束
-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _startMoving=NO;
    if (self.frame.origin.y>=_y-_height/2) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(0, _y, _width, _height);
            _backView.alpha=0;
        }];
    }
    else{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame=CGRectMake(0, _y-_height, _width, _height);
        _backView.alpha=0.8;
    }];
    }
}
@end
