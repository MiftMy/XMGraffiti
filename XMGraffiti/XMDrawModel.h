//
//  XMDrawModel.h
//  XMGraffiti
//
//  Created by mifit on 2017/11/23.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XMDrawType) {
    XMDrawTypeCurve = 0,       //曲线
    XMDrawTypeLine,            //直线，pointList的第一个和最有一个点
    XMDrawTypeEllipse,         //椭圆，前两个点
    XMDrawTypeCircle,          //原型，前两个点
    XMDrawTypeSquare,          //矩形，前两个点
    XMDrawTypeGraffiti,        //涂鸦
    XMDrawTypeEraser           //擦除
};

@interface XMDrawModel : NSObject <NSCopying>
@property (nonatomic, copy) NSString *strokeColor;//线颜色，hex
@property (nonatomic, strong) NSArray *pointList;//绘画信息。XMPointModel、XMGraffitiModel
@property (nonatomic, assign) CGFloat lineWidth;//线宽
@property (nonatomic, assign) XMDrawType shapeType;//绘图类型
@property (nonatomic, assign) BOOL isEraser;     //是否擦除
@property (nonatomic, assign) CGSize paintSize;//画布大小
@end
