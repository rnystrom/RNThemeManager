RNThemeManager
=====

This small utility makes theming your iOS apps clean and simple. It was originally created so that I could have themable NIBs that utilized notifications to update view properties such as fonts and colors. I pushed beyond NIB support so that however you create your views, it will respond to your themes.

I also wanted to create a library that could be used by people that aren't app developers, i.e. designers. As long as someone has Xcode installed, they can easily make edits to your theme Plists without slowing down the development process.

## Installation

#### Cocoapods

The preferred method of installation is with [Cocoapods](http://cocoapods.org). The latest version is 0.1.0.

If you do not wish to use Cocoapods (and you really should), you can manually install RNThemeManager by just dragging and dropping all of the source files into your project. There are no framework dependencies.

## Setup

The only required setup is that you create a Plist file named <code>default.plist</code>. The root of this file should be a dictionary. Each key represents the name of an attribute. Values should be either the name of a font, the size of a font, or a hex color code.

## Fonts

View a list, and examples, of fonts included with iOS 6 [here](http://iosfonts.com).

You can include custom fonts in your project and use them in your themes just as you would with a system font. For instructions on importing custom fonts see this [Stackoverflow answer](http://stackoverflow.com/a/2616101/940936).

#### Font Sizes

RNThemeManager automatically builds your font and size based on the keyword for the font. Each font name must be accompanied by a font size key that is the **font name suffixed with "Size"**. For example:

``` objective-c
headerFont : ArialRoundedMTBold
headerFontSize : 24
```

Then when assigning a font key to a label (or any other view with text), the size will be automatically assigned.

``` objective-c
- (UIFont *)fontForKey:(NSString*)key;
```

## Colors

Colors are fairly simple. Just use a hexidecimal color code for the key value. There is no need to prefix with <code>#</code>.

``` objective-c
- (UIImage *)imageForKey:(NSString *)key;
```

## Images

Just like <code>[UIImage imageNamed:@"name"]</code>, simply assign the image name of your asset as the value for an image key.

``` objective-c
- (UIImage *)imageForKey:(NSString *)key;
```

## Inheriting theme values

If you would like to use a single value as multiple keys you may, just set the value of a key to another key.

```
headerFont : Helvetica
headerFontSize : 20
backgroundColor : ffffff
redColor : d81417
headerColor : backgroundColor
headerButtonColor : headerColor
cellHeaderFontSize : headerFontSize
buttonBackgroundColor : redColor
// etc
```

## Theming with NIBs

There are three steps to applying themes within NIBs. All of this is done in the Identity Inspector (⌥ ⌘ 3).

1. Class a view as a respective <code>RNTheme*</code> subclass. You can subclass any of the <code>RNTheme*</code> classes as well.
2. Setup keyPath keys that match the <code>RNTheme*</code> subclass.
3. Set the values to said keyPaths to the keys you defined in your theme plists.

Sorry if that's a little confusing. Here are some pictures.

#### default.plist

<img src="https://raw.github.com/rnystrom/RNThemeManager/master/images/plist.png" />

#### RNThemeButton.h

``` objective-c
@interface RNThemeButton : UIButton
<RNThemeUpdateProtocol>

// available theme keys
@property (nonatomic, strong) NSString *backgroundImageKey;
@property (nonatomic, strong) NSString *backgroundColorKey;
@property (nonatomic, strong) NSString *fontKey;
@property (nonatomic, strong) NSString *textColorKey;
@property (nonatomic, strong) NSString *highlightedTextColorKey;

@end
```

#### MainStoryboard.storyboard

<img src="https://raw.github.com/rnystrom/RNThemeManager/master/images/keypaths.png" />

## Theming with Code

``` objective-c
// optional: conform your View or ViewController to provided protocol
@interface MYViewController : UIViewController
<RNThemeUpdateProtocol>

// in -viewDidLoad (remember to removeObserver in -dealloc)
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(applyTheme)
                                             name:RNThemeManagerDidChangeThemes
                                           object:nil];
                                               
// in -viewWillAppear (or where you do your layout bits)
[self applyTheme];

- (void)applyTheme {
    // these objects do _not_ need to be RNTheme* classes/subclasses
    self.view.backgroundColor = [[RNThemeManager sharedManager] colorForKey:@"backgroundColor"];
    self.textField.font = [[RNThemeManager sharedManager] fontForKey:@"textFieldFont"];

    // example of custom theming
    self.textField.layer.cornerRadius = [RNThemeManager sharedManager].styles[@"cornerRadius"].floatValue;
}
```

Now whenever your theme file is changed the ViewController will automatically restyle your views based on your theme's setup.

## Using Multiple Themes

To change the active theme, just call the following method:

``` objective-c
[[RNThemeManager sharedManager] changeTheme:@"lowcontrast"];
```

Just make sure you have a plist with whatever theme name you provide.

## Updating Views

All <code>RNTheme*</code> subclasses subscribe to notifications when a theme is changed and conform to a custom protocol (that only exists for semantics) called <code>RNThemeUpdateProtocol</code>.

If you wish not to use any of the <code>RNTheme*</code> views (and you certainly do not need to), you can update your views or even view controllers by listening for the following notification:

``` objective-c
RNThemeManagerDidChangeThemes
```

See the above example of [Theming With Code](https://github.com/rnystrom/RNThemeManager#theming-with-code) for how to implement.

## Contact

* [@nystrorm](https://twitter.com/_ryannystrom) on Twitter
* [@rnystrom](https://github.com/rnystrom) on Github
* <a href="mailTo:rnystrom@whoisryannystrom.com">rnystrom [at] whoisryannystrom [dot] com</a>

## License

RNThemeManager is a work from Ryan Nystrom under the MIT license. See the [license doc](https://github.com/rnystrom/RNThemeManager/blob/master/LICENSE) for details.
