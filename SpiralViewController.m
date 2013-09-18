//
//  SpiralViewController.m
//  ScrollViewDemo
//
//  Created by dteng on 9/17/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "SpiralViewController.h"
#import "PhotoCell.h"
#import "SpiralLayout.h"

@interface SpiralViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (readwrite, nonatomic, strong) NSMutableArray *imagePathArray;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@end

@implementation SpiralViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imagePathArray = [self loadImageAssetsPathArray];
    
    //Turn on to see Layout ... defaults to FlowLayout
    //[self setLayoutToSpiralLayout];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.collectionView reloadData];
}

-(void) setLayoutToSpiralLayout
{
    SpiralLayout *spiralLayout = [[SpiralLayout alloc] init];
    
    self.collectionView.collectionViewLayout = spiralLayout;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSMutableArray *)loadImageAssetsPathArray
{
    NSMutableArray *imageAssetPathArray = [[NSMutableArray alloc] init];
    //Magical #13 because we have 12 images. Needs to be refactored
    for (int i = 1; i < 13; i++) {
        NSString *imageString;
        if (i < 10) //Needs refactoring
        {
            imageString = [NSString stringWithFormat:@"01-0%i.jpg",i];
        } else
        {
            imageString = [NSString stringWithFormat:@"01-%i.jpg", i];
        }
        [imageAssetPathArray addObject:imageString];
    }
    return imageAssetPathArray;
}

#pragma mark - UICollectionView Datasource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.imagePathArray count];
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath  *)indexPath {
    PhotoCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"SpiralCell" forIndexPath:indexPath];
    
    //CGSize goldenMeanSize = [self retrieveProperGoldenMeanSizeForItemAtIndexPath:indexPath];
    
    UIImage *photo = [UIImage imageNamed:[self.imagePathArray objectAtIndex:[indexPath row]]];
        
    [cell setPhoto:photo];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath  *)indexPath
{
    NSLog(@"Hello");
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath  *)indexPath {
    NSLog(@"Hello");

}

// size of cell. 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath  *)indexPath
{
    return [self retrieveProperGoldenMeanSizeForItemAtIndexPath:indexPath];
}

//GOLDEN MEAN EQUATION APPLIED. Should be cascaded back to Layouts class.
- (CGSize)retrieveProperGoldenMeanSizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval = CGSizeMake(601.9651, 432.6238);
    
    float PHI = 1.618034;
    
    for (int i = 0; i < (int)[indexPath row]; i++) {
        retval.height /= PHI;
        retval.width /= PHI;
    }
    
    return retval;
}

// edges of cell
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(25, 25, 25, 25);
    
}

@end
