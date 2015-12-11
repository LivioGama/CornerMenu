//
//  LGSubViewController.m
//  CornerMenu
//
//  Created by Livio Gamassia on 11/12/2015.
//  Copyright © 2015 LivioGama. All rights reserved.
//

#import "LGSubViewController.h"

@interface LGSubViewController ()

@property (nonatomic, strong) NSString *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation LGSubViewController

- (id)initWithLabel:(NSString *)title
{
    self = [super init];
    if (self) {
        _labelTitle = title;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.label.text = self.labelTitle;
}

@end