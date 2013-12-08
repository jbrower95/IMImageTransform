//
//  JBTransformAgent.h
//  ImageLibrary
//
//  Created by Justin Brower on 10/23/13.
//  Copyright (c) 2013 Justin Brower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface IMTransformAgent : NSObject

/* applyMoodBlurToPixels
 *      I/P: value:[0,1] value_2:[0,1] value_3:[0,1] pictureWidth:(int) height:(int)
 *      O/P: Mutates the inputted pixels array
 */
+ (void)applyMoodBlurToPixels:(unsigned char *)pixels noiseRed:(float)value green:(float)value_2 blue:(float)value_3 pictureWidth:(int)width height:(int)height;


// applyMoodBlurToPixels
/*
 *      I/P: value:[0,1] value_2:[0,1] value_3:[0,1] pictureWidth:(int) height:(int)
 *      O/P: Mutates the inputted pixels array
 */
+ (void)applyGrayscaleToPixels:(unsigned char *)pixels grayScaleAmount:(float)outOfOne pictureWidth:(int)width height:(int)height;


// returns a pointer to the RGBA structure containing pixels for an image
// if you call this method, you must free() the resulting array eventually, as it is malloc'd.
+ (unsigned char *)getPixelsfromImage:(UIImage *)originalImage;


// returns a UIImage reconstructed from the raw bytes that have been mutated by other methods
+ (UIImage *)reformPictureFromBytes:(unsigned char*)rawData original:(UIImage *)originalImage;

// Applys an RGB filter over the image, with a given percentage
+ (void)applyRGBFilterToPixels:(unsigned char *)pixels red:(float)red green:(float)green blue:(float)blue amount:(float)outOfOne width:(int)width height:(int)height;

@end
