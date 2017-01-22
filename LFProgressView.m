//
//  CTProgressView.m
//  qey
//
//  Created by lefengxu on 2016/11/15.
//  Copyright © 2016年 lefengxu. All rights reserved.
//

#import "LFProgressView.h"

@interface LFProgressView ()

@property (nonatomic, strong) CAShapeLayer * progressBarLayer;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) BOOL animated;

@end

@implementation LFProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame backgroundBarColor:(UIColor *)backgroundBarColor progressBarColor:(UIColor *)progressBarColor ratio:(CGFloat)ratio {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundBarColor = backgroundBarColor;
        self.progressBarColor = progressBarColor;

        [self.layer addSublayer:self.progressBarLayer];

        [self setNeedsDisplay];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundBarColor = [UIColor grayColor];
        self.progressBarColor = [UIColor greenColor];
        self.insideWith = 2;
        self.duration = 2;

        [self.layer addSublayer:self.progressBarLayer];

        [self setNeedsDisplay];
    }

    return self;
}

- (void)drawRect:(CGRect)rect {

    UIBezierPath * backGourndBar = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:CGRectGetHeight(rect)*0.5];
    [self.backgroundBarColor set];
    [backGourndBar fill];
}

- (void)setRatio:(CGFloat)ratio animated:(BOOL)animated {
    self.ratio = ratio;
    self.animated = animated;

    CGFloat x = CGRectGetWidth(self.frame) * self.ratio;
    CGFloat height = CGRectGetHeight(self.frame) - self.insideWith*2;
    CGFloat centerY = CGRectGetHeight(self.frame) * 0.5;
    UIBezierPath * path = [UIBezierPath bezierPath];

    [path moveToPoint:(CGPointMake(0, centerY))];
    [path addLineToPoint:(CGPointMake(x, centerY))];

    self.progressBarLayer.path = path.CGPath;
    self.progressBarLayer.lineWidth = height;
    self.progressBarLayer.strokeColor = self.progressBarColor.CGColor;
    self.progressBarLayer.lineCap = kCALineCapRound;  // 圆角需要在这里设置才行

    if (animated) {
        [self setAnimation];
    }


}

- (void)setAnimation {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = self.duration;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:self.ratio];

    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.progressBarLayer addAnimation:animation forKey:@"strokeEndAnimation"];
}

- (void)layoutSubviews {
//     在此处时才确定frame的大小
    [self setRatio:self.ratio animated:self.animated];
}

#pragma mark - 懒加载
- (CAShapeLayer *)progressBarLayer {
    if (!_progressBarLayer) {
        _progressBarLayer = [[CAShapeLayer alloc]init];
    }

    return _progressBarLayer;
}

#pragma mark - setter & getter
- (void)setBackgroundBarColor:(UIColor *)backgroundBarColor {
    _backgroundBarColor = backgroundBarColor;

    [self setNeedsDisplay];
}

- (void)setInsideWith:(CGFloat)insideWith {
    _insideWith = insideWith;

    [self setRatio:self.ratio animated:self.animated];
}

@end
