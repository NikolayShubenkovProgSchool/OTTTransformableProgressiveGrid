//
//  OTTMenuView.m
//  MenuView
//
//  Created by n.shubenkov on 07/02/2018.
//  Copyright © 2018 n.shubenkov. All rights reserved.
//

#import "OTTMenuView.h"
#import "OTTMenuSubviewLayout.h"

@interface OTTMenuView ()

@property (nonatomic, readwrite) NSArray <UIView *> *menuViews;
@property (nonatomic) NSArray <OTTMenuSubviewLayout *> *layouts;
@property (nonatomic) CGFloat savedWidth;

@end

@implementation OTTMenuView

#pragma mark - Accessors

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsLayout];
}

- (void)setIbProgress:(double)ibProgress {
    self.progress = ibProgress;
}

- (double)ibProgress {
    return self.progress;
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    [self resetMenuViews:self.subviews];
}

#pragma mark - Public

- (void)resetMenuViews:(NSArray<UIView *> *)views{
    [self.menuViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _menuViews = views;
    [self.menuViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
    [self recalculateFrames];
    [self setNeedsLayout];
}

#pragma mark - Override

- (void)layoutSubviews {
    if (self.savedWidth != CGRectGetWidth(self.bounds)){
        self.savedWidth = CGRectGetWidth(self.bounds);
        [self recalculateFrames];
    }
    [super layoutSubviews];
    [self.layouts enumerateObjectsUsingBlock:^(OTTMenuSubviewLayout * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.menuViews objectAtIndex:idx].frame = [obj frameForProgress:self.progress];
    }];
}

- (CGSize)intrinsicContentSize {
    if (self.menuViews.count == 0){
        return CGSizeZero;
    }
    
    __block CGRect rect = [self.layouts firstObject].startFrame;
    
    [self.layouts enumerateObjectsUsingBlock:^(OTTMenuSubviewLayout * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        rect = CGRectUnion(obj.startFrame, rect);
    }];
    
    rect.size.height = rect.size.height + rect.size.height * self.progress;
    return rect.size;
}

#pragma mark - Private

- (void)recalculateFrames {
    
    self.layouts = nil;
    if (self.menuViews.count == 0){
        return ;
    }
    
    NSArray <NSValue *>* oneLineValues = [self valuesForOneLine:self.menuViews.count
                                                        yOffset:0
                                                        xOffset:0];
    NSArray <NSValue *>* twoLineValues = [self valuesForTwoLine:self.menuViews.count];
    
    NSMutableArray <OTTMenuSubviewLayout *> *result = [NSMutableArray new];
    for (NSInteger i = 0; i < self.menuViews.count; i++) {
        OTTMenuSubviewLayout *layout = [OTTMenuSubviewLayout new];
        layout.startFrame = [oneLineValues[i] CGRectValue];
        layout.endFrame = [twoLineValues[i] CGRectValue];
        [result addObject:layout];
    }
    
    self.layouts = [result copy];
    
    [self setNeedsLayout];
}

//будем опираться на высоту вьюх
- (NSArray <NSValue *> *)valuesForOneLine:(NSInteger) itemsCount yOffset:(CGFloat)offset xOffset:(CGFloat)xOffset {
    
    CGFloat widthPerView = self.savedWidth / itemsCount;
    CGFloat height = [[self.menuViews firstObject] systemLayoutSizeFittingSize:CGSizeMake(widthPerView, CGFLOAT_MAX)].height;
    
    NSMutableArray *values = [NSMutableArray new];
    
    for (NSInteger index = 0; index < itemsCount; index ++){
        CGRect frame = CGRectZero;
        frame.size = CGSizeMake(widthPerView, height);
        frame.origin.x = index * widthPerView + xOffset;
        frame.origin.y = offset;
        [values addObject:[NSValue valueWithCGRect:frame]];
    }
    
    return [values copy];
}

- (NSArray <NSValue *> *)valuesForTwoLine: (NSInteger)itemsCount {
    
    //если это 5, то 5 / 2 даст нам 3;
    NSInteger firstLineCount = ceil((float)itemsCount / 2) ;
    
    NSMutableArray *firstLine = [[self valuesForOneLine:firstLineCount
                                                yOffset:0
                                                xOffset:0] mutableCopy];
    
    CGRect firstFrame = [firstLine.firstObject CGRectValue];
    
    CGFloat yOffset = CGRectGetHeight(firstFrame);
    CGFloat xOffset = itemsCount % 2 == 1 ? (CGRectGetWidth(firstFrame)) / 2 : 0;
    
    NSMutableArray *secondLine = [[self valuesForOneLine:firstLineCount
                                                 yOffset:yOffset
                                                 xOffset:xOffset] mutableCopy];
    
    //теперь магия. мы должны в первой строке оставить 1,3,5, 7 и т.д. элементы
    //а во вторую запихать 2, 4, 6, 8 и т.д. элементы
    
    NSParameterAssert(firstLine.count == secondLine.count + 1 ||
                      firstLine.count == secondLine.count);
    
    NSMutableArray *values = [NSMutableArray new];
    
    for (NSInteger i = 0; i < itemsCount; i++){
        
        if (i % 2 == 0){
            
            [values addObject:firstLine.firstObject];
            [firstLine removeObjectAtIndex:0];
        }
        else {
            [values addObject:secondLine.firstObject];
            [secondLine removeObjectAtIndex:0];
        }
    }
    
    return values;
}

@end
