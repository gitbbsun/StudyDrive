//
//  SheetView.h
//  StudyDrive
//
//  Created by binbinsun on 15/12/12.
//  Copyright © 2015年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetView : UIView{
    @public
    UIView *_backView;
    
}
-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView andQuestionsCount:(int)count;
@end
