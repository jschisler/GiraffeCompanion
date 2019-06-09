//
//  GiraffeCompanionTests.m
//  GiraffeCompanionTests
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Companion.h"
#import "CompanionBuilder.h"
#import "CompanionItemViewModel.h"
#import "CompanionDetailViewModel.h"

@interface GiraffeCompanionTests : XCTestCase

@property (strong, nonatomic) NSArray<Companion *> *companions;

+ (NSData *)loadJSONDataFromFixtureWithFileName:(NSString *)fileName;

@end

@implementation GiraffeCompanionTests

+ (NSData *)loadJSONDataFromFixtureWithFileName:(NSString *)fileName {
    NSString *basename = [fileName stringByDeletingPathExtension];
    NSString *extension = [fileName pathExtension];
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:basename ofType:extension];

    NSData *data = [NSData dataWithContentsOfFile:filePath];

    return data;
}

- (void)setUp {
    id json = [GiraffeCompanionTests loadJSONDataFromFixtureWithFileName:@"companions.json"];
    NSError *error;

    self.companions = [CompanionBuilder companionsFromJSON:json error:&error];

    if (error) {
        NSLog(@"Error while trying to get companion data: %@", error.localizedDescription);
    }
}

- (void)testCompanionItemViewModelPropertiesCorrect {
    CompanionItemViewModel *viewModel =
        [[CompanionItemViewModel alloc] initWithCompanion:self.companions.firstObject];

    XCTAssertEqualObjects(viewModel.localImage, @"Vic");
    XCTAssertEqualObjects(viewModel.imageURL, @"https://img.izismile.com/img/img2/20090731/funny_giraffe_01.jpg");
    XCTAssertEqualObjects(viewModel.name, @"Vic T. Orr");
    XCTAssertEqualObjects(viewModel.age, @"Age: 8");
    XCTAssertEqualObjects(viewModel.cost, @"$100.00/hour");
}

- (void)testCompanionDetailViewModelPropertiesCorrect {
    CompanionDetailViewModel *viewModel =
        [[CompanionDetailViewModel alloc] initWithCompanion:self.companions.firstObject];

    XCTAssertEqualObjects(viewModel.localImage, @"Vic");
    XCTAssertEqualObjects(viewModel.imageURL, @"https://img.izismile.com/img/img2/20090731/funny_giraffe_01.jpg");
    XCTAssertEqualObjects(viewModel.title, @"Vic(8) - $100.00/hour");
    XCTAssertEqualObjects(viewModel.blurb, @"\"I wanna chick who likes to watch me pump iron!!!\"");
    XCTAssertEqualObjects(viewModel.likes, @"Likes: working out bro, grunting, lifting heavy stuff");
    XCTAssertEqualObjects(viewModel.dislikes, @"Dislikes: kids, cupcakes, feathers");
}

- (void)testModelLoading {
}

- (void)testDelegateCalling {
}

- (void)testCompletionCallingForASyncCalls {
}

- (void)testCostDurationHelper {
}

- (void)testCompanionBuilderWithValidData {
}

- (void)testCompanionBuilderWithInvalidData {
}

@end
