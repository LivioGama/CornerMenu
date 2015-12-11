//
// Created by Livio Gamassia on 11/12/2015.
// Copyright (c) 2015 LivioGama. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LGMenu : NSObject

@property (nonatomic, strong) UIImage *menuPicto;
@property (nonatomic, strong) NSString *menuTitle;

- (id)initWithTitle:(NSString *)menuTitle andPicto:(UIImage *)menuPicto;

@end