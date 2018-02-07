//
//  OTTMenuView.h
//  MenuView
//
//  Created by n.shubenkov on 07/02/2018.
//  Copyright © 2018 n.shubenkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTTMenuView : UIView

@property (nonatomic, readonly) NSArray <UIView *> *menuViews;
@property (nonatomic) CGFloat progress;//0 - oneline. 1 - two line

// addd views which nows their heigth
//it works like ask first view for it heigth and then apply it size to other views
- (void)resetMenuViews:(NSArray <UIView*>*)views;

@end
