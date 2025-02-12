# Image Cropper デモアプリ

## Image Cropperとは
Image Cropperは、Flutterアプリケーションで画像のトリミング機能を実装するための強力なプラグインです。
ネイティブの画像編集機能を活用し、高品質な画像トリミング体験を提供します。

### 主な特徴
- 🎯 直感的なUIでの画像トリミング
- 🔄 回転・反転機能
- 📐 アスペクト比の固定オプション
- 🎨 カスタマイズ可能なUIテーマ
- 💪 Android/iOS両プラットフォームでのネイティブ実装

## セットアップ方法

### 1. 依存関係の追加
`pubspec.yaml`に以下を追加します：

```yaml
dependencies:
  extended_image: ^8.2.0
  image_cropper: ^5.0.1
  image_picker: ^1.0.7
```

### 2. プラットフォーム固有の設定

#### iOS
`ios/Runner/Info.plist`に以下の権限を追加：

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>写真を選択してトリミングするために許可が必要です。</string>
<key>NSCameraUsageDescription</key>
<string>写真を撮影してトリミングするために許可が必要です。</string>
```

#### Android
Android 10以上で動作させるには、`android/app/src/main/AndroidManifest.xml`に以下を追加：

```xml
<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
```

## 基本的な使い方

```dart
// Image Cropperを使用した画像トリミングの基本実装
Future<void> cropImage(String sourcePath) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: sourcePath,
    aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: '画像をトリミング',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
      ),
      IOSUiSettings(
        title: '画像をトリミング',
      ),
    ],
  );
  
  if (croppedFile != null) {
    // トリミングされた画像の処理
  }
}
```

## カスタマイズオプション

### トリミング設定のカスタマイズ
- アスペクト比の指定
- 最大出力サイズの設定
- 圧縮品質の調整
- 回転の有効/無効
- トリミング形状（円形/長方形）

### UIのカスタマイズ
- ツールバーの色
- 背景色
- アクティブなコントロールの色
- ステータスバーの色

## ベストプラクティス
1. 画像の選択には`image_picker`プラグインと組み合わせて使用
2. 大きな画像を扱う場合は`maxWidth`と`maxHeight`を指定
3. 用途に応じた適切なアスペクト比の設定
4. エラーハンドリングの実装

## 注意点
- 処理中の適切なローディング表示
- メモリ使用量の考慮
- 権限の適切な処理
- 画像サイズの最適化

## まとめ
Image Cropperは、Flutterアプリケーションで必要な画像トリミング機能を簡単に実装できる優れたソリューションです。
ネイティブの実装により、高いパフォーマンスと使いやすさを両立しています。

