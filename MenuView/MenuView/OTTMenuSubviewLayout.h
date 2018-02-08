//
//  OTTMenuSubviewLayout.h
//  MenuView
//
//  Created by n.shubenkov on 07/02/2018.
//  Copyright © 2018 n.shubenkov. All rights reserved.
//

@import UIKit;

@interface OTTMenuSubviewLayout : NSObject

@property (nonatomic) CGRect startFrame;
@property (nonatomic) CGRect endFrame;

- (CGRect)frameForProgress:(CGFloat)progress;

@end
