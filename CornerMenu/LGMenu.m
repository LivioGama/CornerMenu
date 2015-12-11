//
// Created by Livio Gamassia on 11/12/2015.
// Copyright (c) 2015 LivioGama. All rights reserved.
//

#import "LGMenu.h"


@implementation LGMenu


- (id)initWithTitle:(NSString *)menuTitle andPicto:(UIImage *)menuPicto
{
    self = [super init];
    if (self) {
        _menuTitle = menuTitle;
        _menuPicto = menuPicto;
    }

    return self;
}

@end