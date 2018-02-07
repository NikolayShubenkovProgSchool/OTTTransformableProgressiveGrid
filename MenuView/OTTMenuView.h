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
@property (nonatomic) CGFloat progress;

- (void)resetMenuViews:(NSArray <UIView*>*)views;

@end
