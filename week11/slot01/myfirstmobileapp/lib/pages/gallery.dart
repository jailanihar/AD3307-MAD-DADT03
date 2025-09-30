import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    _loadImages();
  }

  Future<void> _loadImages() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) return;
    DocumentSnapshot<Map<String, dynamic>> userDoc =
      await FirebaseFirestore.instance.collection('users')
        .doc(user.uid).get();
    if(userDoc.exists) {
      setState(() {
        _imageIds = userDoc.data()!['gallery'] ?? [];
      });
    }
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
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) return;
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
      DocumentReference userDoc = 
        FirebaseFirestore.instance.collection('users')
        .doc(user.uid);

      userDoc.update({
        'gallery': FieldValue.arrayUnion([result.$id]),
      });

      setState(() {
        _imageIds.add(result.$id);
        _imageBytes = null;
        _imagePath = null;
      });
    }
  }

  Future<void> deleteImage(String imageId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) return;
    await appWriteStorage.deleteFile(
      bucketId: AppwriteOptions.bucketId,
      fileId: imageId,
    );
    DocumentReference userDoc =
      FirebaseFirestore.instance.collection('users')
      .doc(user.uid);
    userDoc.update({
      'gallery': FieldValue.arrayRemove([imageId]),
    });

    setState(() {
      _imageIds.remove(imageId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title: 'Gallery',
      appBar: AppBar(title: const Text('Gallery')),
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
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _imageIds.length,
              itemBuilder: (context, index) => FutureBuilder(
                future: appWriteStorage.getFileDownload(
                  bucketId: AppwriteOptions.bucketId,
                  fileId: _imageIds[index] as String,
                ),
                builder: (context, snapshot) {
                  if(snapshot.hasData && snapshot.data != null) {
                    return Stack(
                      children: [
                        Image.memory(
                          snapshot.data as Uint8List,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => 
                              deleteImage(_imageIds[index] as String),
                          ),
                        ),
                      ]
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
            ),
          ),
        ]
      ),
    );
  }
}