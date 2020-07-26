import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:mytestingflutter/response/Categories.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'CarColour.dart';
import 'Request/GetCategoryRequest.dart';
import 'blocs/carBloc.dart';
import 'blocs/car_states.dart';
import 'image360.dart';

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
      home: DemoPage(key: key, title: 'ImageView360 Demo'),
    );
  }
}

final key = new GlobalKey<DemoPageState>();

class DemoPage extends StatefulWidget {
  DemoPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  DemoPageState createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {
  List<String> carColors360 = List<String>();
  List<FileImage> fileImageList = List<FileImage>();
  List<String> carImages = List<String>();
  bool autoRotate = true;
  int rotationCount = 1;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  Rotation_Direction rotationDirection = Rotation_Direction.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 30);
  bool imagePrecached = false;

  void setCarState() {
    if (mounted) {
      print("mounted");
      print("file array = ${fileImageList.length}");
      setState(() {
        imagePrecached = true;
      });
    }
  }

  @override
  void initState() {
    //* To load images from assets after first frame build up.
    print("init called");
    super.initState();
    Categories brandModel = Categories();
    print("1");
     Future<Categories> carModel = getCategory(18, 1);
    carModel.then((value) {
      print("2");

      brandModel = value;
      for (var category in brandModel.categories) {
        for (var carMake360 in category.carMakeImage360) {
          if (carMake360.type == 2) {
            carColors360.add(carMake360.colorhex);
            for(var carImage in carMake360.items)
            {
              carImages.add(carImage);
            }
          }
        }
        print("carImages is ${carImages.length}");
      }
      print("3");
      Future<bool> result = downloadImage(
          "http://18.157.167.102:7066/Content/Images/CarMake/Image360/exterior/18/00008B/",
          "00008B-subaruEgyptExterior");
      // print("carColorCode = ${carColors360.length}");
    });

  }

  @override
  Widget build(BuildContext context) {

    CarBloc carBloc = CarBloc();
    return BlocListener(
      bloc: carBloc,
      listener: (context, state) {
        /*if (state is OnPressedState) {
          print("OnPressedState clicked");
          downloadImage();
        }*/
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
                      carColor360List: carColors360,
                    )
                  : Text("loading...."),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateImageList(String fileName) async {
    print("updateImageList called");
    for (int i = 1; i <= 36; i++) {
      await readImageFile("$fileName$i.jpg");
    }
    setCarState();
  }

  Future<bool> downloadImage(String url, String fileName) async {
    setState(() {
      imagePrecached = false;
      fileImageList.clear();
    });
    print("downloadImage function called");
    var e;
    try {
      for (int i = 1; i <= 36; i++) {
        await _downloadFile("$url$i.jpg", "$fileName$i.jpg", i);
      }
      await updateImageList(fileName);
      return Future.value(true);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }

  Future<void> _downloadFile(String url, String filename, int index) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = '$dir/$filename';
    try {
      print("the path1 is = $path");
      print("file location is ${File(path).existsSync()}");
      if (File(path).existsSync()) {
        print("file location exist is, index = $index");
      } else if (File(path).existsSync() == false) {
        File file = new File(path);
        print("file location not exist is, index = $index");
        print("url is $url");
        var req = await get(Uri.parse(url));
        var bytes = req.bodyBytes;
        await file.writeAsBytes(bytes);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> readImageFile(String filename) async {
    try {
      String dir = (await getApplicationDocumentsDirectory()).path;
      String path = '$dir/$filename';
      print("the path2 is = $path");
      File file = File(path);
      await fileImageList.add(FileImage(file));
      //print("the file image is ${FileImage(file)}");
    } catch (e) {
      print("exception file is ${e.toString()}");
      return null;
    }
  }
}
