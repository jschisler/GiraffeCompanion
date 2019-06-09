//
//  ApiClient.m
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//
@import UIKit;

#import "ApiClient.h"
#import "CompanionBuilder.h"

@implementation ApiClient

+ (id)loadJsonFixtureWithFileName:(NSString *)fileName {
    NSString *basename = [fileName stringByDeletingPathExtension];
    NSString *extension = [fileName pathExtension];
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:basename ofType:extension];

    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSString *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

    if (error) {
        NSLog(@"error: %@", error);
    }

    return json;
}

+ (NSData *)loadJSONDataFromFixtureWithFileName:(NSString *)fileName {
    NSString *basename = [fileName stringByDeletingPathExtension];
    NSString *extension = [fileName pathExtension];
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:basename ofType:extension];

    NSData *data = [NSData dataWithContentsOfFile:filePath];

    return data;
}

- (void)fetchCompanions:(ClientCompletionHandler)completion {
    if (completion) {
        id json = [ApiClient loadJSONDataFromFixtureWithFileName:@"companions.json"];

        completion(nil, json, nil);
    }
}

- (void)getImageFromURL:(NSString *)url {
    NSURLSessionDataTask *task =
        [NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:url]
                                  completionHandler:^(NSData * _Nullable data,
                                                      NSURLResponse * _Nullable response,
                                                      NSError * _Nullable error) {
        if (error) {
            [self.delegate fetchingImageFailedWithError:error];
        } else {
            [self.delegate receivedImage:data];
        }
    }];

    [task resume];
}

@end
