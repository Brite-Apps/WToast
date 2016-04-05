WToast is a simple info box for iOS inspired by Android Toast.

## Requirements

iOS 8.0 and higher.

## Features

- Show toast object with custom text
- Show toast object with custom image

## Usage

### Show toast with text

```objective-c
[WToast showWithText:@"This is a short test."];
[WToast showWithText:@"This is a long test." duration:kWTLong];
[WToast showWithText:@"This is a long test." duration:kWTLong roundedCorners:YES];
[WToast showWithText:@"This is a long test." duration:kWTLong roundedCorners:YES gravity:kWTGravityMiddle];
```

### Show toast with image

```objective-c
[WToast showWithImage:[UIImage imageNamed:@"toast-image"]];
[WToast showWithImage:[UIImage imageNamed:@"toast-image"] duration:10];
[WToast showWithImage:[UIImage imageNamed:@"toast-image"] duration:12 roundedCorners:NO];
[WToast showWithImage:[UIImage imageNamed:@"toast-image"] duration:12 roundedCorners:NO gravity:kWTGravityTop];
```

## Demo

<a href="http://www.youtube.com/watch?feature=player_embedded&v=clTe6-MGqVQ" target="_blank"><img src="http://img.youtube.com/vi/clTe6-MGqVQ/0.jpg" alt="WToast demo" width="240" height="180" border="10" /></a>

## License

This tiny library is public domain. If you like you can mention Brite Apps for it.
