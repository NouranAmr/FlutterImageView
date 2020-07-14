import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:imageview360/imageview360.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

Directory _appDocsDir;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _appDocsDir = await getApplicationDocumentsDirectory();
  runApp(MyApp());
}

File fileFromDocsDir(String filename) {
  String pathName = p.join(_appDocsDir.path, filename);
  return File(pathName);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageView360 Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemoPage(title: 'ImageView360 Demo'),
    );
  }
}

class DemoPage extends StatefulWidget {
  DemoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List<Image> imageList = List<Image>();
  List<FileImage> fileImageList = List<FileImage>();
  bool autoRotate = true;
  int rotationCount = 2;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 50);
  bool imagePrecached = false;

  @override
  void initState() {
    //* To load images from assets after first frame build up.
    downloadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 72.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (imagePrecached == true)
                    ? ImageView360(
                  key: UniqueKey(),
                  imageList: fileImageList,
                  rotationCount: rotationCount,
                  rotationDirection: RotationDirection.anticlockwise,
                  frameChangeDuration: Duration(milliseconds: 30),
                  swipeSensitivity: swipeSensitivity,
                  allowSwipeToRotate: allowSwipeToRotate,
                  onImageIndexChanged: (currentImageIndex) {
                    print("currentImageIndex: $currentImageIndex");
                  },
                )
                    : Text("loading...."),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateImageList() async {
    for (int i = 1; i <= 36; i++) {
      await readImageFile("subaruEgypt$i.jpg");
    }
    setState(() {
      imagePrecached = true;
    });
  }

  void downloadImage() async {
    var e;
    try {
      for (int i = 1; i <= 36; i++) {
        await _downloadFile(
            "http://subaruegypt.com/wp-content/uploads/yofla360/Impreza_Dark_Blue_Pearl/images/$i.jpg",
            "subaruEgypt$i.jpg",
            i);

        /*NetworkToFileImage(
            file: fileFromDocsDir("flutter.png"),
             url:
             "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
            processError: (error) => e = error,
            debug: true);*/
      }
      updateImageList();
    } catch (e) {
      print(e);
    }
  }

  void _downloadFile(String url, String filename, int index) async {
    try {
      String dir = (await getApplicationDocumentsDirectory()).path;
      String path = '$dir/$filename';
      print("the path1 is = $path");
      print("file location is ${File(path).existsSync()}");
      if (File(path).existsSync()) {

        print("file location exist is, index = $index");

      } else if (File(path).existsSync() == false) {
        File file = new File(path);
        print("file location not exist is, index = $index");
        var req = await get(Uri.parse(url));
        var bytes = req.bodyBytes;
        await file.writeAsBytes(bytes);

      }
    } catch (e) {
      print(e.toString());
    }
  }

  void readImageFile(String filename) async {
    try {
      String dir = (await getApplicationDocumentsDirectory()).path;
      String path = '$dir/$filename';
      print("the path2 is = $path");
      File file = File(path);
      Uint8List n = await file.readAsBytes();
      print("reading bytes $n");
      // Read the file.
      fileImageList.add(FileImage(file));
      var image = Image(image: FileImage(file));
      imageList.add(image);
      print("image is = $image");
      print("the file image is ${FileImage(file)}");
    } catch (e) {
      print("ecxeption file is ${e.toString()}");
      return null;
    }
  }
}
