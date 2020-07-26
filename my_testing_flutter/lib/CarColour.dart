import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CircluarButton.dart';
import 'image360.dart';

class CarColour extends StatefulWidget {
  final List<String> carColor360List;

  final List<FileImage> fileImageList;

  final bool autoRotate;

  final int rotationCount;

  final int swipeSensitivity;

  final bool allowSwipeToRotate;

  final Rotation_Direction rotationDirection;
  final Duration frameChangeDuration;

  @override
  _CarColourState createState() => _CarColourState();

  CarColour({Key key,
    @required this.fileImageList,
    this.autoRotate,
    this.rotationDirection,
    this.allowSwipeToRotate,
    this.frameChangeDuration,
    this.rotationCount,
    this.swipeSensitivity,
    this.carColor360List})
      : super(key: key);
}

class _CarColourState extends State<CarColour> {
  @override
  Widget build(BuildContext context) {
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
          onImageIndexChanged: (currentImageIndex) {
            print("currentImageIndex: $currentImageIndex");
          },
        ),

        Positioned(
          bottom: 5.0,
          child: Row(
              children: _buildRowList(widget.carColor360List)
          ),
        ),
      ],
    );
  }

  List<Widget> _buildRowList(List<String> carColors) {
    try{
      List<Widget> carList = [];
      for (var car in carColors) {
        carList.add(new CircularButton(carColor:car));
      }
      return carList;
    }
    catch(e)
    {
      print(e.toString());
      return null;

    }

  }

}
