//
//  AnswerScrollView.m
//  StudyDrive
//
//  Created by MAC on 15-11-12.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tool.h"
#define SIZE self.frame.size
@interface AnswerScrollView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{

}
@end
@implementation AnswerScrollView
{
   // UIScrollView *_scrollView;
    UITableView *_leftTableView;
    UITableView *_mainTableView;
    UITableView *_rightTableView;   
}

-(instancetype)initWithFrame:(CGRect)frame withDataArrary:(NSArray *)array{
    self=[super initWithFrame:frame];
    if (self) {
        _currentPage=0;
        _dataArray=[[NSArray alloc]initWithArray:array];
        _hadAnswerArray=[[NSMutableArray alloc]init];
        for (int i=0; i<array.count; i++) {
            [_hadAnswerArray addObject:@"0"];//一开始都存为0，
        }
        _scrollView=[[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate=self;
        _leftTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.delegate=self;
        _leftTableView.dataSource=self;
        _mainTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView.delegate=self;
        _mainTableView.dataSource=self;
        _rightTableView=[[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView.delegate=self;
        _rightTableView.dataSource=self;
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.showsHorizontalScrollIndicator=NO;
        if (_dataArray.count>1) {
            _scrollView.contentSize=CGSizeMake(SIZE.width*2,0);
        }
        [self CreateView];
    }
    return self;
}

-(void)CreateView{
    _leftTableView.frame=CGRectMake(0,0, SIZE.width,SIZE.height);
    _mainTableView.frame=CGRectMake(SIZE.width,0,SIZE.width, SIZE.height);
    _rightTableView.frame=CGRectMake(SIZE.width*2,0,SIZE.width,SIZE.height);
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_mainTableView];
    [_scrollView addSubview:_rightTableView];
    [self addSubview:_scrollView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    AnswerModel *model=[self getFitModel:tableView];
    CGFloat hight;
    if ([model.mtype intValue]==1){
        NSString *str=[[Tool getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font=[UIFont systemFontOfSize:16];
        hight= [Tool getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    }else
    {
        NSString *str=model.mquestion;
        UIFont *font=[UIFont systemFontOfSize:16];
        hight= [Tool getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    }
    if (hight<=80) {
        return  80;
    }else{
        return hight;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AnswerModel *model=[self getFitModel:tableView];
    CGFloat hight;
    NSString *str;
    if ([model.mtype intValue]==1){
        str=[[Tool getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font=[UIFont systemFontOfSize:16];
        hight= [Tool getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    }else
    {
        NSString *str=model.mquestion;
        UIFont *font=[UIFont systemFontOfSize:16];
        hight= [Tool getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,SIZE.width,100)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, tableView.frame.size.width-20, hight-20)];
    label.text=[NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView  andCurrentPage:_currentPage],str];
    label.font=[UIFont systemFontOfSize:16];
    label.numberOfLines=0;
    [view addSubview:label];
    return  view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AnswerModel *model=[self getFitModel:tableView];
    NSString *str=[NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont *font=[UIFont systemFontOfSize:16];
    return [Tool getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    AnswerModel *model=[self getFitModel:tableView];
    CGFloat hight;
    NSString *str;
    str=[NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont *font=[UIFont systemFontOfSize:16];
    hight= [Tool getSizeWithString:str with:font withSize:CGSizeMake(tableView.frame.size.width-20,400)].height+20;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,SIZE.width,100)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, hight-20)];
    label.text=str;
    label.font=[UIFont systemFontOfSize:16];
    label.numberOfLines=0;
    label.textColor=[UIColor greenColor];
    [view addSubview:label];
    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if ([_hadAnswerArray[page-1] intValue]!=0) {
        return view;//答题才会给显示答案
    }
    return  nil;//没答题就不给显示

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerTableViewCell *answerCell=[tableView dequeueReusableCellWithIdentifier:@"AnswerTableViewCell"];
    if (answerCell==nil) {
        answerCell=[[[NSBundle mainBundle]loadNibNamed:@"AnswerTableViewCell" owner:self options:nil]lastObject];
        answerCell.numberLabel.layer.masksToBounds=YES;
        answerCell.numberLabel.layer.cornerRadius=10;
        answerCell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    answerCell.numberLabel.text=[NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    AnswerModel *model=[self getFitModel:tableView];
    if ([model.mtype intValue]==1) {
        answerCell.answerLabel.text=[[Tool getAnswerWithString:model.mquestion]objectAtIndex:indexPath.row+1];
    }
    //
    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if([_hadAnswerArray[page-1] intValue]!=0){
        if ([model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]) {
            answerCell.imageLabel.hidden=NO;
            answerCell.imageLabel.image=[UIImage imageNamed:@"19.png"];
        }
       else if (![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+[_hadAnswerArray[page-1] intValue]-1]]&& indexPath.row==[_hadAnswerArray[page-1] intValue]-1)
        {
            answerCell.imageLabel.hidden=NO;
            answerCell.imageLabel.image=[UIImage imageNamed:@"20.png"];
        }
        else
             answerCell.imageLabel.hidden=YES;
    }
    else{
            answerCell.imageLabel.hidden=YES;
    }
    return answerCell;
}
//答题时候的操作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int page=[self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if ([_hadAnswerArray[page-1] intValue]!=0) {
        return;
    }
    else{
        //0代表的是没有答过   1=A 2=B 3=C 4=D
        [_hadAnswerArray replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    }
    [self reloadData];
}

-(int)getQuestionNumber:(UITableView *)tableview andCurrentPage:(int)page{
    if (tableview==_leftTableView &&page==0) {
        return 1;
    }else if(tableview==_leftTableView && page>0){
        return  page;
    }else if(tableview==_mainTableView && page>0 && page<_dataArray.count-1){
        return page+1;
    }else if(tableview==_mainTableView && page==0){
        return 2;
    }else if(tableview==_mainTableView && page==_dataArray.count-1){
        return page;
    }else if(tableview==_rightTableView && page<_dataArray.count-1){
        return page+2;
    }else if(tableview==_rightTableView && page==_dataArray.count-1){
        return page+1;
    }
    return 0;
}

-(AnswerModel *)getFitModel:(UITableView *)tableView{
    AnswerModel *model;
    if (tableView==_leftTableView && _currentPage==0) {
        model=_dataArray[_currentPage];
    }
    else if(tableView==_leftTableView && _currentPage>0){
        model=_dataArray[_currentPage-1];
    }
    else if(tableView==_mainTableView && _currentPage==0){
        model=_dataArray[_currentPage+1];
    }
    else if(tableView==_mainTableView && _currentPage>0 &&_currentPage<_dataArray.count-1){
        model=_dataArray[_currentPage];
    }
    else if(tableView==_mainTableView && _currentPage==_dataArray.count-1){
        model=_dataArray[_currentPage-1];
    }
    else if(tableView==_rightTableView &&_currentPage==_dataArray.count-1){
        model=_dataArray[_currentPage];
    }else if(tableView==_rightTableView && _currentPage<_dataArray.count-1){
        model=_dataArray[_currentPage+1];
    }
    return model;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint currentOffSet=scrollView.contentOffset;
    int page =(int)currentOffSet.x/SIZE.width;
    if (page<=_dataArray.count-1 && page>0) {
        _scrollView.contentSize=CGSizeMake(currentOffSet.x+SIZE.width*2,0);
        _mainTableView.frame=CGRectMake(currentOffSet.x, 0,SIZE.width,SIZE.height);
        _leftTableView.frame=CGRectMake(currentOffSet.x-SIZE.width, 0,SIZE.width,SIZE.height);
        _rightTableView.frame=CGRectMake(currentOffSet.x+SIZE.width, 0,SIZE.width,SIZE.height);
    }
    _currentPage=page;
    [self reloadData];
}
-(void)reloadData{
    [_leftTableView reloadData];
    [_mainTableView reloadData];
    [_rightTableView reloadData];
}
@end
