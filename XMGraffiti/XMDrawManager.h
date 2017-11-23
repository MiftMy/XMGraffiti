//
//  XMDrawManager.h
//  AreoxPlay
//
//  Created by mifit on 2017/9/8.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMDrawModel;

@interface XMDrawManager : NSObject
//model的paintSize必须要和图片的等比例，不然跟你想象的不一样
+ (UIImage *)imageFromModel:(XMDrawModel *)model orgImage:(UIImage *)imgOrg;

+ (UIBezierPath *)pathFromModel:(XMDrawModel *)model;
@end
