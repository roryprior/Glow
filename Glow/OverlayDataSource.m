//
//  OverlayDataSource.m
//  Glow
//
//  Created by Rory Prior on 20/04/2015.
//  Copyright (c) 2015 ThinkMac Software. All rights reserved.
//

#import "OverlayDataSource.h"
#import "OverlayCell.h"

@implementation OverlayDataSource 

- (void) setup
{
  self.overlayArray = [NSMutableArray array];
  
  NSDictionary *basic = @{OverlayNameKey : @"None",
                         OverlayThumbKey : @"thumb-none.png",
                          OverlayTypeKey : [NSNumber numberWithInt: OverlayTypeNone]};
  
  
  [self.overlayArray addObject: basic];
  
  NSArray *names = @[@"4 pane rounded",
                     @"4 pane square",
                     @"8 pane rounded",
                     @"9 pane square",
                     @"15 pane square",
                     @"bars",
                     @"circle",
                     @"cresent",
                     @"diamonds",
                     @"stars",];
  NSArray *thumbs = @[@"thumb-4pane-rounded@2x",
                      @"thumb-4pane@2x",
                      @"thumb-8pane-rounded@2x",
                      @"thumb-9pane@2x",
                      @"thumb-15pane@2x",
                      @"thumb-bars@2x",
                      @"thumb-circle@2x",
                      @"thumb-cresent@2x",
                      @"thumb-diagonal@2x",
                      @"thumb-stars@2x"];
  NSArray *images = @[@"overlay-4pane-rounded@2x",
                      @"overlay-4pane@2x",
                      @"overlay-8pane-rounded@2x",
                      @"overlay-9pane@2x",
                      @"overlay-15pane@2x",
                      @"overlay-bars@2x",
                      @"overlay-circle@2x",
                      @"overlay-cresent@2x",
                      @"overlay-diagonal@2x",
                      @"overlay-stars@2x"];
  
  // Windows
  for(int i = 0; i < [names count]; i++)
  {
    NSDictionary *overlay = @{OverlayNameKey : [names objectAtIndex: i],
                              OverlayThumbKey : [thumbs objectAtIndex: i],
                              OverlayTypeKey : [NSNumber numberWithInt: OverlayTypeNormal],
                              OverlayImagePhoneKey : [images objectAtIndex: i]};
    [self.overlayArray addObject: overlay];
  }
  
  // Solid
  
  
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [self.overlayArray count];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

- (UICollectionViewCell *)collectionView: (UICollectionView *)collectionView
                  cellForItemAtIndexPath: (NSIndexPath *)indexPath
{
  OverlayCell *cell = (OverlayCell *)[collectionView dequeueReusableCellWithReuseIdentifier: @"overlayCell" forIndexPath: indexPath];
  
  NSDictionary *dict = [self.overlayArray objectAtIndex: indexPath.row];
  
  NSString *path = [NSString stringWithFormat: @"%@/Overlays/%@", [[NSBundle mainBundle] resourcePath], [dict objectForKey: OverlayThumbKey]];
  
  [cell.imageView setImage: [[UIImage alloc] initWithContentsOfFile: path]];
  return cell;
}

- (UIImage *) overlayImageForIndexPath:(NSIndexPath *) indexPath
{
  NSDictionary *dict = [self.overlayArray objectAtIndex: indexPath.row];
  
  if([[dict objectForKey: OverlayTypeKey] integerValue] == OverlayTypeNone) return nil;
  
  NSString *path = [NSString stringWithFormat: @"%@/Overlays/%@", [[NSBundle mainBundle] resourcePath], [dict objectForKey: OverlayImagePhoneKey]];
  
  return [[UIImage alloc] initWithContentsOfFile: path];
}

@end
