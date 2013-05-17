//
//  UIColor+HexString.m
//  DT
//
//  Created by Ryan Nystrom on 2/5/13.
//
//

#import "UIColor+HexString.h"

@implementation UIColor(HexString)

+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
    
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

// Returns a UIColor by scanning the string for a hex number and passing that to +[UIColor colorWithRGBHex:]
// Skips any '#' characters that happen to be within hexString
+ (UIColor *)colorWithHexString:(NSString *)hexString
{
	NSScanner *scanner = [NSScanner scannerWithString:hexString];
    scanner.charactersToBeSkipped = [NSCharacterSet characterSetWithCharactersInString:@"#"];
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum])
        [NSException raise:@"Invalid hex string" format: @"Hex string %@ is invalid.", hexString];
    
	return [UIColor colorWithRGBHex:hexNum];
}

@end
