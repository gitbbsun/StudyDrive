//
//  SheetView.h
//  StudyDrive
//
//  Created by binbinsun on 15/12/12.
//  Copyright © 2015年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SheetViewDelegate
-(void)SheetViewClick:(int)index;

@end

@interface SheetView : UIView{
    @public
    UIView *_backView;
    
}
@property(nonatomic,retain)id<SheetViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView *)superView andQuestionsCount:(int)count;
@end
