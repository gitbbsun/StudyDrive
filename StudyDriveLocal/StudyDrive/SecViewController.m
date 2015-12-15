//
//  SecViewController.m
//  StudyDrive
//
//  Created by MAC on 15-11-1.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "SecViewController.h"
#import "SecTableViewCell.h"
#import "FMDatabase.h"
#import "SecModel.h"
#import "AnswerViewController.h"
#import "SubSecModel.h"
@interface SecViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
}

@end

@implementation SecViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_myTitle;
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    [self CreatTableView];
}
-(void)CreatTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"SecTableViewCell";
    SecTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        cell.selectionStyle=UITableViewCellEditingStyleNone;
        cell.numberLabel.layer.masksToBounds=YES;
        cell.numberLabel.layer.cornerRadius=8;
    }
    if (_type==1) {
       SecModel *model=_dataArray[indexPath.row];
       cell.numberLabel.text=model.pid;
       cell.titleLabel.text=model.pname;
    }
    else{
        SubSecModel * model=_dataArray[indexPath.row];
        cell.numberLabel.text=model.serial;
        cell.titleLabel.text=model.sname;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerViewController *answerView=[[AnswerViewController alloc]init];
    //answerView.title=@"章节练习";
    UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
    item.title=@"";
    self.navigationItem.backBarButtonItem=item;
    answerView.number=indexPath.row;
    if (_type==1) {
         answerView.type=1;
    }else{
         answerView.type=4;
    }    
    [self.navigationController pushViewController:answerView animated:YES];

}
@end
