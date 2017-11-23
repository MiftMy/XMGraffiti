//
//  XMGraffitiView.m
//  XMGraffiti
//
//  Created by mifit on 2017/11/22.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import "XMGraffitiView.h"
#import "XMGraffitiModel.h"

@interface XMGraffitiView()
{
    CGPoint lastPoint;
    CGFloat distance;
    CGFloat spacing;
}
@property (nonatomic, strong) NSMutableArray *list;
@end

@implementation XMGraffitiView

- (XMGraffitiView *)init {
    if (self = [super init]) {
        distance = 0;
        spacing = 50;
    }
    return self;
}
- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}
#pragma mark -
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//     Drawing code
    for (XMGraffitiModel *model in self.list) {
        UIImage *img = [UIImage imageNamed:model.imgName];
        
        [img drawInRect:model.rect];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    lastPoint = pt;
    XMGraffitiModel *model = [XMGraffitiModel new];
    model.pt = pt;
    model.rect = [self randomRectAtPoint:model.pt];
    model.imgName = [self randomImgName];
    [self.list addObject:model];
    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    CGFloat dis = [self distanceBW:lastPoint at:pt];
    distance += dis;
    if (distance >= spacing) {
        lastPoint = pt;
        distance = 0;
        XMGraffitiModel *model = [XMGraffitiModel new];
        model.pt = pt;
        model.rect = [self randomRectAtPoint:model.pt];
        model.imgName = [self randomImgName];
        [self.list addObject:model];
        [self setNeedsDisplay];
    }
}


#pragma mark - private
- (NSString *)randomImgName {
    int indx = arc4random() % 3 + 1;
    NSString *name = [NSString stringWithFormat:@"org%d", indx];
    return name;
}

- (CGFloat)distanceBW:(CGPoint)pt1 at:(CGPoint)pt2 {
    return sqrt((pt1.x-pt2.x)*(pt1.x-pt2.x)+(pt1.y-pt2.y)*(pt1.y-pt2.y));
}

- (CGRect)randomRectAtPoint:(CGPoint)pt {
    CGFloat width = arc4random() % 15 + 15;
    CGFloat halfW = width / 2;
    return CGRectMake(pt.x-halfW, pt.y-halfW, width, width);
}
@end
