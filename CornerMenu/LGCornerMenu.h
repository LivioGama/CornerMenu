//
// Created by Livio Gamassia on 10/12/2015.
// Copyright (c) 2015 LivioGama. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGMenuView;
@class LGMenu;

@protocol LGCornerMenuDataSource;
@protocol LGCornerMenuDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface LGCornerMenu : NSObject

@property (nonatomic, weak, nullable) id <LGCornerMenuDataSource> dataSource;
@property (nonatomic, weak, nullable) id <LGCornerMenuDelegate> delegate;

- (instancetype)initInView:(UIView *)view;

- (void)showCornerMenu;

- (void)hideCornerMenu;

@end

@protocol LGCornerMenuDataSource <NSObject>

@required
- (NSUInteger)numberOfItemsInCornerMenu:(LGCornerMenu *)cornerMenu;

- (LGMenu *)cornerMenu:(LGCornerMenu *)cornerMenu itemAtIndex:(NSUInteger)index;

@end

@protocol LGCornerMenuDelegate <NSObject>

@optional
- (void)cornerMenu:(LGCornerMenu *)cornerMenu didSelectMenuAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END