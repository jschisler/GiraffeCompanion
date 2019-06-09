//
//  CompanionItemViewModel.h
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Companion.h"
#import "CompanionViewable.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanionItemViewModel : NSObject<CompanionItemViewable>

@property (strong, nonatomic) NSString *localImage;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSData *cachedImage;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *cost;

- (instancetype)initWithCompanion:(Companion *)companion;

@end

NS_ASSUME_NONNULL_END
