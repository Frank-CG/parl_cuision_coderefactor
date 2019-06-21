import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Reserve Bloc : State Definition
class ReserveState extends Equatable {
  ReserveState({this.stepIndex = 0, this.reservGuestsNumber = 0, this.reservDateTime}) 
  : super([stepIndex, reservGuestsNumber, reservDateTime]);

  final int stepIndex;
  final int reservGuestsNumber;
  final DateTime reservDateTime;
}

/// Reserve Bloc : Event Definition
abstract class ReserveEvent extends Equatable {
  ReserveEvent([List props = const []]) : super(props);
}

class NextStep extends ReserveEvent {
  final ReserveState curState;
  final int stepIndex;
  final int reservGuestsNumber;
  final DateTime reservDateTime;

  NextStep({@required this.curState, this.stepIndex, this.reservGuestsNumber, this.reservDateTime});
  
}


/// Reserve Bloc : map Event to State.
class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  @override
  ReserveState get initialState => ReserveState();

  @override
  Stream<ReserveState> mapEventToState(
    ReserveEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}


