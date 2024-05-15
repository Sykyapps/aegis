# _Aegis_

_Aegis_ is a library packages for _Athena_'s project that consist of UI components, formatters, icons, assets and others.

## Features

- **UI Components**
- **Formatters**
- **Icons**
- **Assets**
- TBA

### UI Components

### Formatters

### Icons

#### Usage

```dart
Icon(
  AegisIcons.arrow_up,
  color: AegisColors.neutral0,
),
```

### Assets

#### Add new asset

1. Store the image file in Aegis' `assets/` folder, you can group them by folder

   - *assets/example.webp* : `AegisAssets.example`
   - *assets/icons/close.webp* : `AegisAssets.icons_close`

   Don't forget to list to pubspec.yaml if you store the asset in new folder

2. Run this command on Aegis root project
    ```shell
    make build_runner
    ```

3. In Athena, update the dependencies `flutter pub get`

4. Implement the assets, check _How to use_ section below

#### How to use

1. Explicitly, by passing its path

   > Always add this line : `package: 'aegis'`
    ```dart
    Container(
      child: Image.asset(
        AegisAssets.illustrations_transaction_hourglass.  path,
        package: 'aegis',
      ),
    )
    ```

2. Use generated extension method that returns `Image` class

    ```dart
    Container(
      child: AegisAssets.illustrations_transaction_hourglass.image(
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      ),
    )
    ```
