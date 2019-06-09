//
//  CompanionViewable.h
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CompanionItemViewable

- (NSString *)localImage;
- (NSString *)imageURL;
- (NSData *)cachedImage;
- (NSString *)name;
- (NSString *)age;
- (NSString *)cost;

@end

@protocol CompanionDetailViewable

- (NSString *)localImage;
- (NSString *)imageURL;
- (NSString *)title;
- (NSString *)blurb;
- (NSString *)likes;
- (NSString *)dislikes;

@end
