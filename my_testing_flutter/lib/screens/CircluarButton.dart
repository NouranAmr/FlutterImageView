import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytestingflutter/screens/downloadImageView.dart';
import 'file:///G:/Nouran/Projects/FlutterImageView/my_testing_flutter/lib/screens/CarColour.dart';
import 'file:///G:/Nouran/Projects/FlutterImageView/my_testing_flutter/lib/screens/main.dart';

import '../blocs/carBloc.dart';
import '../blocs/car_events.dart';
import '../blocs/car_states.dart';

class CircularButton extends StatefulWidget {
  String carColor;
  String carModelID;
  SelectedCar selectedCar;

  CircularButton({Key key, @required this.carColor, @required this.carModelID,this.selectedCar})
      : super(key: key);

  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    CarBloc carBloc = CarBloc();
    return BlocListener(
      bloc: carBloc,
      listener: (context, state) {
        if (state is UnPressedState) {
          print("unpressed state!!");
        }
        if (state is OnPressedState) {
         /* var x =key.currentState.downloadImage(
              "http://18.157.167.102:7066/Content/Images/CarMake/Image360/exterior/${widget.carModelID}/${widget.carColor.substring(1)}/",
              "Mod${widget.carModelID}_Col${widget.carColor.substring(1)}",widget.selectedCar.selectedCarIndex());*/
          changeCarColour(widget.carModelID, widget.carColor.substring(1), widget.selectedCar.selectedCarIndex());
        }
      },
      child: BlocProvider(
        create: (context) => carBloc,
        child: GestureDetector(
          onTap: () {
            print("ButtonPressed");
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
class SelectedCar
{
  int selectedCarIndex(){}
}

