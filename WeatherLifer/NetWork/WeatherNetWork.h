//
//  WeahterNetWork.h
//  WeatherLifer
//
//  Created by ink on 15/4/23.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
typedef void (^ReturnValueBlock) (id responseObject);
typedef void (^FailureBlock)(id error);
@interface WeatherNetWork : NSObject
+ (AFHTTPRequestOperation *)NetRequestGETWithRequestURL: (NSString *) requestURLString
                                   WithReturnValeuBlock: (ReturnValueBlock) block
                                       WithFailureBlock: (FailureBlock) failureBlock;
@end
