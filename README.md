# translate

A local Flutter plugin that opens native translation UI for selected text.

## API

```dart
await Translate.translateText('Dat is goed.');
```

## Platforms

- iOS uses Apple's Translation framework and presents the system translation overlay with `.translationPresentation(isPresented:text:)`.
- Android currently opens the native share sheet with the selected text so Google Translate or another installed app can handle it.

Apple Translation must be tested on a real device.
