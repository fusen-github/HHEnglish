//
//  FSInsertView.h
//  HHEnglish
//
//  Created by 付森 on 2018/12/28.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSInsertView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong, readonly) NSLayoutConstraint *leftLayoutConstraint;

@property (nonatomic, strong, readonly) NSLayoutConstraint *rightLayoutConstraint;

@property (nonatomic, strong, readonly) NSLayoutConstraint *bottomLayoutConstraint;

@property (nonatomic, strong, readonly) NSLayoutConstraint *minHeightLayoutConstraint;

@property (nonatomic, strong, readonly) NSLayoutConstraint *maxHeightLayoutConstraint;

@end
