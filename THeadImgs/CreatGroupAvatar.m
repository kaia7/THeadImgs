//
//  CreatGroupAvatar.m
//  THeadImgs
//
//  Created by ITD on 2017/3/25.
//  Copyright © 2017年 ITD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreatGroupAvatar.h"
#import "UIImageView+WebCache.h"

#define DEFAULT_AVATAR_IMAGE  @"1.png"   //默认图片
static const CGFloat viewWidth = 200;

@implementation CreatGroupAvatar

+ (void)greateGroupAvatar:(NSArray *)group finished:(void (^)(NSData *groupAvatar))finished {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSInteger avatarCount = group.count > 9 ? 9 : group.count;
        CGFloat width = viewWidth / 3 * 0.85;
        CGFloat space3 = (viewWidth - width * 3) / 4;                      // 三张图时的边距（图与图之间的边距）
        CGFloat space2 = (viewWidth - width * 2 + space3) / 2;             // 两张图时的边距
        CGFloat space1 = (viewWidth - width) / 2;                          // 一张图时的边距
        CGFloat y = avatarCount > 6 ? space3 : (avatarCount > 3 ? space2 : space1);
        CGFloat x = avatarCount  % 3 == 0 ? space3 : (avatarCount % 3 == 2 ? space2 : space1);
        width = avatarCount > 4 ? width : (avatarCount > 1 ? (viewWidth - 3 * space3) / 2 : viewWidth );  // 重新计算width；

        if (avatarCount == 1) {                                          // 1,2,3,4 张图不同
            x = 0;
            y = 0;
        }
        if (avatarCount == 2) {
            x = space3;
        } else if (avatarCount == 3) {
            x = (viewWidth -width)/2;
            y = space3;
        } else if (avatarCount == 4) {
            x = space3;
            y = space3;
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
        [view setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.6]];
        __block NSInteger count = 0;               //下载图片完成的计数
        for (NSInteger i = avatarCount - 1; i >= 0; i--) {
            NSString *avatarUrl = [group objectAtIndex:i];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
            [view addSubview:imageView];
            [imageView sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_IMAGE] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                count ++ ;
                if (count == avatarCount) {     //图片全部下载完成
                    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 2.0);
                    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
                    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndPDFContext();
                    CGImageRef imageRef = image.CGImage;
                    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 0, view.frame.size.width*2, view.frame.size.height*2));
                    UIImage *ansImage = [[UIImage alloc] initWithCGImage:imageRefRect];
                    NSData *imageViewData = UIImagePNGRepresentation(ansImage);
                    CGImageRelease(imageRefRect);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (finished) {
                            finished(imageViewData);
                        }
                });
                }
                
            }];
            
         if (avatarCount == 3) {
                if (i == 2) {
                    y = width + space3*2;
                    x = space3;
                } else {
                    x += width + space3;
                }
            } else if (avatarCount == 4) {
                if (i % 2 == 0) {
                    y += width +space3;
                    x = space3;
                } else {
                    x += width +space3;
                }
            } else {
                 if (i % 3 == 0 ) {
                     y += (width + space3);
                     x = space3;
                 } else {
                     x += (width + space3);
                 }
            }
        }
    });
    
}



@end
