import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytestingflutter/utils/Constants.dart';
import 'package:panorama/panorama.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'CircluarButton.dart';
import '../image360/image360.dart';
import 'main.dart';

class CarColour extends StatefulWidget {
  final List<String> carColor360List;
  final String carModelID;

  final List<FileImage> fileImageList;

  final bool autoRotate;

  final int rotationCount;

  final int swipeSensitivity;

  final bool allowSwipeToRotate;

  final Rotation_Direction rotationDirection;
  final Duration frameChangeDuration;
  final int index;

  @override
  CarColourState createState() => CarColourState();

  CarColour(
      {Key key,
      @required this.fileImageList,
      @required this.carModelID,
      this.index,
      this.autoRotate,
      this.rotationDirection,
      this.allowSwipeToRotate,
      this.frameChangeDuration,
      this.rotationCount,
      this.swipeSensitivity,
      this.carColor360List})
      : super(key: key);
}

class CarColourState extends State<CarColour> implements SelectedCar {
  int imageIndex;
  bool imageLoading = false;
  bool exteriorView = true;
  File loadedImage;

  @override
  @override
  Widget build(BuildContext context) {
    print("image loading is $imageLoading");
    return Stack(
      children: <Widget>[
        (exteriorView == true)
            ? SingleChildScrollView(child: exteriorCarView())
            : (imageLoading == false)
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  ))
                : interiorCarView(loadedImage),
        Positioned(bottom: 7.0, right: 10.0, child: toogleSwitch()),
      ],
    );
  }

  List<Widget> _buildRowList(List<String> carColors, String carModelID,
      CarColourState carColourState) {
    try {
      List<Widget> carList = [];
      for (var car in carColors) {
        carList.add(new CircularButton(
          carColor: car,
          carModelID: carModelID,
          selectedCar: carColourState,
        ));
      }
      return carList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<File> getImage(BuildContext context, String fileName) async {
    File file;
    try {
      await key.currentState.downloadFile(
          "http://18.157.167.102:7066/Content/Images/CarMake/Image360/interior/31/000000/20MY_XV_EC_LHD_Interior_01.jpg",
          fileName);
    } catch (e) {
      print('Exception in getImageFunction is $e');
    } finally {
      print('finallyClosure');
      String dir = (await getApplicationDocumentsDirectory()).path;
      String path = '$dir/$fileName';
      file = File(path);
    }
    return file;
  }

  @override
  int selectedCarIndex() {
    return imageIndex;
  }

  Widget toogleSwitch() {
    return ToggleSwitch(
      cornerRadius: 10.0,
      minWidth: 60.0,
      minHeight: 30.0,
      fontSize: 13.0,
      initialLabelIndex: 0,
      activeBgColor: Colors.black,
      activeFgColor: Colors.white,
      inactiveFgColor: Colors.white,
      inactiveBgColor: Colors.grey[600],
      labels: ['Exterior', 'Interior'],
      onToggle: (index) {
        print('switched to: $index');
        if (index == 0) {
          setState(() {
            exteriorView = true;
          });
        } else if (index == 1) {
          setState(() {
            exteriorView = false;
          });
          var carImage = getImage(context, "carEgypt");
          carImage.then((value) {
            loadedImage = value;
            print("loaded image is $loadedImage");
            setState(() {
              imageLoading = true;
            });
          });
        }
      },
    );
  }

  Widget exteriorCarView() {
    return Stack(
      children: <Widget>[
        Image360(
          key: UniqueKey(),
          imageList: widget.fileImageList,
          rotationCount: widget.rotationCount,
          autoRotate: widget.autoRotate,
          rotationDirection: widget.rotationDirection,
          frameChangeDuration: widget.frameChangeDuration,
          swipeSensitivity: widget.swipeSensitivity,
          allowSwipeToRotate: widget.allowSwipeToRotate,
          index: widget.index,
          onImageIndexChanged: (currentImageIndex) {
            print("currentImageIndex: $currentImageIndex");
            imageIndex = currentImageIndex;
          },
        ),
        Positioned(
          bottom: 5.0,
          child: Row(
              children: _buildRowList(
                  widget.carColor360List, widget.carModelID, this)),
        ),
      ],
    );
  }
  Widget interiorCarView(File loadedImage) {
    try {
      return Panorama(

          animSpeed: 0, interactive: true, child: Image.file(loadedImage));
    }
    catch (e) {
      print("interiorCarView exception  is $e");
      return null;
    }
  }
}
