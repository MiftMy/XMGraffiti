//
//  XMGraffitiView.m
//  XMGraffiti
//
//  Created by mifit on 2017/11/22.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import "XMGraffitiView.h"
#import "XMDrawModel.h"
#import "XMGraffitiModel.h"
#import "XMDrawManager.h"
#import "XMPointModel.h"

@interface XMGraffitiView()
{
    CGPoint lastPoint;
    CGFloat distance;
    CGFloat spacing;
    NSInteger activeStep;
}
@property (nonatomic, strong) NSMutableArray *stepList;
@property (nonatomic, strong) NSMutableArray *ptList;
@end

@implementation XMGraffitiView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupData];
}
- (XMGraffitiView *)init {
    if (self = [super init]) {
        [self setupData];
    }
    return self;
}
- (NSMutableArray *)stepList {
    if (!_stepList) {
        _stepList = [NSMutableArray array];
    }
    return _stepList;
}
- (NSMutableArray *)ptList {
    if (!_ptList) {
        _ptList = [NSMutableArray array];
    }
    return _ptList;
}

- (void)undo {
    activeStep--;
    if (activeStep < 0) {
        activeStep = 0;
    }
    [self setNeedsDisplay];
}
- (void)redo {
    if (activeStep < self.stepList.count) {
        activeStep++;
        [self setNeedsDisplay];
    }
}
#pragma mark -
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//     Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(ctx);
    for (NSInteger indx = 0; indx < activeStep; indx++) {
        XMDrawModel *model = self.stepList[indx];
        if (model.isEraser) {
            UIBezierPath *path = [XMDrawManager pathFromModel:model];
            [[UIColor clearColor]set];
            [path strokeWithBlendMode:kCGBlendModeClear alpha:1];
            [path stroke];
        } else {
            for (XMGraffitiModel *pM in model.pointList) {
                UIImage *img = [UIImage imageNamed:pM.imgName];
                [img drawInRect:pM.rect];
            }
        }
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    lastPoint = pt;
    XMDrawModel *model = [XMDrawModel new];
    model.pointList = self.ptList;
    model.strokeColor = self.strokeColor;
    model.lineWidth = self.lineWidth;
    model.isEraser = self.isEraser;
    if (self.stepList.count > activeStep) {
        [self.stepList removeObjectsInRange:NSMakeRange(activeStep, self.stepList.count-activeStep)];
    }
    [self.stepList addObject:model];
    activeStep++;
    if (self.isEraser) {
        model.shapeType = XMDrawTypeCurve;
        XMPointModel *ptModel = [[XMPointModel alloc]initWithPoint:pt];
        [self.ptList addObject:ptModel];
    } else {
        model.shapeType = XMDrawTypeGraffiti;
        XMGraffitiModel *modelPath = [XMGraffitiModel new];
        modelPath.pt = pt;
        modelPath.rect = [self randomRectAtPoint:pt];
        modelPath.imgName = [self randomImgName];
        [self.ptList addObject:modelPath];
    }
    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (self.isEraser) {
        XMPointModel *ptModel = [[XMPointModel alloc]initWithPoint:pt];
        [self.ptList addObject:ptModel];
    } else {
        CGFloat dis = [self distanceBW:lastPoint at:pt];
        distance += dis;
        if (distance >= spacing) {
            lastPoint = pt;
            distance = 0;
            XMGraffitiModel *model = [XMGraffitiModel new];
            model.pt = pt;
            model.rect = [self randomRectAtPoint:model.pt];
            model.imgName = [self randomImgName];
            [self.ptList addObject:model];
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (self.isEraser) {
        XMPointModel *ptModel = [[XMPointModel alloc]initWithPoint:pt];
        [self.ptList addObject:ptModel];
    } else {
        CGFloat dis = [self distanceBW:lastPoint at:pt];
        distance += dis;
        if (distance >= spacing) {
            lastPoint = pt;
            distance = 0;
            XMGraffitiModel *model = [XMGraffitiModel new];
            model.pt = pt;
            model.rect = [self randomRectAtPoint:model.pt];
            model.imgName = [self randomImgName];
            [self.ptList addObject:model];
        }
    }
    [self setNeedsDisplay];
    _ptList = nil;
}
#pragma mark - private
- (void)setupData {
    distance = 0;
    spacing = 50;
    self.backgroundColor = [UIColor clearColor];
    _strokeColor = @"0000ff";
    _lineWidth = 4;
}
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
