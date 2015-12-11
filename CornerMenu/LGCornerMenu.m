//
// Created by Livio Gamassia on 10/12/2015.
// Copyright (c) 2015 LivioGama. All rights reserved.
//

#import "LGCornerMenu.h"
#import "LGMenuView.h"
#import "LGMenuCellCollectionViewCell.h"
#import "LGMenu.h"

@interface LGCornerMenu () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) UIView *superview;
@property (strong, nonatomic) UIButton *cornerButton;
@property (nonatomic, strong) LGMenuView *menuView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation LGCornerMenu

- (instancetype)initInView:(UIView *)view
{
    self = [super init];
    if (self) {
        _superview = view;
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCornerMenu)];
        _tapGestureRecognizer.cancelsTouchesInView = NO;
        [self createButton];
    }

    return self;
}

- (void)createButton
{
    CGFloat width = 120;
    CGFloat height = width;
    CGRect superviewFrame = [UIScreen mainScreen].bounds;
    CGFloat x = CGRectGetWidth(superviewFrame) - width / 2.f;
    CGFloat y = CGRectGetHeight(superviewFrame) - width / 2.f;

    self.cornerButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    self.cornerButton.layer.cornerRadius = width / 2.f;
    self.cornerButton.backgroundColor = [UIColor colorWithRed:86.f / 256.f green:188.f / 256.f blue:138.f / 256.f alpha:1.f];

    [self.cornerButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    self.cornerButton.imageEdgeInsets = UIEdgeInsetsMake(-width / 2.5f, -width / 2.5f, 0, 0);

    [self.cornerButton addTarget:self action:@selector(showCornerMenu) forControlEvents:UIControlEventTouchUpInside];

    [self.superview addSubview:self.cornerButton];
}

- (void)showCornerMenu
{
    UIView *animatedViewForTransition = [self animatedViewForTransition];
    CGAffineTransform finalTransform = [self affineTransformForView:animatedViewForTransition];

    self.menuView.collectionView.layer.opacity = 0;
    __block CGPoint center = animatedViewForTransition.center;

    [self.menuView addSubview:animatedViewForTransition];
    [self.superview addSubview:self.menuView];

    [UIView animateWithDuration:0.4
                          delay:0
                        options:0
                     animations:^{
                         animatedViewForTransition.transform = finalTransform;
                         animatedViewForTransition.center = center;
                         animatedViewForTransition.backgroundColor = [UIColor colorWithRed:54.f / 256.f green:70.f / 256.f blue:93.f / 256.f alpha:1.f];
                     } completion:^(BOOL finished) {
                self.menuView.collectionView.layer.opacity = 1;
                self.menuView.backgroundColor = animatedViewForTransition.backgroundColor;
                [animatedViewForTransition removeFromSuperview];
                [self.superview addGestureRecognizer:self.tapGestureRecognizer];
            }];
}

- (void)hideCornerMenu
{
    UIView *animatedViewForTransition = [self animatedViewForTransition];
    CGAffineTransform finalTransform = [self affineTransformForView:animatedViewForTransition];

    [self.menuView addSubview:animatedViewForTransition];

    animatedViewForTransition.transform = finalTransform;
    animatedViewForTransition.backgroundColor = self.menuView.backgroundColor;

    self.menuView.collectionView.layer.opacity = 0;
    self.menuView.backgroundColor = [UIColor clearColor];

    [UIView animateWithDuration:0.4
                          delay:0
                        options:0
                     animations:^{
                         animatedViewForTransition.transform = CGAffineTransformIdentity;
                         animatedViewForTransition.backgroundColor = self.cornerButton.backgroundColor;
                     } completion:^(BOOL finished) {
                [animatedViewForTransition removeFromSuperview];
                [self.menuView removeFromSuperview];
                [self.superview removeGestureRecognizer:self.tapGestureRecognizer];
            }];
}

- (UIView *)animatedViewForTransition
{
    UIView *animatedViewForTransition = [[UIView alloc] initWithFrame:self.cornerButton.frame];

    animatedViewForTransition.clipsToBounds = YES;
    animatedViewForTransition.layer.cornerRadius = CGRectGetHeight(animatedViewForTransition.frame) / 2.f;
    animatedViewForTransition.backgroundColor = self.cornerButton.backgroundColor;
    animatedViewForTransition.frame = [animatedViewForTransition convertRect:animatedViewForTransition.bounds toView:self.menuView];

    return animatedViewForTransition;
}

- (CGAffineTransform)affineTransformForView:(UIView *)animatedViewForTransition
{
    CGFloat size = MAX(CGRectGetHeight(self.superview.frame), CGRectGetWidth(self.superview.frame)) * 1.2f;
    CGFloat scaleFactor = size / CGRectGetWidth(animatedViewForTransition.frame);
    return CGAffineTransformMakeScale(scaleFactor, scaleFactor);
}

- (LGMenuView *)menuView
{
    if (!_menuView) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(LGMenuView.class) bundle:nil];
        _menuView = [nib instantiateWithOwner:self options:nil][0];
        _menuView.clipsToBounds = YES;
        CGRect screen = [UIScreen mainScreen].bounds;
        _menuView.frame = CGRectMake(0, screen.size.height - screen.size.height / 5, screen.size.width, screen.size.height / 5);
        _menuView.collectionView.delegate = self;
        _menuView.collectionView.dataSource = self;
        [_menuView.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(LGMenuCellCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(LGMenuCellCollectionViewCell.class)];
    }
    return _menuView;
}

#pragma mark - UICollectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource numberOfItemsInCornerMenu:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGMenuCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(LGMenuCellCollectionViewCell.class) forIndexPath:indexPath];
    LGMenu *menu = [self.dataSource cornerMenu:self itemAtIndex:indexPath.row];
    cell.imageView.image = menu.menuPicto;
    cell.label.text = menu.menuTitle;
    return cell;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cornerMenu:didSelectMenuAtIndex:)]) {
        [self.delegate cornerMenu:self didSelectMenuAtIndex:indexPath.row];
    }
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    return CGSizeMake(self.menuView.frame.size.width / numberOfItems - 20.f, 70);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
}

@end