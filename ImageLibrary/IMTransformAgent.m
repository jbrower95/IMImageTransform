//
//  IMTransformAgent.m
//  ImageLibrary
//
//  Created by Justin Brower on 10/23/13.
//  Copyright (c) 2013 Justin Brower. All rights reserved.
//

#import "IMTransformAgent.h"

@implementation IMTransformAgent

+ (void)applyMoodBlurToPixels:(unsigned char *)pixels noiseRed:(float)value green:(float)value_2 blue:(float)value_3 pictureWidth:(int)width height:(int)height;
{
    float noise_r = value;
    float noise_g = value_2;
    float noise_b = value_3;
    
    unsigned char *rawData = pixels;
    for ( int i = 0; i < width*height*4;i+=4)
    {
        rawData[i] = (float)((float)(rand()%255)*noise_r + (1.0-noise_r)*(float)rawData[i]);
        rawData[i+1] = (float) ((float)(rand()%255)*noise_g + (1.0-noise_g)*(float)rawData[i+1]);
        rawData[i+2] = (float)((rand()%255)*noise_b + (1.0-noise_b)*(float)rawData[i+2] )   ;
    }
    
    
}

//filters an RGB color over the image
+ (void)applyRGBFilterToPixels:(unsigned char *)pixels red:(float)redOfOne green:(float)greenOfOne blue:(float)blueOfOne amount:(float)outOfOne width:(int)width height:(int)height
{
    unsigned char *rawData = pixels;
    
    for ( int i = 0; i < width*height*4;i+=4){
        
        int a,b,c;
        a = rawData[i];
        b = rawData[i+1];
        c = rawData[i+2];
        
        rawData[i] = (rawData[i] + rawData[i]*redOfOne) / 2.0;
        rawData[i+1] = (rawData[i+1] + rawData[i+1]*greenOfOne) / 2.0;
        rawData[i+2] = (rawData[i+2] + rawData[i+2]*blueOfOne) / 2.0;
        
        if ( rawData[i]   > 255) rawData[i] = 255;
        if ( rawData[i]   < 0)   rawData[i] = 0;
        if ( rawData[i+1] > 255) rawData[i+1] = 255;
        if ( rawData[i+1] < 0)   rawData[i+1] = 0;
        if ( rawData[i+2] > 255) rawData[i+2] = 255;
        if ( rawData[i+2] < 0)   rawData[i+2] = 0;
    }
}


+ (void)applyGrayscaleToPixels:(unsigned char *)pixels grayScaleAmount:(float)outOfOne pictureWidth:(int)width height:(int)height
{
    unsigned char *rawData = pixels;
    
    for ( int i = 0; i < width*height*4;i+=4){
        
        int a,b,c;
        a = rawData[i];
        b = rawData[i+1];
        c = rawData[i+2];
    
        float gScale = (a + b + c) / 3;
        float gFactor = outOfOne;
        rawData[i] = gScale*gFactor + (float)rawData[i]*(1-gFactor);
        rawData[i+1] = gScale*gFactor + (float)rawData[i+1]*(1-gFactor);
        rawData[i+2] = gScale*gFactor + (float)rawData[i+2]*(1-gFactor);
    
    
        if ( rawData[i]   > 255) rawData[i] = 255;
        if ( rawData[i]   < 0)   rawData[i] = 0;
        if ( rawData[i+1] > 255) rawData[i+1] = 255;
        if ( rawData[i+1] < 0)   rawData[i+1] = 0;
        if ( rawData[i+2] > 255) rawData[i+2] = 255;
        if ( rawData[i+2] < 0)   rawData[i+2] = 0;
    }

}


+ (unsigned char *)getPixelsfromImage:(UIImage *)originalImage
{
    //returns (a pointer to) the C-style pixels array from an image
    
    CGImageRef imageRef = originalImage.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    return rawData;
    
}

+ (UIImage *)reformPictureFromBytes:(unsigned char*)rawData original:(UIImage *)originalImage{
    int height = [originalImage size].height;
    int width = [originalImage size].width;
    
    CGContextRef ctx = CGBitmapContextCreate(rawData, width, height, 8, CGImageGetBytesPerRow(originalImage.CGImage), CGImageGetColorSpace(originalImage.CGImage), kCGImageAlphaPremultipliedLast);
    CGImageRef output = CGBitmapContextCreateImage(ctx);
    UIImage* newImage = [UIImage imageWithCGImage:output];
    CGContextRelease(ctx);
    return newImage;
}





@end
