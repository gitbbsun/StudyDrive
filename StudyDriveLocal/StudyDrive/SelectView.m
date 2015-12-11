//
//  SelectView.m
//  StudyDrive
//
//  Created by MAC on 15-10-31.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView
{
    UIButton *_button;
}
-(instancetype)initWithFrame:(CGRect)frame andBtn :(UIButton *)btn{
    self=[super initWithFrame:frame];
    if (self) {
       self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _button=btn;
        [self CreateBtn];
    }
    return self;
}
-(void) CreateBtn{
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(self.frame.size.width/4*i+self.frame.size.width/4/2-30, self.frame.size.height-80, 60,60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
    self.alpha=0;
}];
}
-(void)click:(UIButton *)btn{
    [_button setImage:[btn backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    }];}
@end
