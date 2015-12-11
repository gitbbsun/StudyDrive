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
@interface AnswerViewController (){
    AnswerScrollView *view;
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
    view =[[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height-64) withDataArrary:arry];
    [self.view addSubview:view];
    [self createToolBar];
    
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
        case 302:{
            if ([view.hadAnswerArray[view.currentPage] intValue]!=0) {
                return;
            }
            else{
                AnswerModel *model=[view.dataArray objectAtIndex:view.currentPage];
                NSString *answer=model.manswer;
                char an=[answer characterAtIndex:0];
                [view.hadAnswerArray replaceObjectAtIndex:view.currentPage withObject:[NSString stringWithFormat:@"%d",an-'A'+1]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
