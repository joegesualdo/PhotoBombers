//
//  PhotoCell.h
//  PhotoBombers
//
//  Created by Joe Gesualdo on 9/15/14.
//  Copyright (c) 2014 joegesualdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell

// UICollectionViewCell is a blank canvas,it doens't have anything. Unlike a UITableViewCell which already has an image view.
// notice we only made it 'nonatomic' and not 'nonatomic, strnog'. This is because strong is the default for object types now. So you don't have to add it.
@property(nonatomic)UIImageView *imageView;
// We will put the photo dictionary from our photos array in our view controller
@property(nonatomic,strong)NSDictionary *photo;

@end
