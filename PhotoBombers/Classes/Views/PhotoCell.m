//
//  PhotoCell.m
//  PhotoBombers
//
//  Created by Joe Gesualdo on 9/15/14.
//  Copyright (c) 2014 joegesualdo. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

//override our setPhoto. This gets called anytime someone writes "cell.photo = ..."
-(void)setPhoto:(NSDictionary *)photo
{
    _photo = photo;
    NSURL *url = [[NSURL alloc]initWithString:_photo[@"images"][@"standard_resolution"][@"url"]];
                  
    [self downloadPhotoWithURL:url];
}

// This is the initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // now when the photo cell initializes we will set the imageView property
        self.imageView = [[UIImageView alloc] init];
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

-(void)downloadPhotoWithURL: (NSURL *)url{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc]initWithContentsOfURL:location];
        
        UIImage *image = [[UIImage alloc]initWithData:data];
        // This dispactches asycronously so we dont block this background que. And we are going to dispatch to the main que
        // If we wouln't have wrapped this code in this, the method wouldn't call properly because the ui isn't meant to be called from the background. This runs the code in the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
    [task resume];
    
}
@end
