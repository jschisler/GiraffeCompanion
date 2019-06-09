//
//  CompanionViewController.m
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import "CompanionViewController.h"

@interface CompanionViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *blurbLabel;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
@property (strong, nonatomic) IBOutlet UILabel *dislikesLabel;

@end

@implementation CompanionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = nil;
    self.imageView.image = nil;
    self.blurbLabel.text =
        self.likesLabel.text =
        self.dislikesLabel.text = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationItem.title = self.companionDetailViewModel.title;
    self.imageView.image = [UIImage imageNamed:self.companionDetailViewModel.localImage];

    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont italicSystemFontOfSize:
                                                        self.blurbLabel.font.pointSize],
                                };

    NSAttributedString *attributedText =
        [[NSAttributedString alloc] initWithString:self.companionDetailViewModel.blurb
                                        attributes:attributes];

    self.blurbLabel.attributedText = attributedText;
    self.likesLabel.text = self.companionDetailViewModel.likes;
    self.dislikesLabel.text = self.companionDetailViewModel.dislikes;
}

@end
