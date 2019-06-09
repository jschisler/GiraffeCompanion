//
//  CostDuration.h
//  Flopp
//
//  Created by John Schisler on 2019-06-09.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    CostDurationUnknown=-1,
    CostDurationHour,
    CostDurationDay,
    CostDurationWeek
} CostDuration;

NS_ASSUME_NONNULL_BEGIN

@interface CostDurationHelper : NSObject

+ (CostDuration)fromString:(NSString *)duration;
+ (NSString *)toString:(CostDuration)duration;

@end

NS_ASSUME_NONNULL_END
