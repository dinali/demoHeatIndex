//
//  heatIndex.m
//  Heat Tool
//
//  Created by ISD MacBook on 8/1/14.
//  Copyright (c) 2014 PixelBit. All rights reserved.
//

#import "HeatIndex.h"

@implementation HeatIndex{
    NSString *defaultHeatIndexCat;
}

// display a label depending on the heat index
// this should be put in a separate method
-(id)initWithLevel:(NSString *)heatIndexCat
{
    self = [super init];
    
    if (self) {
        if([heatIndexCat  isEqual: @"extreme"]) {
            self.labelText = [Language getLocalizedString:@"LVL_EXTREME"];
            self.labelColor =[UIColor colorWithRed:254.0/255 green:0/255 blue:0/255 alpha:1];
        } else if([heatIndexCat  isEqual: @"high"]) {
            self.labelText = [Language getLocalizedString:@"LVL_HIGH"];
            self.labelColor =[UIColor colorWithRed:247.0/255 green:142.0/255 blue:1.0/255 alpha:1];
        } else if([heatIndexCat  isEqual: @"moderate"]) {
            self.labelText = [Language getLocalizedString:@"LVL_MODERATE"];
            self.labelColor = [UIColor colorWithRed:254.0/255 green:211.0/255 blue:156.0/255 alpha:1];
        } else if([heatIndexCat  isEqual: @"lower"]) {
            self.labelText = [Language getLocalizedString:@"LVL_LOWER"];
            self.labelColor =[UIColor colorWithRed:255.0/255 green:255.0/255 blue:0/255 alpha:1];
        } else {
            self.labelText = [Language getLocalizedString:@"LVL_LOWER"];
            self.labelColor =[UIColor colorWithRed:255.0/255 green:255.0/255 blue:0/255 alpha:1];
    }
    
        NSLog(@"text = %@",self.labelText);
    }
    return self;
}

- (id)init {
    // Forward to the "designated" initialization method
    defaultHeatIndexCat = @"high";
    return [self initWithLevel:defaultHeatIndexCat];
}

#pragma mark - Heat Index Methods

// modify the heat index value based on the level
- (void)updateheatLevel:(double)level {
    
    // Check heat level
    if(level > 115) {
        self.heatLevel = @"extreme";
    } else if(level > 103 & level <= 115) {
        self.heatLevel = @"high";
    } else if(level >= 91 & level <= 103) {
        self.heatLevel = @"moderate";
    } else if(level < 91) {
        self.heatLevel = @"lower";
    } else {
        self.heatLevel = @"lower";
    }
    
    // set heat index value
    self.currentHeatIndex = [NSString stringWithFormat:@"%.1f", level];
    
    self.heatIndexValue = [NSString stringWithFormat:@"%@ °F", self.currentHeatIndex];
}

// calculate Heat Index based on temperature and humidity; display an alert on error
- (void)calculateHeatIndex:(float) temperature :(float)humidity {
    NSLog(@"[calculateHeatIndex] temperature: %f, humidity: %f", temperature, humidity);
    
    BOOL errors = FALSE;
    
    self.temperatureField = [NSString stringWithFormat:@"%f °F", temperature];
    
    self.humidityField = [NSString stringWithFormat:@"%.1f",humidity];
    
    self.alertText = [[AlertBoxParamPasser alloc]init];
    
    if(temperature == 0 && humidity == 0) {
        self.alertText.error = [Language getLocalizedString:@"ERROR"];
        self.alertText.alert = [Language getLocalizedString:@"ALERT_TEMP_EMPTY"];
        self.alertText.ok = [Language getLocalizedString:@"OK"];
        errors = TRUE;
    } else if(temperature == 0 || humidity==0) {
        self.alertText.error = [Language getLocalizedString:@"ERROR"];
        self.alertText.alert = [Language getLocalizedString:@"ALERT_TEMP_EMPTY"];
        self.alertText.ok = [Language getLocalizedString:@"OK"];
        errors = TRUE;
    } else if(humidity == 0) {
        self.alertText.error = [Language getLocalizedString:@"ERROR"];
        self.alertText.alert = [Language getLocalizedString:@"ALERT_HUMID_EMPTY"];
         self.alertText.ok = [Language getLocalizedString:@"OK"];
        errors = TRUE;
    }
    if(temperature > 0 && humidity > 0) {
        if(temperature < 80) {
            self.alertText.error = [Language getLocalizedString:@"ALERT"];
            self.alertText.alert = [Language getLocalizedString:@"TEMP_UNDER_80"];
            self.alertText.ok = [Language getLocalizedString:@"OK"];
            errors = TRUE;
        } else if(humidity > 100) {
            self.alertText.error = [Language getLocalizedString:@"ALERT"];
            self.alertText.alert = [Language getLocalizedString:@"HUMID_OVER_100"];
            self.alertText.ok = [Language getLocalizedString:@"OK"];
            errors = TRUE;
        }
    }
}

