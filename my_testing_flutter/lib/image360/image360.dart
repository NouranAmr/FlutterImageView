import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum Rotation_Direction { clockwise, anticlockwise }

class Image360 extends StatefulWidget {
  final List<ImageProvider> imageList;
  final bool autoRotate, allowSwipeToRotate;
  final int rotationCount, swipeSensitivity;
  final Duration frameChangeDuration;
  final Rotation_Direction rotationDirection;
  final Function(int currentImageIndex) onImageIndexChanged;
  final int index;

  Image360({
    @required Key key,
    @required this.imageList,
    this.autoRotate = false,
    this.allowSwipeToRotate = true,
    this.rotationCount = 1,
    this.swipeSensitivity = 1,
    this.rotationDirection = Rotation_Direction.clockwise,
    this.frameChangeDuration = const Duration(milliseconds: 80),
    this.index,
    this.onImageIndexChanged,
  }) : super(key: key);

  @override
  _Image360State createState() => _Image360State();
}

class _Image360State extends State<Image360> {
  int rotationIndex, sensitivity;
  int counter = 0;
  double localPosition = 0.0;
  int rotationCompleted = 0;
  Function(int currentImageIndex) onImageIndexChanged;

  @override
  void initState() {
    sensitivity = widget.swipeSensitivity;
    if (sensitivity < 1) {
      sensitivity = 1;
    } else if (sensitivity > 5) {
      sensitivity = 5;
    }
    onImageIndexChanged = widget.onImageIndexChanged ?? (currentImageIndex) {};
    rotationIndex = widget.index;
    if (widget.autoRotate) {
      rotateImage();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onHorizontalDragEnd: (details) {
            localPosition = 0.0;
          },
          onHorizontalDragUpdate: (details) {
            if (widget.allowSwipeToRotate) {
              if (details.delta.dx > 0) {
                handleRightSwipe(details);
              } else if (details.delta.dx < 0) {
                handleLeftSwipe(details);
              }
            }
          },
          child: Image(image: widget.imageList[rotationIndex]),
        ),
      ],
    );
  }

  void rotateImage() async {
    // Check for rotationCount
    if (rotationCompleted < widget.rotationCount) {
      // Frame change duration logic
      await Future.delayed(widget.frameChangeDuration);
      if (mounted) {
        setState(() {
          //print("counter is $counter");
          onImageIndexChanged(rotationIndex);
          if (counter != widget.imageList.length) {
            rotationIndex++;
            if (rotationIndex > widget.imageList.length - 1) {
              rotationIndex = 0;
            }
            counter++;
          } else {
            rotationCompleted++;
          }
        });
      }
      rotateImage();
    }
  }

  void handleRightSwipe(DragUpdateDetails details) {
    int originalIndex = rotationIndex;

    if ((localPosition +
            (pow(4, (6 - sensitivity)) / (widget.imageList.length))) <=
        details.localPosition.dx) {
      rotationIndex = rotationIndex + 1;
      localPosition = details.localPosition.dx;
    }
    if (originalIndex != rotationIndex) {
      setState(() {
        if (rotationIndex <= widget.imageList.length - 1) {
          rotationIndex = rotationIndex;
        } else {
          rotationIndex = 0;
        }
      });
      onImageIndexChanged(rotationIndex);
    }
  }

  void handleLeftSwipe(DragUpdateDetails details) {
    double distancedifference = (details.localPosition.dx - localPosition);
    int originalIndex = rotationIndex;
    if (distancedifference < 0) {
      distancedifference = (-distancedifference);
    }
    if (distancedifference >=
        (pow(4, (6 - sensitivity)) / (widget.imageList.length))) {
      rotationIndex = rotationIndex - 1;
      localPosition = details.localPosition.dx;
    }
    if (originalIndex != rotationIndex) {
      setState(() {
        if (rotationIndex >= 0) {
          rotationIndex = rotationIndex;
        } else {
          rotationIndex = widget.imageList.length - 1;
        }
      });
      onImageIndexChanged(rotationIndex);
    }
  }
}
