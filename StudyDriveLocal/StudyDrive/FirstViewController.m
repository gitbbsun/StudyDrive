//
//  FirstViewController.m
//  StudyDrive
//
//  Created by MAC on 15-11-1.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "SecViewController.h"
#import "MyDataManager.h"
#import "AnswerViewController.h"
@interface FirstViewController()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *_dataArray1;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArray1=@[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真模拟考试"];
    [self CreateTableView];
    [self CreateView];
}
-(void)CreateView{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150,self.view.frame.size.height-64-140, 300, 30)];
    NSLog(@"My view frame: %@", NSStringFromCGRect(self.view.frame));
    label.text=@"...............我的考试分析...............";
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    NSArray *array=@[@"我的错题",@"我的收藏",@"我的成绩",@"练习统计"];
    for (int i=0; i<4; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-100, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+12]]forState:UIControlStateNormal];
        [self.view addSubview:btn];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30,self.view.frame.size.height-64-35, 60, 20)];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.text=array[i];
        lab.font=[UIFont boldSystemFontOfSize:13];
        [self.view addSubview:lab];
    }
}
-(void)CreateTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,5,self.view.frame.size.width,260) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"FirstTableViewCell";
    FirstTableViewCell *cell=[tableView dequeueReusableHeaderFooterViewWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil]lastObject];
    }
    cell.MyImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",indexPath.row+7]];
    cell.myLabel.text=_dataArray1[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            SecViewController *sec=[[SecViewController alloc]init];
            sec.dataArray=[MyDataManager getData:chapter];
            sec.myTitle=@"章节练习";
            sec.type=1;
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:sec animated:YES];

        }
            break;
        case 1://顺序练习
        {
            AnswerViewController * answer=[[AnswerViewController alloc]init];
            answer.type=2;
            answer.title=@"顺序练习";
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:answer animated:YES];
            
        }
            break;
        case 2://随机练习
        {
            AnswerViewController * answer=[[AnswerViewController alloc]init];
            answer.type=3;
            answer.title=@"随机练习";
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:answer animated:YES];
            
        }
            break;
        case 3://专项练习
        {
            SecViewController *sec=[[SecViewController alloc]init];
            sec.dataArray=[MyDataManager getData:subChapter];
            sec.myTitle=@"专项练习";
            sec.type=2;
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:sec animated:YES];
            
        }
            break;
        default:
            break;
    }
}
@end
