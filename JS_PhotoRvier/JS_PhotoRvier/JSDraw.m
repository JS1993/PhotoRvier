//
//  JSDraw.m
//  JS_PhotoRvier
//
//  Created by  江苏 on 16/3/14.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "JSDraw.h"

@implementation JSDraw

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES; 
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

@end
