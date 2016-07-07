//
//  UIColor+Custom.m
//  Auth0Login
//
//  Created by Weien Wang on 7/5/16.
//  Copyright © 2016 Weien Wang. All rights reserved.
//

#import "UIColor+Custom.h"

@implementation UIColor (Custom)

+ (UIColor*) grayColorDarkBackground {
    return [UIColor colorWithRed:0.13 green:0.13 blue:0.16 alpha:1.00];
}

+ (UIColor*) grayColorLightText {
    return [UIColor colorWithRed:0.82 green:0.82 blue:0.83 alpha:1.00];
}

+ (UIColor*) redColorSuccess {
    return [UIColor colorWithRed:0.92 green:0.33 blue:0.14 alpha:1.00];
}

+ (UIColor*) blueColorPrimary {
    return [UIColor colorWithRed:0.27 green:0.78 blue:0.96 alpha:1.00];
}

+ (UIColor*) blackColorText {
    return [UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:1.00];
}

// -------------

+ (UIColor*) blueColorDarkBackground {
    return [UIColor colorWithRed:0.09 green:0.13 blue:0.30 alpha:1.00];
}

+ (UIColor*) grayColorMediumBackground {
    return [UIColor colorWithRed:0.36 green:0.40 blue:0.44 alpha:1.00];
}

+ (UIColor*) orangeColorSecondary {
    return [UIColor colorWithRed:1.00 green:0.60 blue:0.34 alpha:1.00];
}

+ (UIColor*) pinkColorSecondary {
    return [UIColor colorWithRed:0.78 green:0.47 blue:0.70 alpha:1.00];
}

@end
