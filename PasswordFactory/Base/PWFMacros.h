//
//  PWFMacros.h
//  PasswordFactory
//
//  Created by 徐朋 on 2017/9/7.
//  Copyright © 2017年 lilac. All rights reserved.
//

#ifndef PWFMacros_h
#define PWFMacros_h

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#endif

#define Font(x)                         [UIFont systemFontOfSize : x]
#define ItalicFont(x)                   [UIFont italicSystemFontOfSize:x]
#define BoldFont(x)                     [UIFont boldSystemFontOfSize : x]

#define RGBCOLOR(r, g, b)               [UIColor colorWithRed : (r) / 255.0f green : (g) / 255.0f blue : (b) / 255.0f alpha : 1]
#define RGBACOLOR(r, g, b, a)           [UIColor colorWithRed : (r) / 255.0f green : (g) / 255.0f blue : (b) / 255.0f alpha : (a)]

// sample: Designer - #FF0000, We - HEXCOLOR(0xFF0000)
#define HEXCOLOR(hexValue)              [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : 1.0]

#define HEXACOLOR(hexValue, alphaValue) [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : (alphaValue)]
#endif /* PWFMacros_h */
