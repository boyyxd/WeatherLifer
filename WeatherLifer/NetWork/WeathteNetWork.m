//
//  WeahterNetWork.m
//  WeatherLifer
//
//  Created by ink on 15/4/23.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#import "WeatherNetWork.h"

@implementation WeatherNetWork
+ (AFHTTPRequestOperation *)NetRequestGETWithRequestURL: (NSString *) requestURLString
                                   WithReturnValeuBlock: (ReturnValueBlock) block
                                       WithFailureBlock: (FailureBlock) failureBlock
{
    NSURL * url = [NSURL URLWithString:requestURLString];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    return operation;
    
    
    
}


@end
