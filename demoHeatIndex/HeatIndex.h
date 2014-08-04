//
//  heatIndex.h
//  Heat Tool

/*  Author: D. Li
    Calculates the heat index and returns text and background color for the UI
    GSA Chop Shop Demo code
*/
//  Created by ISD MacBook on 8/1/14.
//  Copyright (c) 2014 PixelBit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Language.h"
#import "AlertBoxParamPasser.h"

@interface HeatIndex : NSObject

@property NSString *labelText;
@property UIColor *labelColor;
@property NSString *heatLevel;
@property NSString *temperatureField;
@property NSString *humidityField;
@property NSString *currentHeatIndex;
@property NSString *heatIndexValue;
@property AlertBoxParamPasser *alertText;

-(id)initWithLevel:(NSString *)heatIndexCat;

-(void)updateheatLevel:(double)level;

-(void)calculateHeatIndex:(float) temperature :(float)humidity;

- (float)getHeatIndex:(float)temp :(float)humidity;




@end
