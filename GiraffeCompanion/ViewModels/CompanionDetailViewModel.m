//
//  CompanionDetailViewModel.m
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import "CompanionDetailViewModel.h"

@implementation CompanionDetailViewModel

- (instancetype)initWithCompanion:(Companion *)companion {
    if (self = [super init]) {
        self.localImage = companion.localImage;
        self.imageURL = companion.imageURLDynamicString;

        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];

        self.title = [NSString stringWithFormat:@"%@(%@) - %@/%@",
                      companion.firstName, companion.age,
                      [formatter stringFromNumber:companion.cost],
                      [CostDurationHelper toString:companion.costDuration]];

        self.blurb = [NSString stringWithFormat:@"\"%@\"", companion.blurb];
        self.likes = [@"Likes: " stringByAppendingString:[companion.likes componentsJoinedByString:@", "]];
        self.dislikes = [@"Dislikes: " stringByAppendingString:[companion.dislikes componentsJoinedByString:@", "]];
    }

    return self;
}

@end
