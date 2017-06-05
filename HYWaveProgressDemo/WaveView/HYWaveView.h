//
//  HYWaveView.h
//  HYWaveProgressDemo
//
//  Created by leimo on 2017/6/3.
//  Copyright © 2017年 huyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYWaveView : UIView

/** 进度 */
@property (nonatomic,assign) NSInteger progress;

- (void)startAnimation;

- (void)stopAnimation;

@end
