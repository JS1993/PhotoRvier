//
//  JSPhoto.h
//  JS_PhotoRvier
//
//  Created by  江苏 on 16/3/14.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSDraw.h"
typedef NS_ENUM(NSInteger, JSPhotoStatus) {
    JSPhotoStatusNormal,
    JSPhotoStatusBig,
    JSPhotoStatusDraw,
    JSPhotoStatusTogether,
};
@interface JSPhoto : UIView
@property(nonatomic,strong)UIImageView* photo;
//@property(nonatomic,strong)JSDraw* draw;
@property(nonatomic)float speed;
@property(nonatomic)float alpha;
@property(nonatomic)float oldSpeed;
@property(nonatomic)float oldAlpha;
@property(nonatomic)CGRect oldFrame;
@property(nonatomic)JSPhotoStatus status;
-(void)updateUI:(UIImage*)image;
-(void)setImageViewAlpha:(CGFloat)alpha;
@end
