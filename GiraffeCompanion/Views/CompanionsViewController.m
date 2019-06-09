//
//  CompanionsViewController.m
//  GiraffeCompanion
//
//  Created by John Schisler on 2019-06-08.
//  Copyright © 2019 Schisler Rocks. All rights reserved.
//

#import "ApiClient.h"
#import "Companion.h"
#import "CompanionBuilder.h"
#import "CompanionsViewController.h"
#import "CompanionTableViewCell.h"
#import "CompanionViewController.h"
#import "CompanionItemViewModel.h"

static NSString * const kSegueShowCompanion = @"SegueShowCompanion";
static NSString * const kCompanionCell = @"CompanionCell";
static NSString * const kOnlineKey = @"Online";
static NSString * const kCompanionsKey = @"Companions";

@interface CompanionsViewController () <UITableViewDelegate, UITableViewDataSource, CompanionTableViewCellDelegate>

@property (strong, nonatomic) ApiClient *client;
@property (strong, nonatomic) NSArray<Companion *> *companions;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISwitch *onlineSwitch;
@property (strong, nonatomic) IBOutlet UILabel *onlineStatusLabel;

@end

@implementation CompanionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];

    self.client = [ApiClient new];

    [self registerNibs];

    NSNumber *online = [[NSUserDefaults standardUserDefaults] objectForKey:kOnlineKey];

    self.onlineSwitch.on = online ? online.boolValue : YES;

    [self onlineSwitchChanged:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self reloadData];
}

- (void)registerNibs {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([CompanionTableViewCell class])
                                bundle:bundle];

    [self.tableView registerNib:nib forCellReuseIdentifier:kCompanionCell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kSegueShowCompanion]) {
        CompanionViewController *vc = segue.destinationViewController;
        vc.companionDetailViewModel = [[CompanionDetailViewModel alloc] initWithCompanion:sender];
    }
}

- (void)cacheData {
    // Save to NSUserDefaults. This would actually be better to save to Core Data or a third party datastore like Realm
    NSError *encodingError;
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.companions requiringSecureCoding:NO error:&encodingError];

    if (encodingError) {
        NSLog(@"Unable to archive companions: %@", encodingError.localizedDescription);
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:kCompanionsKey];
    }
}

- (void)reloadData {
    if (self.onlineSwitch.on) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kCompanionsKey];
        __weak __typeof(self) weakSelf = self;

        [self.client fetchCompanions:^(NSURLSessionDataTask * _Nullable task,
                                       id  _Nullable responseObject,
                                       NSError * _Nullable error) {
            self.companions = [CompanionBuilder companionsFromJSON:responseObject error:nil];

            [weakSelf cacheData];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
    } else {
        NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:kCompanionsKey];
        NSSet *set = [NSSet setWithArray:@[
                                           [NSArray class],
                                           [Companion class]
                                          ]];

        NSError *error;

        self.companions = [NSKeyedUnarchiver unarchivedObjectOfClasses:set
                                                              fromData:encodedObject
                                                                 error:&error];

        if (error) {
            NSLog(@"Unable to unarchive companions: %@", error.localizedDescription);
        } else {
            [self.tableView reloadData];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.companions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompanionTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCompanionCell];
    CompanionItemViewModel *viewModel = [[CompanionItemViewModel alloc] initWithCompanion:self.companions[indexPath.row]];

    cell.tag = self.companions[indexPath.row].companionId.integerValue;
    cell.delegate = self;
    cell.online = self.onlineSwitch.on;

    [cell updateWithViewable:viewModel];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CompanionTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    NSArray *companionMatches = [self.companions filteredArrayUsingPredicate:
                                 [NSPredicate predicateWithFormat:@"companionId == %d", cell.tag]];

    // I really hate using sender here for data transfer, but it's the simplest way for now
    [self performSegueWithIdentifier:kSegueShowCompanion sender:companionMatches.lastObject];
}

// NOTE: This should be variable depending upon what the cell needs based on its constraints
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (IBAction)onlineSwitchChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults]
        setObject:@(self.onlineSwitch.on) forKey:kOnlineKey];

    self.onlineStatusLabel.text = self.onlineSwitch.on ? @"online" : @"offline";

    [self reloadData];
}

- (void)companionTableViewCell:(nonnull CompanionTableViewCell *)companionTableViewCell
                   imageLoaded:(nonnull NSData *)imageData {

    dispatch_async(dispatch_get_main_queue(), ^{
        self.companions[companionTableViewCell.tag].cachedImage = imageData;
        [self cacheData];
    });
}

@end
