//
//  CompanionBuilder.h
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompanionBuilder : NSObject

+ (NSArray *)companionsFromJSON:(NSData *)json error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
