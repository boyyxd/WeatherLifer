//
//  MAThermometer.h
//  MAThermometer-Demo
//
//  Created by Michael Azevedo on 16/06/2014.
//

#import <UIKit/UIKit.h>

@interface MAThermometer : UIView

@property (nonatomic, assign) CGFloat curValue;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat maxValue;


@property (nonatomic, strong) NSArray * arrayColors;

@end