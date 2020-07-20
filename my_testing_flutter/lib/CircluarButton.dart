
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytestingflutter/main.dart';

import 'blocs/carBloc.dart';
import 'blocs/car_events.dart';
import 'blocs/car_states.dart';

class CircularButton extends StatelessWidget {
  Color carColor;

  CircularButton({Key key, @required this.carColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarBloc carBloc = CarBloc();
    DemoPageState demoPageState = DemoPageState();
    return BlocListener(
      bloc: carBloc,
      listener: (context, state) {
        if(state is UnPressedState)
          {
            print("unpressed state!!");
          }
        if (state is OnPressedState) {
          demoPageState.downloadImage();
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
                color: carColor,
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
