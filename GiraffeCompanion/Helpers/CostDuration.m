//
//  CostDuration.m
//  Flopp
//
//  Created by John Schisler on 2019-06-09.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import "CostDuration.h"

@implementation CostDurationHelper

+ (CostDuration)fromString:(NSString *)duration {
    if ([duration isEqualToString:@"hour"]) {
        return CostDurationHour;
    } else if ([duration isEqualToString:@"day"]) {
        return CostDurationDay;
    } if ([duration isEqualToString:@"week"]) {
        return CostDurationWeek;
    } else {
        return CostDurationUnknown;
    }
}

+ (NSString *)toString:(CostDuration)duration {
    switch (duration) {
        case CostDurationHour:      return @"hour";
        case CostDurationDay:       return @"day";
        case CostDurationWeek:      return @"week";
        case CostDurationUnknown:
        default:                    return @"unknown";
    }
}

@end
