//
//  XMPointModel.h
//  XMGraffiti
//
//  Created by mifit on 2017/11/23.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMPointModel : NSObject <NSCopying>
@property (nonatomic ,assign) CGFloat x;
@property (nonatomic ,assign) CGFloat y;

- (XMPointModel *)initWithPoint:(CGPoint)pt;
- (CGPoint)point;
@end
