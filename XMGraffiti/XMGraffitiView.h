//
//  XMGraffitiView.h
//  XMGraffiti
//
//  Created by mifit on 2017/11/22.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGraffitiView : UIView
@property (nonatomic, copy) NSString *strokeColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) BOOL isEraser;
- (void)undo;
- (void)redo;
@end
