import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myfirstmobileapp/appwrite_options.dart';
import 'package:myfirstmobileapp/components/my_scaffold.dart';
import 'package:appwrite/appwrite.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Client appWriteClient;
  late Storage appWriteStorage;
  Uint8List? _imageBytes;
  String? _imagePath;
  List<dynamic> _imageIds = [];

  @override
  void initState() {
    super.initState();
    appWriteClient = Client()
      .setEndpoint(AppwriteOptions.endPoint)
      .setProject(AppwriteOptions.projectId);
    appWriteStorage = Storage(appWriteClient);
  }

  Future<void> pickImage() async {
    FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);
    if(result != null) {
      setState(() {
        _imageBytes = result.files.first.bytes;
        _imagePath = result.files.first.path;
      });
    }
  }

  Future<void> uploadImage() async {
    if(kIsWeb) {
      if(_imageBytes == null) return;
    } else {
      if(_imagePath == null) return;
    }
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final result;
    result = await appWriteStorage.createFile(
      bucketId: AppwriteOptions.bucketId,
      fileId: ID.unique(),
      file: kIsWeb ?
              InputFile.fromBytes(
                bytes: _imageBytes!,
                filename: fileName)
            : InputFile.fromPath(
                path: _imagePath!,
                filename: fileName)
    );

    if(result != null) {
      setState(() {
        _imageBytes = null;
        _imagePath = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Gallery',
      body: Column(
        children: [
          kIsWeb ?
            (_imageBytes != null ?
              Image.memory(
                _imageBytes!,
                width: 200,
                height: 200,
                fit: BoxFit.cover
              )
            : Text('No image selected (web)'))
          : (_imagePath != null ?
              Image.file(
                File(_imagePath!),
                width: 200,
                height: 200,
                fit: BoxFit.cover
              )
            : Text('No image selected (not web)')),
          ElevatedButton(
            onPressed: pickImage,
            child: Text('Pick Image'),
          ),
          ElevatedButton(
            onPressed: uploadImage,
            child: Text('Upload Image'),
          ),
        ]
      ),
    );
  }
}