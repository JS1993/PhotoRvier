//
//  ViewController.m
//  JS_PhotoRvier
//
//  Created by  江苏 on 16/3/14.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"
#import "JSPhoto.h"
@interface ViewController ()
@property(nonatomic,strong)NSMutableArray* photoPaths;
@property(nonatomic,strong)NSMutableArray* photos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoPaths=[NSMutableArray array];
    self.photos=[NSMutableArray array];
    //获得到APP内群群文件的路径
    NSString* filePath=@"/Users/jiangsu/Desktop/群群";
    //创建数组接收文件
    NSFileManager* fm=[NSFileManager defaultManager];
    NSArray* files=[fm contentsOfDirectoryAtPath:filePath error:nil];
    for (NSString* path in files) {
        //将图片路径存入self.photoPaths数组
        NSString* photoPath=[filePath stringByAppendingPathComponent:path];
        [self.photoPaths addObject:photoPath];
    }
    for (int i=0; i<9; i++) {
        JSPhoto* photo=[[JSPhoto alloc]initWithFrame:CGRectMake(-200,arc4random()%468 , 80, 120)];
        [photo updateUI:[UIImage imageWithContentsOfFile:self.photoPaths[i]]];
        float alphax=i*1.0/10+0.2;
        [photo setImageViewAlpha:alphax];
        [self.view addSubview:photo];
        [self.photos addObject:photo];
    }
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [tap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:tap];
}

-(void)tapAction{//双击事件
    //判断如果有图片的状态为放大 或 绘制的时候不能集合
    for (JSPhoto *p in self.photos) {
        if (p.status == JSPhotoStatusBig||p.status==JSPhotoStatusDraw) {
            return;
        }
    }
    
    
    float w = self.view.bounds.size.width/3;
    float h = self.view.bounds.size.height/3;
    
    
    
    
    [UIView animateWithDuration:.5 animations:^{
        //判断当前图片的状态
        JSPhoto *photo = self.photos[0];
        if (photo.status == JSPhotoStatusNormal) {//如果是流动状态 让图片集合
            for (int i=0; i<self.photos.count; i++) {
                JSPhoto *photo = self.photos[i];
                photo.oldAlpha = photo.alpha;
                photo.oldFrame = photo.frame;
                photo.oldSpeed = photo.speed;
                photo.frame = CGRectMake(i%3*w, i/3*h, w, h);
                photo.photo.frame = photo.bounds;
//                photo.draw.frame = photo.bounds;
                photo.speed = 0;
                photo.alpha = 1;
                photo.status = JSPhotoStatusTogether;
            }
            
            
            
        }else if (photo.status == JSPhotoStatusTogether){//如果是集合状态 让图片流动
            
            for (int i=0; i<self.photos.count; i++) {
                JSPhoto *photo = self.photos[i];
                
                photo.frame = photo.oldFrame;
                photo.photo.frame = photo.bounds;
//                photo.draw.frame = photo.bounds;
                photo.speed = photo.oldSpeed;
                photo.alpha = photo.oldAlpha;
                photo.status = JSPhotoStatusNormal;
            }
            
            
            
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
