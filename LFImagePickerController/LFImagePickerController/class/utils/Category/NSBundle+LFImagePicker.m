//
//  NSBundle+LFImagePicker.m
//  LFImagePickerController
//
//  Created by TsanFeng Lam on 2018/3/14.
//  Copyright © 2018年 LamTsanFeng. All rights reserved.
//

#import "NSBundle+LFImagePicker.h"
#import "LFLayoutPickerController.h"

NSString *const LFImagePickerStrings = @"LFImagePickerController";

@implementation NSBundle (LFImagePicker)

+ (instancetype)lf_imagePickerBundle
{
    static NSBundle *lfImagePickerBundle = nil;
    if (lfImagePickerBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        lfImagePickerBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[LFLayoutPickerController class]] pathForResource:@"LFImagePickerController" ofType:@"bundle"]];
    }
    return lfImagePickerBundle;
}

+ (UIImage *)lf_imageNamed:(NSString *)name
{
//  [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", kBundlePath, name]]
    NSString *extension = name.pathExtension.length ? name.pathExtension : @"png";
    NSString *defaultName = [name stringByDeletingPathExtension];
    NSString *bundleName = [defaultName stringByAppendingString:@"@2x"];
//    CGFloat scale = [UIScreen mainScreen].scale;
//    if (scale == 3) {
//        bundleName = [name stringByAppendingString:@"@3x"];
//    } else {
//        bundleName = [name stringByAppendingString:@"@2x"];
//    }
    UIImage *image = [UIImage imageWithContentsOfFile:[[self lf_imagePickerBundle] pathForResource:bundleName ofType:extension]];
    if (image == nil) {
        image = [UIImage imageWithContentsOfFile:[[self lf_imagePickerBundle] pathForResource:defaultName ofType:extension]];
    }
    if (image == nil) {
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (NSString *)lf_localizedStringForKey:(NSString *)key
{
    return [self lf_localizedStringForKey:key value:nil];
}

+ (NSString *)lf_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    value = [[self lf_imagePickerBundle] localizedStringForKey:key value:value table:LFImagePickerStrings];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:LFImagePickerStrings];
}

@end
