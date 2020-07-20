import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

import 'CircluarButton.dart';

class CarColour extends StatefulWidget {
  final List<FileImage> fileImageList;

  final bool autoRotate;

  final int rotationCount;

  final int swipeSensitivity;

  final bool allowSwipeToRotate;

  final RotationDirection rotationDirection;
  final Duration frameChangeDuration;

  @override
  _CarColourState createState() => _CarColourState();

  CarColour(
      {Key key,
      @required this.fileImageList,
      this.autoRotate,
      this.rotationDirection,
      this.allowSwipeToRotate,
      this.frameChangeDuration,
      this.rotationCount,
      this.swipeSensitivity})
      : super(key: key);
}

class _CarColourState extends State<CarColour> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ImageView360(
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
            children: <Widget>[
              CircularButton(carColor: Color(0xffC0C0C0)),
              CircularButton(carColor: Color(0xff808080)),
              CircularButton(carColor: Color(0xffFF0000)),
              CircularButton(carColor: Color(0xff00008B)),
            ],
          ),
        ),
      ],
    );
  }
}
