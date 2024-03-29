//
//  SpiralLayoutAttributes.h
//  ScrollViewDemo
//
//  Created by dteng on 9/18/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpiralLayoutAttributes : UICollectionViewLayoutAttributes

// whether header view (ConferenceHeader class) should align label left or center (default = left)
@property (nonatomic, assign) NSTextAlignment headerTextAlignment;

// shadow opacity for the shadow on the photo in SpeakerCell (default = 0.5)
@property (nonatomic, assign) CGFloat shadowOpacity;

@end