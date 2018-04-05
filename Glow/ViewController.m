//
//  ViewController.m
//  Glow
//
//  Created by Rory Prior on 27/11/2014.
//  Copyright (c) 2014 ThinkMac Software. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad
{
  [super viewDidLoad];
  
  [[UIApplication sharedApplication] setStatusBarHidden: YES];
  [self setNeedsStatusBarAppearanceUpdate];
  
  [collectionView registerNib: [UINib nibWithNibName: @"OverlayCell" bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier: @"overlayCell"];
  [(UICollectionViewFlowLayout *)[collectionView collectionViewLayout] setItemSize: CGSizeMake(60, 80)];
  [(UICollectionViewFlowLayout *)[collectionView collectionViewLayout] setSectionInset: UIEdgeInsetsMake(0, 0, 0, 0)];
  [(UICollectionViewFlowLayout *)[collectionView collectionViewLayout] setMinimumInteritemSpacing: 4];
  [(UICollectionViewFlowLayout *)[collectionView collectionViewLayout] setMinimumLineSpacing: 0];

  overlayDataSource = [OverlayDataSource new];
  [overlayDataSource setup];
  
  [collectionView setDataSource: overlayDataSource];
  [collectionView setDelegate: self];

  controlPanelVisible = NO;
  [controlPanel setAlpha: 0.0];
  
  [[controlPanel layer] setOpaque: NO];
  [[controlPanel layer] setShadowColor: [[UIColor blackColor] CGColor]];
  [[controlPanel layer] setShadowOffset: CGSizeMake(0, 5 * 2)];
  [[controlPanel layer] setShadowRadius: 5 * 2];
  [[controlPanel layer] setShadowOpacity: 0.25];
  
  [brightnessSlider setMaximumTrackTintColor: [UIColor colorWithWhite:0.902 alpha:1.000]];
  [colourTempSlider setMaximumTrackTintColor: [UIColor colorWithRed:1.000 green:0.800 blue:0.400 alpha:1.000]];
  
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void) viewWillAppear:(BOOL)animated
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [brightnessSlider setValue: [defaults floatForKey: GlowBrightnessKey]];
  [colourTempSlider setValue: [defaults floatForKey: GlowColourTempKey]];
  
  [label setAlpha: 0.75];
  
  [UIView animateWithDuration: 1.0 delay: 2.0 options: UIViewAnimationOptionAllowUserInteraction animations:^{
    [label setAlpha: 0.05];
  } completion:^(BOOL finished) {
    
  }];
  
  [controlPanel setBackgroundColor: [UIColor clearColor]];
  
  if(controlPanelVisible) [label setText: @"Double tap to hide controls"];
  else [label setText: @"Double tap to show controls"];
  
  [self doAdjustColourTemp: nil];
  
  [collectionView reloadData];
}

- (IBAction) doToggleControlPanel:(id) sender
{
  controlPanelVisible = !controlPanelVisible;
  
  [UIView animateWithDuration: 0.25 animations:^{
    if(controlPanelVisible) [controlPanel setAlpha: 1.0];
    else [controlPanel setAlpha: 0.0];
    
    if(controlPanelVisible) [label setText: @"Double tap to hide controls"];
    else [label setText: @"Double tap to show controls"];
  }];
}

- (IBAction) doPresetCandle:(id) sender
{
  [colourTempSlider setValue: 1850 animated: YES];
  [self doAdjustColourTemp: nil];
}

- (IBAction) doPresetIncandescent:(id) sender
{
  [colourTempSlider setValue: 2900 animated: YES];
  [self doAdjustColourTemp: nil];
}

- (IBAction) doPresetStudio:(id) sender
{
  [colourTempSlider setValue: 3200 animated: YES];
  [self doAdjustColourTemp: nil];
}

- (IBAction) doPresetSunny:(id) sender
{
  [colourTempSlider setValue: 5500 animated: YES];
  [self doAdjustColourTemp: nil];
}

- (IBAction) doPresetCloudy:(id) sender
{
  [colourTempSlider setValue: 6500 animated: YES];
  [self doAdjustColourTemp: nil];
}

- (IBAction) doAdjustBrightness:(id) sender
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setFloat: [brightnessSlider value] forKey: GlowBrightnessKey];
  [[UIScreen mainScreen] setBrightness: [brightnessSlider value]];
}

- (IBAction) doAdjustColourTemp:(id) sender
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
  [numberFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
  [numberFormatter setLocale: [NSLocale currentLocale]];
  [numberFormatter setUsesGroupingSeparator: YES];
  [numberFormatter setMaximumFractionDigits: 0];
  
  NSString *kelvinSting = [NSString localizedStringWithFormat: @"%@ K",
                           [numberFormatter stringFromNumber: [NSNumber numberWithDouble: [colourTempSlider value]]]];
  
  [kelvinLabel setText: kelvinSting];
  
  float temperature = [colourTempSlider value] / 100;
  float red = 0;
  float blue = 0;
  float green = 0;
  
  // red component
  if(temperature <= 66) red = 255;
  else
  {
    red = temperature - 60;
    red = 329.698727446 * powf(red, -0.1332047592);
    if(red < 0) red = 0;
    if(red > 255) red = 255;
  }
  
  // green component
  if (temperature <= 66)
  {
    green = temperature;
    green = 99.4708025861 * log(green) - 161.1195681661;
    if(green < 0) green = 0;
    if(green > 255) green = 255;
  }
  else
  {
    green = temperature - 60;
    green = 288.1221695283 * powf(green, -0.0755148492);
    if(green < 0) green = 0;
    if(green > 255) green = 255;
  }
  
  // blue component
  if(temperature >= 66)  blue = 255;
  else if(temperature <= 19)  blue = 0;
  else
  {
    blue = temperature - 10;
    blue = 138.5177312231 * log(blue) - 305.0447927307;
    if(blue < 0) blue = 0;
    if(blue > 255) blue = 255;
  }
  
  UIColor *color = [UIColor colorWithRed: red / 255 green: green / 255 blue: blue / 255 alpha: 1.0];
  [self.view setBackgroundColor: color];
  [collectionView setBackgroundColor: color];
  
  [defaults setFloat: colourTempSlider.value forKey: GlowColourTempKey];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"selection made");
  [overlayImageView setImage: [overlayDataSource overlayImageForIndexPath: indexPath]];
}


@end
