//
//  SelectModelView.h
//  StudyDrive
//
//  Created by binbinsun on 15/12/12.
//  Copyright © 2015年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    testModel,
    lookingModel
}SelectMode;
typedef void (^SelectTouch)(SelectMode model);//代码块
@interface SelectModelView : UIView
@property(nonatomic,assign)SelectMode model;
-(SelectModelView *)initwithFrame:(CGRect)frame addTouch:(SelectTouch)touch;
@end
