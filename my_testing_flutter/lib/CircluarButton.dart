import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytestingflutter/main.dart';

import 'blocs/carBloc.dart';
import 'blocs/car_events.dart';
import 'blocs/car_states.dart';

class CircularButton extends StatefulWidget {
  String carColor;

  CircularButton({Key key, @required this.carColor}) : super(key: key);

  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    CarBloc carBloc = CarBloc();
    DemoPageState demoPageState = DemoPageState();
    /*  var carColorCode ="0xff${widget.carColor.substring(1)}";
    print("carColorCode is $carColorCode");
    String valueString = carColorCode.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color newCarColor = new Color(value);*/
    return BlocListener(
      bloc: carBloc,
      listener: (context, state) {
        if (state is UnPressedState) {
          print("unpressed state!!");
        }
        if (state is OnPressedState) {
          print("widget.carColor is  ${widget.carColor}");
          print("http://18.157.167.102:7066/Content/Images/CarMake/Image360/exterior/18/${widget.carColor.substring(1)}/");
          key.currentState.downloadImage(
              "http://18.157.167.102:7066/Content/Images/CarMake/Image360/exterior/18/${widget.carColor.substring(1)}/",
              "${widget.carColor.substring(1)}subaruEgyptExterior");
        }
      },
      child: BlocProvider(
        create: (context) => carBloc,
        child: GestureDetector(
          onTap: () {
            print("clicked!!!, bloc started");
            carBloc.add(OnPressedEvent());
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: ClipOval(
              child: Container(
                color: Color(
                    int.parse(widget.carColor.substring(1, 7), radix: 16) +
                        0xFF000000),
                height: 25.0, // height of the button
                width: 25.0, // width of the button
                //child: Center(child: Text('A Circular Button')),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
