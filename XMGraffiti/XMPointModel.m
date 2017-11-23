//
//  XMPointModel.m
//  XMGraffiti
//
//  Created by mifit on 2017/11/23.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import "XMPointModel.h"

@implementation XMPointModel
- (XMPointModel *)initWithPoint:(CGPoint)pt {
    if (self = [super init]) {
        _x = pt.x;
        _y = pt.y;
    }
    return self;
}
- (id)copyWithZone:(nullable NSZone *)zone {
    XMPointModel *newModel = [XMPointModel alloc];
    newModel.x = _x;
    newModel.y = _y;
    return newModel;
}
- (CGPoint)point {
    return CGPointMake(self.x, self.y);
}
@end
