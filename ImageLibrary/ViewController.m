//
//  ViewController.m
//  ImageLibrary
//
//  Created by Justin Brower on 10/23/13.
//  Copyright (c) 2013 Justin Brower. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView;
- (void)viewDidLoad
{
    UIImage *output = [self modifyPixels:[UIImage imageNamed:@"suburbia.png"]];
    [self.imageView setImage:output];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(UIImage*)modifyPixels:(UIImage*)originalImage
{
    
    unsigned char *rawData = [IMTransformAgent getPixelsfromImage:originalImage];
    int width = [originalImage size].width;
    int height = [originalImage size].height;
    
    [IMTransformAgent applyMoodBlurToPixels:rawData noiseRed:.2 green:.1 blue:.2 pictureWidth:width height:height];
    [IMTransformAgent applyMoodBlurToPixels:rawData noiseRed:.4 green:.3 blue:.4 pictureWidth:width height:height];
    [IMTransformAgent applyGrayscaleToPixels:rawData grayScaleAmount:1 pictureWidth:width height:height];
    [IMTransformAgent applyRGBFilterToPixels:rawData red:(255.0/255.0) green:0 blue:0 amount:1 width:width height:height];

    UIImage *a = [IMTransformAgent reformPictureFromBytes:rawData original:originalImage];
    free(rawData);
    return a;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
