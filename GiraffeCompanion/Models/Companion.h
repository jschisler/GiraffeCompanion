//
//  Companion.h
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CostDuration.h"

NS_ASSUME_NONNULL_BEGIN

@interface Companion : NSObject<NSSecureCoding>

@property (strong, nonatomic) NSNumber *companionId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *localImage;
@property (strong, nonatomic) NSString *imageURLDynamicString;
@property (strong, nonatomic) NSData *cachedImage;
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSArray<NSString *> *likes;
@property (strong, nonatomic) NSArray<NSString *> *dislikes;
@property (strong, nonatomic) NSString *blurb;
@property (strong, nonatomic) NSNumber *cost;
@property (assign, nonatomic) CostDuration costDuration;

@end

NS_ASSUME_NONNULL_END
