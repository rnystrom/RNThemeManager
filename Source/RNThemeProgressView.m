//
//  RNThemeProgressView.m
//  Pods
//
//  Created by Robert Hillary on 08/05/2013.
//
//

#import "RNThemeProgressView.h"
#import "RNThemeManager.h"

@implementation RNThemeProgressView

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
    UIColor *progressTintColor = nil;
    if (self.progressTintColorKey && (progressTintColor = [[RNThemeManager sharedManager] colorForKey:self.progressTintColorKey])) {
        self.progressTintColor = progressTintColor;
    }
    UIImage *progressImage = nil;
    if (self.progressImageKey && (progressImage = [[RNThemeManager sharedManager] imageForKey:self.progressImageKey])) {
        self.progressImage = progressImage;
    }
    UIColor *trackTintColor = nil;
    if (self.trackTintColorKey && (trackTintColor = [[RNThemeManager sharedManager] colorForKey:self.trackTintColorKey])) {
        self.trackTintColor = trackTintColor;
    }
    UIImage *trackImage = nil;
    if (self.trackImageKey && (trackImage = [[RNThemeManager sharedManager] imageForKey:self.trackImageKey])) {
        self.trackImage = trackImage;
    }
}

- (void)themeDidChangeNotification:(NSNotification *)notification {
    [self applyTheme];
}

@end
