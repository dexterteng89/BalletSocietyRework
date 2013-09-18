//
//  PhotoCell.m
//  ScrollViewDemo
//
//  Created by dteng on 9/18/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}

-(void) setPhoto:(UIImage *)photo
{
    self.imageView.image = photo;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
