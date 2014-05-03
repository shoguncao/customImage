//
//  UIImage+ex.m
//  example
//
//  Created by 曹寿刚 on 14-5-2.
//  Copyright (c) 2014年 shoguncao. All rights reserved.
//

#import "UIImage+ex.h"

@implementation UIImage (ex)

typedef enum {
    ALPHA = 0,
    BLUE = 1,
    GREEN = 2,
    RED = 3
} PIXELS;

- (UIImage*)grayImageRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue
{
	
    CGSize size = [self size];
	
	//	int _tmp = 1 ;
	//	DeviceType _type = [[MSFImagePool defaultPool] deviceVersion];
	//
	//	if(DeviceiPhone4 == _type || DeviceiPodTouch4G == _type) _tmp = 2 ;
	//
    int width = size.width ;
	int height = size.height ;
	int scale = 1;
	if (NO/*[self is2xScreen]*/) {
		scale = 2;
		width = width*scale;
		height = height*scale;
	}
	
    // the pixels will be painted to this array
    //uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
	
    // clear the pixels so any transparency is preserved
    //memset(pixels, 0, width * height * sizeof(uint32_t));
	uint32_t *pixels = (uint32_t *) calloc(width * height * sizeof(uint32_t), 1);
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
	
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);
	//  CGContextDrawImage(context, CGRectMake(0, 0, width, height), img.CGImage);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
			
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            //uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
//			uint32_t gray = ((77 * rgbaPixel[RED] + 151 * rgbaPixel[GREEN] + 28 * rgbaPixel[BLUE]) >> 8);
			
            // set the pixels to gray
            rgbaPixel[RED] = red;
            rgbaPixel[GREEN] = green;
            rgbaPixel[BLUE] = blue;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
	if (pixels) {
		free(pixels);
	}
	UIImage *resultUIImage = nil;
	if ([self respondsToSelector:@selector(scale)]) {
		resultUIImage = [UIImage imageWithCGImage:image scale:scale orientation:[self imageOrientation]];
	}else {
		resultUIImage = [UIImage imageWithCGImage:image];
	}
    
    // we're done with image now too
	if (image) {
		CGImageRelease(image);
	}
	
    return resultUIImage;
}

- (UIImage *)scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
