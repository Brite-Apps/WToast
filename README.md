WToast is a simple info box for iOS inspired by Android Toast object.

## Requirements

iOS 5.0 and higher.

## Features

- Show toast object with custom text
- Show toast object with custom image

## Usage

### Show toast with text

```objective-c
[WToast showWithText:@"This is a short test."];
[WToast showWithText:@"This is a long test." duration:kWTLong];
```

### Show toast with image

```objective-c
[WToast showWithText:[UIImage imageNamed:@"toast-image"] duration:10];
```

## Demo

<a href="http://www.youtube.com/watch?feature=player_embedded&v=clTe6-MGqVQ" target="_blank"><img src="http://img.youtube.com/vi/clTe6-MGqVQ/0.jpg" alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>

## License

This tiny library is public domain. If you like you can mention Nik Dyonin for it.