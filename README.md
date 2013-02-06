RNThemeManager
=====

*WARNING: I noticed this garnered a little attention. This is still **very much** a work in progress.**

This small utility makes theming your iOS apps clean and simple. It was originally created so that I could have themable NIBs that utilized notifications to update view properties such as fonts and colors. I pushed beyond NIB support so that however you create your views, it will respond to your themes.

I also wanted to create a library that could be used by people that aren't app developers, i.e. designers. As long as someone has Xcode installed, they can easily make edits to your theme Plists without slowing down the development process.

## Installation

The preferred method of installation is with [Cocoapods](http://cocoapods.org).

If you do not wish to use Cocoapods (and you really should), you can manually install RNThemeManager by just dragging and dropping all of the source files into your project. There are no framework dependencies.

## Setup

The only required setup is that you create a Plist file named <code>default.plist</code>. The root of this file should be a dictionary. Each key represents the name of an attribute. Values should be either the name of a font, the size of a font, or a hex color code.

## Fonts

View a list, and examples, of fonts included with iOS 6 [here](http://iosfonts.com).

You can include custom fonts in your project and use them in your themes just as you would with a system font. For instructions on importing custom fonts see this [Stackoverflow answer](http://stackoverflow.com/a/2616101/940936).

#### Font Sizes

RNThemeManager automatically builds your font and size based on the keyword for the font. Each font name should be accompanied by a font size key that is the **font name suffixed with "Size"**. For example:

``` objective-c
headerFont : ArialRoundedMTBold
headerFontSize : 24
```

Then when assigning a font key to a label (or any other view with text), the size will be automatically assigned.

## Colors

Colors are fairly simple. Just use a hexidecimal color code for the key value.

## Theming with NIBs

There are three steps to applying themes within NIBs. All of this is done in the Identity Inspector (⌥ ⌘ 3).

1. Class a view as a respective <code>RNTheme*</code> subclass. You can subclass any of the <code>RNTheme*</code> classes as well.
2. Setup keyPath keys that match the <code>RNTheme*</code> subclass.
3. Set the values to said keyPaths to the keys you defined in your theme plists.

Sorry if that's a little confusing. Here are some pictures.

#### default.plist

<img src="https://raw.github.com/rnystrom/RNThemeManager/master/images/plist.png" />

#### MainStoryboard.storyboard

<img src="https://raw.github.com/rnystrom/RNThemeManager/master/images/keypaths.png" />

## Theming with Code

## Multiple Themes

To change the active theme, just call the following method:

``` objective-c
[[RNThemeManager sharedManager] changeTheme:@"lowcontrast"];
```

All 

## Contact

* [@nystrorm](https://twitter.com/nystrorm) on Twitter
* [@rnystrom](https://github.com/rnystrom) on Github
* <a href="mailTo:rnystrom@whoisryannystrom.com">rnystrom [at] whoisryannystrom [dot] com</a>

## License

RNThemeManager is a work from Ryan Nystrom under the MIT license. See the [license doc](https://github.com/rnystrom/RNThemeManager/blob/master/LICENSE) for details.
