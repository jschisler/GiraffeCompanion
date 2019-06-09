//
//  ApiClient.h
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ClientCompletionHandler)(NSURLSessionDataTask * _Nullable task,
                                        id _Nullable responseObject,
                                        NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@protocol ApiClientDelegate <NSObject>

- (void)receivedImage:(NSData *)data;
- (void)fetchingImageFailedWithError:(NSError *)error;

@end

@interface ApiClient : NSObject

@property (weak, nonatomic) id<ApiClientDelegate> delegate;

- (void)fetchCompanions:(ClientCompletionHandler)completion;
- (void)getImageFromURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
