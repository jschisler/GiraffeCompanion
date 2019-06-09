//
//  CompanionDetailViewModel.h
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Companion.h"
#import "CompanionViewable.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanionDetailViewModel : NSObject<CompanionDetailViewable>

@property (strong, nonatomic) NSString *localImage;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *blurb;
@property (strong, nonatomic) NSString *likes;
@property (strong, nonatomic) NSString *dislikes;

- (instancetype)initWithCompanion:(Companion *)companion;

@end

NS_ASSUME_NONNULL_END
