//
//  PhotosViewController.m
//  PhotoBombers
//
//  Created by Joe Gesualdo on 9/15/14.
//  Copyright (c) 2014 joegesualdo. All rights reserved.
//

#import "PhotosViewController.h"

@interface PhotosViewController ()

@end

@implementation PhotosViewController

// we are overriding the init method so we can setup the collection view layout type. we are goingt to set type as flow layout
// instancetype means whatever your returning form this method is the same type of the class you;re working with;
-(instancetype)init
{
    // allocate and initialize the type of layout we want, and store it in a variable to pass to the init method
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // customize look of the layout
    // set the size of each element so each items takes up 1/3 of the width. We want 3 items across
    layout.itemSize = CGSizeMake(106.0, 106.0);
    // set the minum space we want between our cell
    layout.minimumInteritemSpacing = 1.0;
    // set minimum line spaceing between our rows
    layout.minimumLineSpacing = 1.0;

    // settint the type of layout on the class
    return (self = [super initWithCollectionViewLayout:layout]);
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // When we call dequeReusableCellWithReuseidentifier in our cellForRowAtIndexPath, that deques a cell from the reuse que. Since we're aren't using interface builder, we are going to set this cell identifier in code.
    // for registersterClass we tell it what class to use when we ask for a cell with a certain identifier (in this cas: "photo")
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photo"];
    
    // we are setting the background to white so we can tell the collection view loaded (because app normally launched with black background)
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UICollectionView delegate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    // set background color of cell so you can see them on the screen
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}

@end
