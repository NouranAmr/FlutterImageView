import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:mytestingflutter/response/Categories.dart';
import 'package:mytestingflutter/utils/Constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'CarColour.dart';
import '../Request/GetCategoryRequest.dart';
import '../blocs/carBloc.dart';
import '../image360/image360.dart';

Directory appDocsDir;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  appDocsDir = await getApplicationDocumentsDirectory();
  runApp(MyApp());
}

File fileFromDocsDir(String filename) {
  String pathName = p.join(appDocsDir.path, filename);
  return File(pathName);
}

final key = new GlobalKey<DemoPageState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ImageView360 Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemoPage( key: key,title: 'ImageView360 Demo'),
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
  List<String> carColors360 = List<String>();
  int imageSum = 0;
  String carModelID;
  List<FileImage> fileImageList = List<FileImage>();
  List<String> carImages = List<String>();
  bool autoRotate = true;
  int rotationCount = 1;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  Rotation_Direction rotationDirection = Rotation_Direction.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 30);
  bool imagePreCached = false;
  String fileName;
  int imageIndex = 0;

  void setCarState() {
    if (mounted) {
      print("mounted");
      print("file array = ${fileImageList.length}");
      setState(() {
        imagePreCached = true;
      });
    }
  }

  @override
  void initState() {
    int carNumber = 0;
    super.initState();
    Categories brandModel = Categories();
    Future<Categories> carModel = getCategory(18, 1);
    carModel.then((value) {
      brandModel = value;
      for (var category in brandModel.categories) {
        carModelID = category.id;
        for (var carMakeImage360 in category.carMakeImage360) {
          fileName = "Mod${category.id}";
          if (carMakeImage360.type == 2) {
            carColors360.add(carMakeImage360.colorhex);
            fileName += "_Col${carMakeImage360.colorhex.substring(1)}";
            imageSum += carMakeImage360.items.length;
            for (int i = 0; i < carMakeImage360.items.length; i++) {
              downloadFile(carMakeImage360.items[i], "${fileName}_${i + 1}.jpg")
                  .then((value) {
                carNumber++;
                if (carNumber == imageSum) {
                  initView();
                }
              });
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CarBloc carBloc = CarBloc();
    return BlocListener(
      bloc: carBloc,
      listener: (context, state) {},
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: (imagePreCached == true)
              ? CarColour(
                  key: UniqueKey(),
                  fileImageList: fileImageList,
                  carModelID: carModelID,
                  autoRotate: autoRotate,
                  allowSwipeToRotate: allowSwipeToRotate,
                  frameChangeDuration: frameChangeDuration,
                  rotationCount: rotationCount,
                  rotationDirection: rotationDirection,
                  swipeSensitivity: swipeSensitivity,
                  index: imageIndex,
                  carColor360List: carColors360,
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 100.0, left: 170.0),
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  )
                )
          ),
    );
  }

  Future<void> initView() async {
    Future<bool> result = downloadImage(
        "$BASE_URL/Content/Images/CarMake/Image360/exterior/$carModelID/FFFFFF/",
        "Mod${carModelID}_ColFFFFFF",
        imageIndex);
  }

  Future<void> updateImageList(String fileName) async {
    for (int i = 1; i <= 36; i++) {
      await readImageFile("${fileName}_$i.jpg");
    }
    setCarState();
  }

  Future<bool> downloadImage(String url, String fileName, int index) async {
    setState(() {
      imageIndex = index;
      imagePreCached = false;
      fileImageList.clear();
    });
    try {
      for (int i = 1; i <= 36; i++) {
        await downloadFile("$url$i.jpg", "${fileName}_$i.jpg");
      }
      await updateImageList(fileName);
      return Future.value(true);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }

  Future<void> downloadFile(String url, String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = '$dir/$filename';
    try {
      if (File(path).existsSync()) {
        print("file location exist ");
      } else if (File(path).existsSync() == false) {
        File file = new File(path);
        print("file location not exist is");
        print("file is $file");
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
      File file = File(path);
      await fileImageList.add(FileImage(file));
    } catch (e) {
      print("exception file is ${e.toString()}");
      return null;
    }
  }
}
