//
//  XMDrawModel.m
//  XMGraffiti
//
//  Created by mifit on 2017/11/23.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import "XMDrawModel.h"

@implementation XMDrawModel
- (id)copyWithZone:(nullable NSZone *)zone {
    XMDrawModel *newModel = [[XMDrawModel alloc]init];
    newModel.strokeColor = [_strokeColor copy];
    newModel.pointList = [_pointList copy];
    newModel.lineWidth = _lineWidth;
    newModel.shapeType = _shapeType;
    newModel.isEraser = _isEraser;
    newModel.paintSize = _paintSize;
    return newModel;
}
@end
