//
//  JSPhoto.m
//  JS_PhotoRvier
//
//  Created by  江苏 on 16/3/14.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSPhoto.h"

@implementation JSPhoto
//-(instancetype)initWithFrame:(CGRect)frame{
//    self=[super initWithFrame:frame];
//    if (self) {
//        self.photo=[[UIImageView alloc]initWithFrame:self.bounds];
//        self.draw=[[JSDraw alloc]initWithFrame:self.bounds];
//        [self addSubview:self.photo];
//        [self addSubview:self.draw];
//        self.userInteractionEnabled=YES;
//        self.photo.userInteractionEnabled=YES;
//        self.draw.userInteractionEnabled=YES;
//        //设置照片河动画
//        [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
//        //设置边宽
//        self.layer.borderWidth=2;
//        self.layer.borderColor=[UIColor whiteColor].CGColor;
//        //设置点击手势
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
//        [self addGestureRecognizer:tap];
//    }
//    return self;
//}
//-(void)tapAction{
//        self.oldAlpha=self.alpha;
//        self.oldFrame=self.frame;
//        self.oldSpeed=self.speed;
//        self.frame=CGRectMake(60, (self.superview.bounds.size.height-300)/2,200 , 300);
//        self.alpha=1;
//        self.speed=0;
//        self.photo.frame=self.bounds;
//        self.draw.frame=self.bounds;
//}
//
//-(void)setImageViewAlpha:(CGFloat)alphax{
//    self.alpha=alphax;
//    self.photo.alpha=alphax;
//    self.speed=alphax*2+1;
//    [self setTransform:CGAffineTransformScale(self.transform, self.alpha, self.alpha)];
//}
//-(void)moveAction{
//    self.center=CGPointMake(self.center.x+self.speed, self.center.y);
//    if (self.center.x>320+self.bounds.size.width/2) {
//        self.center=CGPointMake(-self.bounds.size.width/2,arc4random()%(int)(568-self.bounds.size.height)+self.bounds.size.height/2);
//    }
//}
//-(void)updateUI:(UIImage*)image{
//    self.photo.image=image;
//}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.photo = [[UIImageView alloc]initWithFrame:self.bounds];
//        self.draw = [[JSDraw alloc]initWithFrame:self.bounds];
//        [self addSubview:self.draw];
        [self addSubview:self.photo];
        self.userInteractionEnabled=YES;
        [NSTimer scheduledTimerWithTimeInterval:1.0/30 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
        
        //加边
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeSubviewsAction)];
        [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:swipe];
    }
    return self;
}
-(void)changeSubviewsAction{
    if (self.status==JSPhotoStatusBig) {
        self.status = JSPhotoStatusDraw;
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    }else if (self.status == JSPhotoStatusDraw){
        self.status = JSPhotoStatusBig;
        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    }
    
    
}
-(void)tapAction{//图片单击手势
    for (UIView *v in self.superview.subviews) {
        if ([v isMemberOfClass:[JSPhoto class]]) {
            JSPhoto *p = (JSPhoto*)v;
            //如果遍历的图片是当前放大的图片 不应该有限制
            if ([p isEqual:self]) {
                continue;
            }
            if (p.status == JSPhotoStatusBig||p.status==JSPhotoStatusDraw) {
                return;
            }
            
        }
        
    }
    
    
    [UIView animateWithDuration:.5 animations:^{
        if (self.status == JSPhotoStatusNormal) {
            self.oldAlpha = self.alpha;
            self.oldFrame = self.frame;
            self.oldSpeed = self.speed;
            self.frame = CGRectMake(60, (self.superview.bounds.size.height-300)/2, 200, 300);
            self.photo.frame = self.bounds;
//            self.draw.frame = self.bounds;
            self.speed = 0;
            self.alpha = 1;
            self.status = JSPhotoStatusBig;//代表当前状态是大图状态
            //把控件显示到父视图的最前端
            [self.superview bringSubviewToFront:self];
        }else if (self.status == JSPhotoStatusBig){
            self.alpha = self.oldAlpha;
            self.frame = self.oldFrame;
            self.photo.frame = self.bounds;
//            self.draw.frame = self.bounds;
            self.speed = self.oldSpeed;
            self.status = JSPhotoStatusNormal;//代表当前状态是normal
        }
        
    }];
    
    
    
}

-(void)setImageViewAlpha:(CGFloat)alpha{
    self.alpha = alpha;
    self.speed = 4*self.alpha +1;
    [self setTransform:CGAffineTransformScale(self.transform, self.alpha , self.alpha)];
}

-(void)moveAction{
    
    self.center = CGPointMake(self.center.x+self.speed, self.center.y);
    if (self.center.x>320+self.bounds.size.width/2) {
        
        self.center = CGPointMake(-self.bounds.size.width/2, arc4random()%(int)(568-self.bounds.size.height) + self.bounds.size.height/2);
    }
}

-(void)updateUI:(UIImage *)image{
    self.photo.image = image;
}

@end
