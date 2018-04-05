//
//  RoundRectView.m
//  Glow
//
//  Created by Rory Prior on 27/11/2014.
//  Copyright (c) 2014 ThinkMac Software. All rights reserved.
//

#import "RoundRectView.h"

@implementation RoundRectView

- (void) drawRect:(CGRect)rect
{
  [super drawRect: rect];
  
  UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect: [self bounds] cornerRadius: 16];
  [[UIColor whiteColor] set];
  [path fill];
}

@end
