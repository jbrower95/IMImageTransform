IMImageTransform
================

A collection of image filters implemented for iOS.

Usage:

Copy the two files -
	IMTranformAgent.h , IMTransformAgent.m
To your project's directory

Most of the methods are class methods inside of the IMTransformAgent Class.

First, get the raw data of the image as an array of unsigned chars:
	
	unsigned char *data = [IMTransformAgent getPixelsFromImage:a]
	
Then apply transforms to the data as you wish.

At the end, read back the picture:

	UIImage *output = [IMTransformAgent reformPictureFromBytes:data original:a]

