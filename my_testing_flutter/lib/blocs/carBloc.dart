import 'dart:async';
import 'package:bloc/bloc.dart';

import 'car_events.dart';
import 'car_states.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  @override

  CarState get initialState =>  UnPressedState();

  @override
  Stream<CarState> mapEventToState(CarEvent event)async* {

    if(event is Loading)
      {
        yield UnPressedState();

      }
    if(event is OnPressedEvent)
      {
        yield OnPressedState();

      }
  }
  
}
