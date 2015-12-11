//
//  ViewController.m
//  StudyDrive
//
//  Created by MAC on 15-10-30.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"
#import "FirstViewController.h"
@interface ViewController (){
 SelectView *_selectView;
}
 @property (retain, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation ViewController
- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 300:
        {
          [UIView animateWithDuration:0.3 animations:^{
              _selectView.alpha=1;
          }];
        }
            break;
        case 301:
        {
            FirstViewController *first=[[FirstViewController alloc]init ];
            first.title=@"科目一理论考试";
            UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
            item.title=@"";
            self.navigationItem.backBarButtonItem=item;
            [self.navigationController pushViewController:first animated:YES];
        }
            break;
        case 302:
        {
        }
        case 303:
        {
        }
            break;
        case 304:
        {
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectView=[[SelectView alloc]initWithFrame:self.view.frame andBtn:_selectBtn];
    _selectView.alpha=0;
    [self.view addSubview:_selectView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
