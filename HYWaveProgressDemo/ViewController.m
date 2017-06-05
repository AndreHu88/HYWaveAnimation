//
//  ViewController.m
//  HYWaveProgressDemo
//
//  Created by leimo on 2017/6/3.
//  Copyright © 2017年 huyong. All rights reserved.
//

#import "ViewController.h"
#import "HYWaveView.h"

@interface ViewController ()
{
    HYWaveView  *waveView;
    UILabel     *label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    waveView = [[HYWaveView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    [self.view addSubview:waveView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(100, 460, 200, 40)];
    slider.maximumValue = 1;
    slider.value = 0;
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    
    label = [[UILabel alloc] initWithFrame:waveView.frame];
    label.text = [NSString stringWithFormat:@"%.f%%",slider.value * 100];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:32];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)sliderAction:(UISlider *)slider{

    waveView.progress = slider.value * 100;
    label.text = [NSString stringWithFormat:@"%.f%%",slider.value * 100];
    if (slider.value == 0 || slider.value == 1) {
        
        [waveView stopAnimation];
    }
    else{
        
        [waveView startAnimation];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
