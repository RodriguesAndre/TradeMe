//
//  UIImage+Utils.m
//  trademe
//
//  Created by Verglas@2x on 06/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (ImageFromColor)

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
