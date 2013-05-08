//
//  RNThemeProgressView.h
//  Pods
//
//  Created by Robert Hillary on 08/05/2013.
//
//

#import <UIKit/UIKit.h>
#import "RNThemeUpdateProtocol.h"

@interface RNThemeProgressView : UIProgressView

@property (nonatomic, strong) NSString *progressTintColorKey;
@property (nonatomic, strong) NSString *progressImageKey;
@property (nonatomic, strong) NSString *trackTintColorKey;
@property (nonatomic, strong) NSString *trackImageKey;

@end
