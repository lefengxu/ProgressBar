//
//  CTProgressView.h
//  qey
//
//  Created by lefengxu on 2016/11/15.
//  Copyright © 2016年 lefengxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFProgressView : UIView


@property (nonatomic, strong) UIColor * backgroundBarColor;
@property (nonatomic, strong) UIColor * progressBarColor;
@property (nonatomic, assign) CGFloat insideWith;      // 内边距
@property (nonatomic, assign) CFTimeInterval duration;


- (instancetype)initWithFrame:(CGRect)frame
           backgroundBarColor:(UIColor *)backgroundBarColor
             progressBarColor:(UIColor *)progressBarColor
                        ratio:(CGFloat)ratio;

- (void)setRatio:(CGFloat)ratio animated:(BOOL)animated;



@end


