//
//  RNThemeLabel.m
//  DT
//
//  Created by Ryan Nystrom on 2/5/13.
//
//

#import "RNThemeLabel.h"
#import "RNThemeManager.h"

@implementation RNThemeLabel

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _init];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self _init];
    }
    return self;
}

- (void)_init {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeNotification:) name:RNThemeManagerDidChangeThemes object:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self applyTheme];
}

- (void)dealloc {
    @try {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    @catch (NSException *exception) {
        // do nothing, only unregistering self from notifications
    }
}

- (void)applyTheme {
    UIFont *font = nil;
    
    if (self.fontKey) {
        // has the fontSize override been provided?
        if (self.fontSize) {
            font = [[RNThemeManager sharedManager] fontForKey:self.fontKey size:[fontSize floatValue]];
        }
        else {
            font = [[RNThemeManager sharedManager] fontForKey:self.fontKey]
        }
        
        if (font) {
            self.font = font;
        }
    }
    
    UIColor *textColor = nil;
    if (self.textColorKey && (textColor = [[RNThemeManager sharedManager] colorForKey:self.textColorKey])) {
        self.textColor = textColor;
    }
    UIColor *highlightedTextColor = nil;
    if (self.highlightedTextColorKey && (highlightedTextColor = [[RNThemeManager sharedManager] colorForKey:self.highlightedTextColorKey])) {
        self.highlightedTextColor = highlightedTextColor;
    }
    UIColor *backgroundColor = nil;
    if (self.backgroundColorKey && (backgroundColor = [[RNThemeManager sharedManager] colorForKey:self.backgroundColorKey])) {
        self.backgroundColor = backgroundColor;
    }
}

- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}

@end
