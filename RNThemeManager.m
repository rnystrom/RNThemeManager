//
//  RNThemeManager.m
//  DT Kit
//
//  Created by Ryan Nystrom on 12/2/12.
//  Copyright (c) 2012 Ryan Nystrom. All rights reserved.
//

#import "RNThemeManager.h"
#import "UIColor+HexString.h"

NSString * const RNThemeManagerDidChangeThemes = @"RNThemeManagerDidChangeThemes";

@interface RNThemeManager ()

@property (nonatomic, strong, readwrite) NSDictionary *styles;
@property (nonatomic, strong, readwrite) NSString *currentThemeName;

@end

@implementation RNThemeManager

#pragma mark - Singleton

+ (RNThemeManager *)sharedManager {
    static RNThemeManager *_sharedTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTheme = [[self alloc] init];
    });
    
    return _sharedTheme;
}

- (id)init {
    if (self = [super init]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *themeName = [defaults objectForKey:@"com.whoisryannystrom.RNThemeManager.defaulttheme"];
        if (! themeName) {
            themeName = @"default";
        }
        
        _currentThemeName = themeName;
        NSString *path = [[NSBundle mainBundle] pathForResource:_currentThemeName ofType:@"plist"];
        _styles = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return self;
}

#pragma mark - Setters

- (void)setStyles:(NSDictionary *)styles {
    _styles = styles;
    [[NSNotificationCenter defaultCenter] postNotificationName:RNThemeManagerDidChangeThemes object:nil];
}

#pragma mark - Actions

- (void)changeTheme:(NSString *)themeName {
    self.currentThemeName = themeName;
    NSString *path = [[NSBundle mainBundle] pathForResource:self.currentThemeName ofType:@"plist"];
    self.styles = [NSDictionary dictionaryWithContentsOfFile:path];
}

#pragma mark - Constants

#pragma mark - Fonts

- (UIFont *)fontForKey:(NSString*)key {
    NSString *sizeKey = [key stringByAppendingString:@"Size"];
    return [UIFont fontWithName:self.styles[key] size:((NSNumber *)self.styles[sizeKey]).floatValue];
}

#pragma mark - Colors

- (UIColor *)colorForKey:(NSString *)key {
    return [UIColor colorWithHexString:self.styles[key]];
}

#pragma mark - Images

- (UIImage *)imageForKey:(NSString *)key {
    return [UIImage imageNamed:self.styles[key]];
}

@end
