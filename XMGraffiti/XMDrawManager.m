//
//  XMDrawManager.m
//  AreoxPlay
//
//  Created by mifit on 2017/9/8.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import "XMDrawManager.h"
#import "XMDrawModel.h"
#import "XMPointModel.h"
#import "UIColor_XMColor.h"


@implementation XMDrawManager

+ (UIImage *)imageFromModel:(XMDrawModel *)model orgImage:(UIImage *)imgOrg {
    CGSize size = model.paintSize;
    CGSize imgSize = imgOrg.size;
    XMDrawModel *pathModel = model;
    if (!CGSizeEqualToSize(size, imgSize)) {
        CGFloat scale = imgSize.width / size.width;
        size = imgSize;
        pathModel = [self newModel:model withScale:scale];
    }
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    [imgOrg drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [[UIColor colorWithHexString:model.strokeColor] set];
    UIBezierPath *path = [self pathFromModel:pathModel];
    if (model.isEraser) {
        [path strokeWithBlendMode:kCGBlendModeClear alpha:1.0];
    }
    [path stroke];
    UIImage *desImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  desImg;
}

+ (XMDrawModel *)newModel:(XMDrawModel *)model withScale:(CGFloat)scale {
    XMDrawModel *newModel = [model copy];
    NSMutableArray *newList = [NSMutableArray arrayWithCapacity:model.pointList.count];
    for (XMPointModel *ptPtM in model.pointList) {
        XMPointModel *newPtM = [ptPtM copy];
        newPtM.x *= scale;
        newPtM.y *= scale;
        [newList addObject:newPtM];
    }
    newModel.pointList = newList;
    newModel.lineWidth = model.lineWidth * scale;
    return newModel;
}

+ (UIBezierPath *)pathFromModel:(XMDrawModel *)model {
    UIBezierPath *path;
    switch (model.shapeType) {
        case XMDrawTypeCurve:
        case XMDrawTypeLine:
            path = [UIBezierPath bezierPath];
            for (NSInteger indx = 0; indx < model.pointList.count; indx++) {
                XMPointModel *ptModel = model.pointList[indx];
                CGPoint point = [ptModel point];
                if (indx == 0) {
                    [path moveToPoint:point];
                } else {
                    [path addLineToPoint:point];
                }
            }
            break;
        case XMDrawTypeCircle:
        case XMDrawTypeEllipse:
            path = [UIBezierPath bezierPathWithRect:[self rectFrom2Point:model.pointList]];
            break;
        case XMDrawTypeSquare:
            path = [UIBezierPath bezierPathWithOvalInRect:[self rectFrom2Point:model.pointList]];
            break;
        default:
            break;
    }
    path.lineWidth = model.lineWidth;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    return path;
}

+ (CGRect)rectFrom2Point:(NSArray *)points {
    XMPointModel *m1 = points[0];
    XMPointModel *m2 = points[2];
    CGPoint begin = [m1 point];
    CGPoint end = [m2 point];
    return CGRectMake(begin.x, begin.y, begin.x-end.x, begin.y-end.y);
}

@end
