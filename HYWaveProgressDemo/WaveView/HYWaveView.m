//
//  HYWaveView.m
//  HYWaveProgressDemo
//
//  Created by leimo on 2017/6/3.
//  Copyright © 2017年 huyong. All rights reserved.
//

/**
 y = Asin（ωx+φ）+C
 A 表示振幅，也就是使用这个变量来调整波浪的高度
 ω表示周期，也就是使用这个变量来调整在屏幕内显示的波浪的数量
 φ表示波浪横向的偏移，也就是使用这个变量来调整波浪的流动
 C表示波浪纵向的位置，也就是使用这个变量来调整波浪在屏幕中竖直的位置
**/

#define BackGroundColor [UIColor colorWithRed:96/255.0f green:159/255.0f blue:150/255.0f alpha:1]

#define WaveColor1      [UIColor colorWithRed:136/255.0f green:199/255.0f blue:190/255.0f alpha:1]

#define WaveColor2      [UIColor colorWithRed:28/255.0 green:203/255.0 blue:174/255.0 alpha:1]

#import "HYWaveView.h"

@interface HYWaveView()

/** 水波layer */
@property (nonatomic,strong) CAShapeLayer *waveLayer;
/** 第二条水波 */
@property (nonatomic,strong) CAShapeLayer *waveLayer2;
/** 计时器对象 */
@property (nonatomic,strong) CADisplayLink *waveDisplayLink;

/** 水波的振幅 */
@property (nonatomic,assign) CGFloat waveA;
/** 水波的周期 */
@property (nonatomic,assign) CGFloat waveW;
/** 水波的位移 */
@property (nonatomic,assign) CGFloat offsetX;
/** 波浪的高度 */
@property (nonatomic,assign) CGFloat waveC;
/** 水纹的速度 */
@property (nonatomic,assign) CGFloat waveSpeed;
/** 水纹的宽度 */
@property (nonatomic,assign) CGFloat waveWidth;

@end

@implementation HYWaveView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData{

    _waveA = 10;
    _waveW = (M_PI ) / self.bounds.size.width;
    _waveC = 2;
    
}

- (void)initUI{
    
    self.backgroundColor = BackGroundColor;
    self.layer.cornerRadius = self.bounds.size.width / 2;
    self.layer.masksToBounds = YES;
    
    [self.layer addSublayer:self.waveLayer];
    [self.layer addSublayer:self.waveLayer2];
    
    self.waveDisplayLink.paused = YES;
    
//    self.clipsToBounds = YES;
}

#pragma mark - Getter
- (CAShapeLayer *)waveLayer{
    
    if (!_waveLayer) {
        
        _waveLayer = [CAShapeLayer layer];
        _waveLayer.fillColor = WaveColor1.CGColor;
    }
    return _waveLayer;
}

- (CAShapeLayer *)waveLayer2{
    
    if (!_waveLayer2) {
        
        _waveLayer2 = [CAShapeLayer layer];
        _waveLayer2.fillColor = WaveColor2.CGColor;
    }
    return _waveLayer2;
}

- (CADisplayLink *)waveDisplayLink{
    
    if (!_waveDisplayLink) {
        
        _waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateWave:)];
        [_waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _waveDisplayLink;
}

- (void)updateWave:(CADisplayLink *)displayLink{

    _offsetX += (M_PI / self.bounds.size.width) * 5;
    [self updateWaveLayer];
    [self updateWaveLayer2];
}

- (void)updateWaveLayer{
    
    CGFloat waveWidth = self.frame.size.width;
    
    //初始化路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat waveY = self.bounds.size.height - self.bounds.size.height * (_progress / 100.f);
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, waveY);
    
    CGFloat y = waveY;
    for (CGFloat i = 0.0f; i < waveWidth; i++) {
        
        y = _waveA * sin(_waveW * i + _offsetX) + waveY;
        CGPathAddLineToPoint(path, nil, i, y);
    }
    
    CGPathAddLineToPoint(path, nil, waveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    _waveLayer.path = path;
    CGPathRelease(path);
}

- (void)updateWaveLayer2{
    
    CGFloat waveWidth = self.frame.size.width;
    
    //初始化路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat waveY = self.bounds.size.height - self.bounds.size.height * (_progress / 100.f);
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, waveY);
    
    CGFloat y = waveY;
    for (CGFloat i = 0.0f; i < waveWidth; i++) {
        
        y = _waveA * cos(_waveW * i + _offsetX) + waveY;
        CGPathAddLineToPoint(path, nil, i, y);
    }
    
    CGPathAddLineToPoint(path, nil, waveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    _waveLayer2.path = path;
    CGPathRelease(path);
}

#pragma mark - Setter
- (void)setProgress:(NSInteger)progress{
    
    _progress = progress;
  
}

- (void)startAnimation{
    
    self.waveDisplayLink.paused = NO;

    [self.layer addSublayer:self.waveLayer];
    [self.layer addSublayer:self.waveLayer2];
}

- (void)stopAnimation{

    _waveDisplayLink.paused = YES;
    [_waveDisplayLink invalidate];
    _waveDisplayLink = nil;
    
    [_waveLayer removeFromSuperlayer];
    [_waveLayer2 removeFromSuperlayer];
}

@end
