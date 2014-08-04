//
//  MainViewController.m
//  demoHeatIndex
//
//  Created by ISD MacBook on 8/1/14.
//  Copyright (c) 2014 USDAERS. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// call the methods of the HeatIndex class and display results
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *color;
    
    /* 
    // DEMO: test by passing in one of these values:
    // extreme, high, moderate, lower
    // expected result: the text and color of the 
    // alert label changes
     */
    
    HeatIndex *testHeatIndex = [[HeatIndex alloc]initWithLevel:@"lower"];
    
    self.heatIndexLabel.text = testHeatIndex.labelText;
    color = testHeatIndex.labelColor;
    [self.heatIndexLabel setBackgroundColor:color];
    
    /* DEMO the method to update heat level
    // test by passing in a number between 115 and 91
    // expected result: the 'heat index updated' label
    //displays the value that you enter here
     */
    [testHeatIndex updateheatLevel:116];
    
    self.heatIndexValue.text = testHeatIndex.heatIndexValue;
    
    NSLog(@"heatIndexValue = %@", testHeatIndex.heatIndexValue);
    
    /* DEMO passing params from object for alertBox
    // params: temperature, humidity
    // test temp < 80, humidity > 100, or 0
    // expected result: alert box displays message
     */
    [testHeatIndex calculateHeatIndex:67 :112];
     
    NSString *inTitle = testHeatIndex.alertText.alert;
    NSString *inMessage = testHeatIndex.alertText.error;
    NSString *inButtonLabel = testHeatIndex.alertText.ok;
    
    [self alertBox: inTitle :inMessage :inButtonLabel];
    
    // display user-entered temp
    self.temperatureLabel.text = testHeatIndex.temperatureField;
    
    // display user-entered humidity
    self.humidityLabel.text = testHeatIndex.humidityField;
    
    // DEMO getHeatIndex method return result of
    // calculation
    // params: temp, humidity
    // expected result:'getHeatIndex'label shows results
    float floatValue = [testHeatIndex getHeatIndex:90 :90];
    
    self.riskLevelLabel.text =[NSString stringWithFormat:@"%1.6f", floatValue];
}

- (void)alertBox:(NSString *)title :(NSString *)message :(NSString *)buttonLabel {
    
    NSString *errorTitle = title;
    NSString *errorString = message;
    
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:buttonLabel, nil];
    
    [errorView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
