//
//  UIImage+ex.h
//  example
//
//  Created by 曹寿刚 on 14-5-2.
//  Copyright (c) 2014年 shoguncao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ex)

- (UIImage*)grayImageRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;

- (UIImage *)scaledToSize:(CGSize)newSize;

@end
