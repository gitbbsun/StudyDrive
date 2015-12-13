//
//  AnswerViewController.m
//  StudyDrive
//
//  Created by MAC on 15-11-21.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"
@interface AnswerViewController (){
    AnswerScrollView *_answerScrollView;
    SelectModelView *modelView;
    SheetView * _sheetView;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    NSMutableArray *marray=[[NSMutableArray alloc]init];
    NSArray *arry=[MyDataManager getData:answer];
       for (int i=0; i<arry.count-1;i++) {
       AnswerModel *model=[[AnswerModel alloc]init];
        if ([model.pid intValue]==_number+1) {
        [marray addObject:model];
    }
    }
    _answerScrollView =[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-64) withDataArrary:arry];
    [self.view addSubview:_answerScrollView];
    [self createToolBar];
    [self createModelView];
    [self createSheetView];
    
}
-(void)createSheetView{
    _sheetView=[[SheetView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-80)withSuperView:self.view andQuestionsCount:50];
    _sheetView.delegate=self;
    [self.view addSubview:_sheetView];
    
    
}
//设置代理
-(void)SheetViewClick:(int)index{
    UIScrollView *scroll=_answerScrollView->_scrollView;
    scroll.contentOffset=CGPointMake((index-1)*scroll.frame.size.width, 0);
    [scroll.delegate scrollViewDidEndDecelerating:scroll];
    
}

-(void)createModelView{
    modelView=[[SelectModelView alloc]initwithFrame:self.view.frame addTouch:^(SelectMode model) {
        NSLog(@"111");
    }];
    [self.view addSubview:modelView];
    modelView.alpha=0;
    UIBarButtonItem * item =[[UIBarButtonItem alloc]initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChage:)];
    self.navigationItem.rightBarButtonItem=item;
}

-(void)modelChage:(UIBarButtonItem *)item{
    [UIView animateWithDuration:0.3 animations:^{
        modelView.alpha=1;
    }];
}
                            
-(void)createToolBar{
    NSArray *arr=@[@"1111",@"查看答案",@"收藏本题"];
    UIView *barView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-120, self.view.frame.size.width, 120)];
    barView.backgroundColor=[UIColor whiteColor];
    for(int i=0;i<3;i++){
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(self.view.frame.size.width/3*i+self.view.frame.size.width/3/2-22, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png",16+i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=301+i;
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=arr[i];
        label.font=[UIFont systemFontOfSize:12];
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    [self.view addSubview:barView];
    
}
-(void)clickToolBar:(UIButton *)btn{
    switch (btn.tag) {
            case 301:
        {
        [UIView animateWithDuration:0.3 animations:^{
            _sheetView.frame=CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
            _sheetView->_backView.alpha=0.8;
        }];
        }
        case 302:{
            if ([_answerScrollView.hadAnswerArray[_answerScrollView.currentPage] intValue]!=0) {
                return;
            }
            else{
                AnswerModel *model=[_answerScrollView.dataArray objectAtIndex:_answerScrollView.currentPage];
                NSString *answer=model.manswer;
                char an=[answer characterAtIndex:0];
                [_answerScrollView.hadAnswerArray replaceObjectAtIndex:_answerScrollView.currentPage withObject:[NSString stringWithFormat:@"%d",an-'A'+1]];
            }
        }
           
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
