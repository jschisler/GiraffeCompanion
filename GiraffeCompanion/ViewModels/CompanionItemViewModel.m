//
//  CompanionItemViewModel.m
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import "CompanionItemViewModel.h"
#import "CostDuration.h"

@implementation CompanionItemViewModel

- (instancetype)initWithCompanion:(Companion *)companion {
    if (self = [super init]) {
        self.localImage = companion.localImage;
        self.imageURL = companion.imageURLDynamicString;
        self.cachedImage = companion.cachedImage;
        self.name = [NSString stringWithFormat:@"%@ %@", companion.firstName, companion.lastName];
        self.age = [NSString stringWithFormat:@"Age: %@", companion.age];

        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];

        self.cost = [NSString stringWithFormat:@"%@/%@",
                     [formatter stringFromNumber:companion.cost],
                     [CostDurationHelper toString:companion.costDuration]];
    }

    return self;
}

@end
