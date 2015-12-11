//
//  AnswerTableViewCell.m
//  StudyDrive
//
//  Created by MAC on 15-11-12.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "AnswerTableViewCell.h"

@implementation AnswerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)dealloc {
    [_answerLabel release];
    [_numberLabel release];
    [super dealloc];
}
@end
