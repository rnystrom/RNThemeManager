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
        
        [self changeTheme:themeName];
    }
    return self;
}

#pragma mark - Setters

- (void)setStyles:(NSDictionary *)styles {
    BOOL isFirst = _styles == nil;
    _styles = styles;
    if (! isFirst) {
        [[NSNotificationCenter defaultCenter] postNotificationName:RNThemeManagerDidChangeThemes object:nil];
    }
}

- (void)setCurrentThemeName:(NSString *)currentThemeName {
    _currentThemeName = currentThemeName;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentThemeName forKey:@"com.whoisryannystrom.RNThemeManager.defaulttheme"];
    [defaults synchronize];
}

#pragma mark - Actions

- (void)changeTheme:(NSString *)themeName {
    if ([themeName isEqualToString:self.currentThemeName]) {
        return;
    }
    
    self.currentThemeName = themeName;
    NSString *path = [[NSBundle mainBundle] pathForResource:self.currentThemeName ofType:@"plist"];
    NSDictionary *styles = [NSDictionary dictionaryWithContentsOfFile:path];
    
    // if our theme inherits from another, merge
    if (styles[@"INHERITED_THEME"] != nil) {
        styles = [self inheritedThemeWithParentTheme:styles[@"INHERITED_THEME"] childTheme:styles];
    }
    
    self.styles = styles;
}

- (NSDictionary *)inheritedThemeWithParentTheme:(NSString *)parentThemeName childTheme:(NSDictionary *)childTheme {
    NSString *path = [[NSBundle mainBundle] pathForResource:parentThemeName ofType:@"plist"];
    NSMutableDictionary *parent = [[NSDictionary dictionaryWithContentsOfFile:path] mutableCopy];
    
    // merge child into parent overriding parent values
    [childTheme enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        parent[key] = obj;
    }];
    
    return parent;
}

#pragma mark - Constants

#pragma mark - Fonts

- (UIFont *)fontForKey:(NSString*)key {
    NSString *sizeKey = [key stringByAppendingString:@"Size"];
    return [self fontForKey:key sizeKey:sizeKey];
}

- (UIFont *)fontForKey:(NSString *)key sizeKey:(NSString *)sizeKey
{
    NSString *fontName = self.styles[key];
    
    // get the font size, using default if not supplied
    CGFloat size = [self floatForKey:sizeKey defaultValue:[UIFont systemFontSize]];
    
    while (self.styles[fontName]) {
        fontName = self.styles[fontName];
    }
    
    if (fontName) {
        return [UIFont fontWithName:fontName size:size];
    }
    return nil;
}

#pragma mark - Colors

- (UIColor *)colorForKey:(NSString *)key {
    NSString *hexString = self.styles[key];
    
    while (self.styles[hexString]) {
        hexString = self.styles[hexString];
    }
    
    if (hexString) {
        return [UIColor colorWithHexString:hexString];
    }
    return nil;
}

#pragma mark - Images

- (UIImage *)imageForKey:(NSString *)key {
    NSString *imageName = self.styles[key];
    
    while (self.styles[imageName]) {
        imageName = self.styles[imageName];
    }
    
    if (imageName) {
        return [UIImage imageNamed:imageName];
    }
    return nil;
}

#pragma mark - Number

- (int)intForKey:(NSString *)key defaultValue:(int)defaultValue
{
    NSString *num = self.styles[key];
    
    while (self.styles[num]) {
        num = self.styles[num];
    }
    
    if (num) {
        return num.intValue;
    }
    
    return defaultValue;
}

- (float)floatForKey:(NSString *)key defaultValue:(float)defaultValue
{
    NSString *num = self.styles[key];
    
    while (self.styles[num]) {
        num = self.styles[num];
    }
    
    if (num) {
        return num.floatValue;
    }
    
    return defaultValue;
}

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    NSString *num = self.styles[key];
    
    while (self.styles[num]) {
        num = self.styles[num];
    }
    
    if (num) {
        return num.boolValue;
    }
    
    return defaultValue;
}

@end
