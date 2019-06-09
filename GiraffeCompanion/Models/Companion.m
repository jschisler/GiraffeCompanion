//
//  Companion.m
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import "Companion.h"

@implementation Companion

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.companionId = [decoder decodeObjectForKey:@"companionId"];
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.localImage = [decoder decodeObjectForKey:@"localImage"];
        self.imageURLDynamicString = [decoder decodeObjectForKey:@"imageURLDynamicString"];
        self.age = [decoder decodeObjectForKey:@"age"];
        self.likes = [decoder decodeObjectForKey:@"likes"];
        self.dislikes = [decoder decodeObjectForKey:@"dislikes"];
        self.blurb = [decoder decodeObjectForKey:@"blurb"];
        self.cost = [decoder decodeObjectForKey:@"cost"];
        self.costDuration = [decoder decodeIntForKey:@"costDuration"];

        NSString *imagePath = [decoder decodeObjectForKey:@"dynamicImagePath"];

        if (imagePath) {
            self.cachedImage = [NSData dataWithContentsOfFile:imagePath];
        }
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.companionId forKey:@"companionId"];
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.localImage forKey:@"localImage"];
    [encoder encodeObject:self.imageURLDynamicString forKey:@"imageURLDynamicString"];
    [encoder encodeObject:self.age forKey:@"age"];
    [encoder encodeObject:self.likes forKey:@"likes"];
    [encoder encodeObject:self.dislikes forKey:@"dislikes"];
    [encoder encodeObject:self.blurb forKey:@"blurb"];
    [encoder encodeObject:self.cost forKey:@"cost"];
    [encoder encodeInt:self.costDuration forKey:@"costDuration"];

    // TODO: Find an appropriate place to clean up all cached image files
    if (self.cachedImage) {
        // Since NSUserDefaults isn't meant to store blobs of data store the path to a local file
        // with the path being stored.
        NSString *imagePath = [Companion documentsPathForFileName:[NSString stringWithFormat:@"image_%f.jpg",
                                                                   [NSDate timeIntervalSinceReferenceDate]]];
        [self.cachedImage writeToFile:imagePath atomically:YES];
        [encoder encodeObject:imagePath forKey:@"dynamicImagePath"];
    }
}

+ (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];

    return [documentsPath stringByAppendingPathComponent:name];
}

@end
