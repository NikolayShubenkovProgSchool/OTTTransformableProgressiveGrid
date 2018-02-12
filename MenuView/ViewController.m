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
@property (weak, nonatomic) IBOutlet UILabel *subviewsCountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuView.minimumElementsInRow = 3;
}

- (void)setViewsCount:(NSInteger)viewsCount {
    if (_viewsCount == viewsCount){
        return;
    }
    
    _viewsCount = viewsCount;
    
    [self reloadViews];
    [self.view layoutIfNeeded];
}

- (void)reloadViews {
    NSMutableArray *views = [NSMutableArray new];
    
    for (int i = 0; i < self.viewsCount; i++){
        
        UILabel *view = [UILabel new];
        view.text = @"\nJust\na test\n\n";
        view.numberOfLines = 0;
        view.textAlignment = NSTextAlignmentCenter;
        view.backgroundColor = [UIColor randomColor];
        [views addObject:view];
        
    }
    
    [self.menuView resetMenuViews:views];

}

- (IBAction)valueChanged:(id)sender {
    
    self.viewsCount = self.progress.value;
    self.subviewsCountLabel.text = [NSString stringWithFormat:@"Subviews count %@",@(self.viewsCount)];
}

- (IBAction)progressChanged:(UISlider *)sender {
    self.progressLabel.text = [NSString stringWithFormat:@"Progress %@",@(sender.value)];
    [UIView animateWithDuration:2
                          delay:0
         usingSpringWithDamping:0.35
          initialSpringVelocity:2
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.menuView.progress = sender.value;
                         [self.view layoutIfNeeded];
                     } completion:nil];
}

@end
