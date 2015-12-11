//
// Created by Livio Gamassia on 10/12/2015.
// Copyright (c) 2015 LivioGama. All rights reserved.
//

#import "LGMainViewController.h"
#import "LGCornerMenu.h"
#import "LGMenu.h"
#import "LGSubViewController.h"

@interface LGMainViewController () <LGCornerMenuDelegate, LGCornerMenuDataSource>

@property (nonatomic, strong) LGCornerMenu *cornerMenu;
@property (nonatomic, strong) NSArray<LGMenu *> *menus;

@end

@implementation LGMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Corner Menu";

    LGMenu *menuAdvertiser, *menuAgency, *menuCampaign, *menuCreative;
    menuAdvertiser = [[LGMenu alloc] initWithTitle:@"Advertiser" andPicto:[UIImage imageNamed:@"advertiser_logo"]];
    menuAgency = [[LGMenu alloc] initWithTitle:@"Agency" andPicto:[UIImage imageNamed:@"agency_logo"]];
    menuCampaign = [[LGMenu alloc] initWithTitle:@"Campaign" andPicto:[UIImage imageNamed:@"campaign_logo"]];
    menuCreative = [[LGMenu alloc] initWithTitle:@"Creative" andPicto:[UIImage imageNamed:@"creative_logo"]];

    self.menus = @[menuAdvertiser, menuAgency, menuCampaign, menuCreative];

    self.cornerMenu = [[LGCornerMenu alloc] initInView:self.navigationController.view];
    self.cornerMenu.delegate = self;
    self.cornerMenu.dataSource = self;
}

- (NSUInteger)numberOfItemsInCornerMenu:(LGCornerMenu *)cornerMenu
{
    return self.menus.count;
}

- (LGMenu *)cornerMenu:(LGCornerMenu *)cornerMenu itemAtIndex:(NSUInteger)index
{
    return self.menus[index];
}

- (void)cornerMenu:(LGCornerMenu *)cornerMenu didSelectMenuAtIndex:(NSUInteger)index
{
    LGSubViewController *subViewController = [[LGSubViewController alloc] initWithLabel:self.menus[index].menuTitle];
    [self.navigationController pushViewController:subViewController animated:YES];
}

@end