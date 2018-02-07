//
//  OTTMenuView.h
//  MenuView
//
//  Created by n.shubenkov on 07/02/2018.
//  Copyright © 2018 n.shubenkov. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface OTTMenuView : UIView

@property (nonatomic, readonly) NSArray <UIView *> *menuViews;
//не сработало
@property (nonatomic) IBOutletCollection(UIView) NSArray *interfaceBuilderViews;
@property (nonatomic) CGFloat progress;//0 - oneline. 1 - two line
@property (nonatomic) IBInspectable double ibProgress;
// addd views which nows their heigth
//it works like ask first view for it heigth and then apply it size to other views
- (void)resetMenuViews:(NSArray <UIView*>*)views;

@end
