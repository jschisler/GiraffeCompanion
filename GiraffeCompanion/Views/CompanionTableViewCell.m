//
//  CompanionTableViewCell.m
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import "ApiClient.h"
#import "CompanionTableViewCell.h"

@interface CompanionTableViewCell() <ApiClientDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *companionImageView;
@property (strong, nonatomic) IBOutlet UIImageView *dynamicImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *costLabel;
@property (strong, nonatomic) IBOutlet ApiClient *client;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *aiv;

@end

@implementation CompanionTableViewCell

- (void)updateWithViewable:(id<CompanionItemViewable>)viewable {
    self.companionImageView.image = [UIImage imageNamed:viewable.localImage];
    self.nameLabel.text = viewable.name;
    self.ageLabel.text = viewable.age;
    self.costLabel.text = viewable.cost;

    self.client = [ApiClient new];
    self.client.delegate = self;

    if (self.online && viewable.imageURL) {
        self.aiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.dynamicImageView.backgroundColor = UIColor.lightGrayColor;
        [self.dynamicImageView addSubview:self.aiv];
        [self.aiv startAnimating];

        [self.client getImageFromURL:viewable.imageURL];
    } else {
        self.dynamicImageView.image = [UIImage imageWithData:viewable.cachedImage];
    }
}

- (void)fetchingImageFailedWithError:(nonnull NSError *)error {
    NSLog(@"Error while trying to retrieve remote image data: %@", error.localizedDescription);

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.aiv removeFromSuperview];
        self.dynamicImageView.backgroundColor = UIColor.clearColor;
    });
}

- (void)receivedImage:(nonnull NSData *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.dynamicImageView.image = [UIImage imageWithData:data];
        [self.aiv removeFromSuperview];
        self.dynamicImageView.backgroundColor = UIColor.clearColor;
    });

    if (self.delegate) {
        [self.delegate companionTableViewCell:self imageLoaded:data];
    }
}

@end
