//
//  CompanionTableViewCell.h
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CompanionViewable.h"

NS_ASSUME_NONNULL_BEGIN

@class CompanionTableViewCell;

@protocol CompanionTableViewCellDelegate

- (void)companionTableViewCell:(CompanionTableViewCell *)companionTableViewCell imageLoaded:(NSData *)imageData;

@end

@interface CompanionTableViewCell : UITableViewCell

@property (strong, nonatomic) id<CompanionTableViewCellDelegate>delegate;
@property (assign, nonatomic) BOOL online;

- (void)updateWithViewable:(id<CompanionItemViewable>)viewable;

@end

NS_ASSUME_NONNULL_END
