//
//  OverlayDataSource.h
//  Glow
//
//  Created by Rory Prior on 20/04/2015.
//  Copyright (c) 2015 ThinkMac Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface OverlayDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, retain) NSMutableArray *overlayArray;

- (void) setup;
- (UIImage *) overlayImageForIndexPath:(NSIndexPath *) indexPath;

@end
