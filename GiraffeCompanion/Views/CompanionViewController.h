//
//  CompanionViewController.h
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CompanionDetailViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompanionViewController : UIViewController

@property (strong, nonatomic) CompanionDetailViewModel *companionDetailViewModel;

@end

NS_ASSUME_NONNULL_END
