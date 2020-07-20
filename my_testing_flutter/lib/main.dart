import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:imageview360/imageview360.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'CarColour.dart';
import 'blocs/carBloc.dart';
import 'blocs/car_states.dart';

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
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  List<Image> imageList = List<Image>();
  List<FileImage> fileImageList = List<FileImage>();
  bool autoRotate = true;
  int rotationCount = 1;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 50);
  bool imagePrecached = false;

  @override
  void initState() {
    //* To load images from assets after first frame build up.
    print("init called");
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  downloadImage();});

  }

  @override
  Widget build(BuildContext context) {
    CarBloc carBloc = CarBloc();
    return BlocListener(
      bloc: carBloc,
      listener: (context, state) {
        if (state is OnPressedState) {
          print("OnPressedState clicked");
          downloadImage();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 72.0),
              child: (imagePrecached == true)
                  ? CarColour(
                key: UniqueKey(),
                fileImageList: fileImageList,
                autoRotate: autoRotate,
                allowSwipeToRotate: allowSwipeToRotate,
                frameChangeDuration: frameChangeDuration,
                rotationCount: rotationCount,
                rotationDirection: rotationDirection,
                swipeSensitivity: swipeSensitivity,
              )
                  : Text("loading...."),
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
    print("downloadImage function pressed");
    var e;
    try {
      for (int i = 1; i <= 36; i++) {
        await _downloadFile(
            "http://subaruegypt.com/wp-content/uploads/yofla360/Impreza_Dark_Blue_Pearl/images/$i.jpg",
            "subaruEgypt$i.jpg",
            i);
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
      // print("the path1 is = $path");
      // print("file location is ${File(path).existsSync()}");
      if (File(path).existsSync()) {
        //print("file location exist is, index = $index");
      } else if (File(path).existsSync() == false) {
        File file = new File(path);
        // print("file location not exist is, index = $index");
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
      // print("the path2 is = $path");
      File file = File(path);
      Uint8List n = await file.readAsBytes();
      //print("reading bytes $n");
      // Read the file.
      fileImageList.add(FileImage(file));
      // print("the file image is ${FileImage(file)}");
    } catch (e) {
      print("ecxeption file is ${e.toString()}");
      return null;
    }
  }
}
