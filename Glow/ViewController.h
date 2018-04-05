//
//  ViewController.h
//  Glow
//
//  Created by Rory Prior on 27/11/2014.
//  Copyright (c) 2014 ThinkMac Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayDataSource.h"

@interface ViewController : UIViewController <UICollectionViewDelegate>
{
  IBOutlet UIView *controlPanel;
  IBOutlet UISlider *brightnessSlider;
  IBOutlet UISlider *colourTempSlider;
  IBOutlet UILabel *label;
  IBOutlet UILabel *kelvinLabel;
  IBOutlet UICollectionView *collectionView;
  IBOutlet UIImageView *overlayImageView;
  
  BOOL controlPanelVisible;
  OverlayDataSource *overlayDataSource;
}

- (IBAction) doToggleControlPanel:(id) sender;
- (IBAction) doAdjustBrightness:(id) sender;
- (IBAction) doAdjustColourTemp:(id) sender;


- (IBAction) doPresetCandle:(id) sender;
- (IBAction) doPresetIncandescent:(id) sender;
- (IBAction) doPresetStudio:(id) sender;
- (IBAction) doPresetSunny:(id) sender;
- (IBAction) doPresetCloudy:(id) sender;

@end

