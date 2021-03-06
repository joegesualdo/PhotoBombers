//
//  PhotoCell.m
//  PhotoBombers
//
//  Created by Joe Gesualdo on 9/15/14.
//  Copyright (c) 2014 joegesualdo. All rights reserved.
//

#import "PhotoCell.h"
#import <SAMCache/SAMCache.h>

@implementation PhotoCell

//override our setPhoto. This gets called anytime someone writes "cell.photo = ..."
-(void)setPhoto:(NSDictionary *)photo
{
    _photo = photo;
    NSURL *url = [[NSURL alloc]initWithString:_photo[@"images"][@"thumbnail"][@"url"]];
                  
    [self downloadPhotoWithURL:url];
}

// This is the initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // now when the photo cell initializes we will set the imageView property
        self.imageView = [[UIImageView alloc] init];
        
        //define a tap gesture recognizer
        // set's target of tap to the cell
        // when it's tap, it will trigger the like method
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(like)];
        // it will say that this gesture recognizer is only triggered when you do 2 taps
        tap.numberOfTapsRequired = 2;
        // No wo add the tap gesture recognizer we created to this view
        [self addGestureRecognizer:tap];
        
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
    // we create a key by getting the instagram id fro the photo and appending 'thumbnail' to the end of it;
    NSString *key = [[NSString alloc]initWithFormat:@"%@-thumbnail", self.photo[@"id"] ];
    // Check the cache if the photo is already there. if it is we will return it from the cache instead of making a call to the network
    UIImage *photo = [[SAMCache sharedCache] imageForKey:key];
    
    // if you already have a cache of the photo, set the photo on the cell then return
    if (photo) {
        self.imageView.image = photo;
        return;
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc]initWithContentsOfURL:location];
        
        UIImage *image = [[UIImage alloc]initWithData:data];
        
        // When you get the image, set that image to the cache with a key
        [[SAMCache sharedCache]setImage:image forKey:key];
        
        // This dispactches asycronously so we dont block this background que. And we are going to dispatch to the main que
        // If we wouln't have wrapped this code in this, the method wouldn't call properly because the ui isn't meant to be called from the background. This runs the code in the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
    [task resume];
    
}

-(void)like{
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/media/%@/likes?access_token=%@", self.photo[@"id"], accessToken];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    // Since we need to change our request from the default GET, we need to create a mutable request:
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    // We set the HTTPMethod property on request to POST
    request.HTTPMethod = @"POST";
    // Instead of using NSURLSessionDownloadTask we use NSURLSessionDataTask to download data, becuuse is doesn't save a file to disk. We use this since we only need the variable here 'task'
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // showLikeCompletion will happen on the main thread (since it's UI) and it will happen after the like completes
            [self showLikeCompletion];
        });
    }];
    [task resume];
    
}

-(void)showLikeCompletion{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Liked!" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
    
    // create a variable to hold how many seconds we want our alert to stay on screen
    double delayInSeconds = 1.0;
    // dispatch_after schedules events into a que. So it will put something into a que at a sepcific time.
    // In our case, we are putting 'dismiss' alert in the que after 1 second
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissWithClickedButtonIndex:0 animated:YES];
    });
}

@end