// calculate the heat index based on temperature and humidity
- (float)getHeatIndex:(float)temp :(float)humidity {
    
    NSLog(@"[getHeatIndex] temp: %f, humidity: %f", temp, humidity);
    
    float hIndex =
    -42.379 + 2.04901523 * temp
    + 10.14333127 * humidity
    - 0.22475541 * temp * humidity
    - 6.83783 * pow(10, -3) * temp * temp
    - 5.481717 * pow(10, -2) * humidity * humidity
    + 1.22874 * pow(10, -3) * temp * temp * humidity
    + 8.5282 * pow(10, -4) * temp * humidity * humidity
    - 1.99 * pow(10, -6) * temp * temp * humidity * humidity;
    
    NSLog(@"-Heat Index: %f", hIndex);
    return hIndex;
}

// TODO: needs to be modified to pass the NOAA data
/*
- (void)getCurrentHeatIndex {
    [self getNOAAData];
    
    noaaTime.text = @"";
    
    for(id obj in validIndexes) {
        NSInteger tmpHour = [[[_time objectAtIndex:[obj integerValue]] substringWithRange:NSMakeRange(11, 2)] integerValue];
        if(hour == tmpHour) {
            NSString *time = [_time objectAtIndex:[obj integerValue]];
            float temperature = [[_temperature objectAtIndex:[obj integerValue]] floatValue];
            float humidity = [[_humidity objectAtIndex:[obj integerValue]] floatValue];
            
            NSLog(@"time: %@", time);
            
            NSString *ampm = nil;
            
            if(tmpHour < 12) {
                ampm = @"am";
            } else {
                if(tmpHour > 12) {
                    tmpHour = (tmpHour - 12);
                }
                ampm = @"pm";
            }
            
            noaaHour = tmpHour;
            noaaAMPM = ampm;
            noaaTime.text = [NSString stringWithFormat:[Language getLocalizedString:@"NOAA_TIME"], noaaHour, noaaAMPM];
            
            [self calculateHeatIndex:temperature:humidity];
            break;
        }
    }
}
*/

/*
- (void)getMaxHeatIndex {
    
    [self getNOAAData];
    
    noaaTime.text = @"";
    
    float tmpHeatIndex = 0;
    float tmpMaxHeatIndex = 0;
    float tmpTemperature = 0;
    float tmpHumidity = 0;
    
    for(id obj in validIndexes) {
        NSInteger tmpHour = [[[_time objectAtIndex:[obj integerValue]] substringWithRange:NSMakeRange(11, 2)] integerValue];
        if(tmpHour > hour) {
            NSLog(@"getMaxHeatIndex - Hour %d", tmpHour);
            float temperature = [[_temperature objectAtIndex:[obj integerValue]] floatValue];
            float humidity = [[_humidity objectAtIndex:[obj integerValue]] floatValue];
            tmpHeatIndex = [self getHeatIndex:temperature:humidity];
            if(tmpHeatIndex > tmpMaxHeatIndex)
            {
                tmpMaxHeatIndex = tmpHeatIndex;
                tmpTemperature = temperature;
                tmpHumidity = humidity;
                
                NSString *ampm = nil;
                
                if(tmpHour < 12) {
                    ampm = @"am";
                } else {
                    if(tmpHour > 12) {
                        tmpHour = (tmpHour - 12);
                    }
                    ampm = @"pm";
                }
                
                noaaHour = tmpHour;
                noaaAMPM = ampm;
                noaaTime.text = [NSString stringWithFormat:[Language getLocalizedString:@"NOAA_TIME"], noaaHour, noaaAMPM];
            }
        }
    }
    
    if(tmpTemperature < 80.0) {
        noaaTime.text = @"";
        [self getCurrentHeatIndex];
        return;
    }
    
    NSLog(@"tmpMaxHeatIndex: %f", tmpMaxHeatIndex);
    //[self updateself.heatLevel:tmpMaxHeatIndex];
    [self calculateHeatIndex:tmpTemperature:tmpHumidity];
}
*/
@end
