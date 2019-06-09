//
//  CompanionBuilder.m
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import "Companion.h"
#import "CompanionBuilder.h"

@implementation CompanionBuilder

+ (NSArray *)companionsFromJSON:(NSData *)json error:(NSError **)error {
    NSError *localError = nil;
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:json options:0 error:&localError];

    if (localError != nil) {
        *error = localError;
        return nil;
    }

    NSMutableArray *companions = [[NSMutableArray alloc] init];
    NSLog(@"Count %lu", (unsigned long)parsedObject.count);

    for (NSDictionary *companionDic in parsedObject) {
        Companion *companion = [[Companion alloc] init];

        // This should really be done in some sort of map key -> variable, but this gets the job done right now
        for (NSString *key in companionDic) {
            if ([key isEqualToString:@"companion_id"]) {
                companion.companionId = companionDic[key];
            } else if ([key isEqualToString:@"first_name"]) {
                companion.firstName = companionDic[key];
            } else if ([key isEqualToString:@"last_name"]) {
                companion.lastName = companionDic[key];
            } else if ([key isEqualToString:@"local_image"]) {
                companion.localImage = companionDic[key];
            } else if ([key isEqualToString:@"image_url_dynamic"]) {
                companion.imageURLDynamicString = companionDic[key];
            } else if ([key isEqualToString:@"age"]) {
                companion.age = companionDic[key];
            } else if ([key isEqualToString:@"likes"]) {
                companion.likes = companionDic[key];
            } else if ([key isEqualToString:@"dislikes"]) {
                companion.dislikes = companionDic[key];
            } else if ([key isEqualToString:@"blurb"]) {
                companion.blurb = companionDic[key];
            } else if ([key isEqualToString:@"cost"]) {
                companion.cost = companionDic[key];
            } else if ([key isEqualToString:@"duration"]) {
                companion.costDuration = [CostDurationHelper fromString:companionDic[key]];
            }
        }

        [companions addObject:companion];
    }

    return companions;
}

@end
