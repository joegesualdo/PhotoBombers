//
//  PhotosViewController.m
//  PhotoBombers
//
//  Created by Joe Gesualdo on 9/15/14.
//  Copyright (c) 2014 joegesualdo. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"

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
    
    // if we set the .title property on a view controller embedded in a navigation controller, then the .title will be placed in the navigation's title
    self.title = @"Photo Bombers";
    
    // When we call dequeReusableCellWithReuseidentifier in our cellForRowAtIndexPath, that deques a cell from the reuse que. Since we're aren't using interface builder, we are going to set this cell identifier in code.
    // for registersterClass we tell it what class to use when we ask for a cell with a certain identifier (in this cas: "photo")
    // We plass in our custom class to registerClass: PhotoCell
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photo"];
    
    // we are setting the background to white so we can tell the collection view loaded (because app normally launched with black background)
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //we need an NSURLSession, so we get the shared session
    // This is shared everywhere in your app
    NSURLSession *session = [NSURLSession sharedSession];
    // Need to make a url that we can pass to request
    NSURL *url = [[NSURL alloc]initWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
    // Make a request that we can then pass on to our task (NSURLSessionDownloadTask)
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    // make an NSURLSessionDownloadTask to download data fromt he internet
    // FYI: The data in NSURLSessionDownloadTask is downloaded for you and saved on disk; then int he completion handler you get back the location where it saved the response fromt eh netwrok
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        // So location it where on disk NSURLSessionDownloadTask saved teh response
        // FYI: we use initWithContentsOfURL and we pass it a fiel location and not a domain, that's because URL don't need to go to the internet. They can be files on your location machine
        // NSUTF8StringEcnoding is the most common. Most things will be this, you will rarely need to say anthing else
        NSString *text = [[NSString alloc]initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
        // This will print the response headers
        NSLog(@"Response: %@", response);
        // This will print the response text
        NSLog(@"Response text: %@", text);
    }];
    // We need to use the task we created. So we call the task:
    [task resume];
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
