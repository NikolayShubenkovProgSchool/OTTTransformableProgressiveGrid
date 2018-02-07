//
//  ViewController.m
//  MenuView
//
//  Created by n.shubenkov on 07/02/2018.
//  Copyright © 2018 n.shubenkov. All rights reserved.
//

#import "ViewController.h"
#import "OTTMenuView.h"

@interface UIColor (RandomColor)

+ (UIColor *)randomColor;

@end

@implementation UIColor (RandomColor)

+ (UIColor *)randomColor {
    return [UIColor colorWithHue:arc4random_uniform(255) / 255.0
                      saturation:1
                      brightness:1
                           alpha:1];
}

@end

@interface ViewController ()

@property (weak, nonatomic) IBOutlet OTTMenuView *menuView;
@property (nonatomic) NSInteger viewsCount;
@property (weak, nonatomic) IBOutlet UISlider *progress;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation ViewController

- (void)setViewsCount:(NSInteger)viewsCount {
    if (_viewsCount == viewsCount){
        return;
    }
    
    _viewsCount = viewsCount;
    
    NSMutableArray *views = [NSMutableArray new];
    
    for (int i = 0; i < viewsCount; i++){
        
        UILabel *view = [UILabel new];
        view.text = @"тестовый текст";
        view.textAlignment = NSTextAlignmentCenter;
        view.backgroundColor = [UIColor randomColor];
        [views addObject:view];
        
    }
    
    [self.menuView resetMenuViews:views];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)valueChanged:(id)sender {
    self.viewsCount = self.progress.value;
}

- (IBAction)progressChanged:(UISlider *)sender {
    self.menuView.progress = sender.value;
}

@end
