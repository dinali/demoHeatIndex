//
//  MainViewController.h
//  demoHeatIndex
//
/*  Author: D. Li
    ViewController to test the HeatIndex class, use this to change the parameters and calculate the Heat Index
 GSA Chop Shop Demo code
 */
//  Created by ISD MacBook on 8/1/14.
//  Copyright (c) 2014 USDAERS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeatIndex.h"

@interface MainViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, retain) IBOutlet UILabel *humidityLabel;
@property (nonatomic, retain) IBOutlet UILabel *heatIndexLabel;
@property (nonatomic, retain) IBOutlet UILabel *riskLevelLabel;
@property (nonatomic, retain) IBOutlet UILabel *heatIndexValue;
@property (nonatomic, retain) IBOutlet UILabel *riskLevelValue;


@end
