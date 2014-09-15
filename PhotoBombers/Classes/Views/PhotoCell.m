//
//  PhotoCell.m
//  PhotoBombers
//
//  Created by Joe Gesualdo on 9/15/14.
//  Copyright (c) 2014 joegesualdo. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

// This is the initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // now when the photo cell initializes we will set the imageView property
        self.imageView = [[UIImageView alloc] init];
        //set the image for imageView
        self.imageView.image = [UIImage imageNamed:@"Treehouse"];
        // content view is where all your views should go. You SHOUDNT put anything inside self or any of it's other views
        // here we add a subview in our content view and have that image view be our property imageView (so a UIImageView)
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

// UIView has a method called layoutSubviews
// We override layoutSubviews so we can customize the layout of our cell
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // This is where you customize the layout of the Cell
    
    // This sets the image view to the full bounds of our context view. Makes our image view fill the cell
    self.imageView.frame = self.contentView.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
