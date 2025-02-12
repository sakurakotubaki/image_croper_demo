import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Editor Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ImageEditorPage(),
    );
  }
}

class ImageEditorPage extends StatefulWidget {
  const ImageEditorPage({super.key});

  @override
  State<ImageEditorPage> createState() => _ImageEditorPageState();
}

class _ImageEditorPageState extends State<ImageEditorPage> {
  File? _image;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    if (_image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Edit Image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls: false,
          ),
          IOSUiSettings(
            title: 'Edit Image',
            cancelButtonTitle: 'Cancel',
            doneButtonTitle: 'Done',
            rotateClockwiseButtonHidden: false,
            hidesNavigationBar: false,
            rotateButtonsHidden: false,
            aspectRatioPickerButtonHidden: false,
            aspectRatioLockEnabled: false,
            resetAspectRatioEnabled: true,
            showCancelConfirmationDialog: true,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Editor Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null)
              Container(
                margin: const EdgeInsets.all(16),
                child: Image.file(
                  _image!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              )
            else
              const Text('Please select an image'),
            const SizedBox(height: 20),
            if (_image != null)
              ElevatedButton(
                onPressed: _cropImage,
                child: const Text('Edit Image'),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Select Image',
        child: const Icon(Icons.add_photo_alternate),
      ),
    );
  }
}
