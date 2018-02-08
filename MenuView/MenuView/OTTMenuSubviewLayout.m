//
//  OTTMenuSubviewLayout.m
//  MenuView
//
//  Created by n.shubenkov on 07/02/2018.
//  Copyright © 2018 n.shubenkov. All rights reserved.
//

#import "OTTMenuSubviewLayout.h"

@implementation OTTMenuSubviewLayout

- (CGRect)frameForProgress:(CGFloat)progress {
    
    CGPoint startOrigin = CGPointMake(CGRectGetMinX(self.startFrame), CGRectGetMinY(self.startFrame));
    CGSize startSize = self.startFrame.size;
    
    CGPoint endOrigin = CGPointMake(CGRectGetMinX(self.endFrame), CGRectGetMinY(self.endFrame));
    CGSize endSize = self.endFrame.size;
    
    CGFloat deltax = (endOrigin.x - startOrigin.x) * progress;
    CGFloat deltay = (endOrigin.y - startOrigin.y) * progress;
    CGPoint progressOrigin = CGPointMake(startOrigin.x + deltax,
                                         startOrigin.y + deltay);
    
    CGFloat deltaWidth = (endSize.width - startSize.width) * progress;
    CGFloat deltaHeight = (endSize.height - startSize.height) * progress;
    
    CGSize progressSize = CGSizeMake(deltaWidth + startSize.width,
                                     deltaHeight + startSize.height);
    
    CGRect result = CGRectZero;
    result.origin = progressOrigin;
    result.size = progressSize;
    
    return result;
}

@end
