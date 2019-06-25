import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

/// Reserve Bloc : State Definition
class ReserveState extends Equatable {
  ReserveState({
    this.stepIndex = 0,
    this.reservGuestsNumber = 0,
    this.reservDateTime,
    this.reservHour = -1,
    this.reservMinute = -1,
  }) : super([stepIndex, reservGuestsNumber, reservDateTime, reservHour, reservMinute]);

  final int totalSteps = 4;

  final int stepIndex;
  final int reservGuestsNumber;
  final DateTime reservDateTime;
  final int reservHour;
  final int reservMinute;

  bool get nextEnable {
    bool flag = true;
    if (stepIndex == 2 && (reservHour == -1 || reservMinute == -1)) {
      flag = false;
    }
    return flag;
  }

  String get reservDateFormated {
    var formatter = new DateFormat('yMMMMd');
    return formatter.format(reservDateTime);
  }

  String get reserveTimeFormated {
    String result = "";
    if (reservHour == -1 || reservMinute == -1) {
      result = "Unselected";
    } else {
      String temp = "";
      temp = "0" + reservHour.toString();
      result += temp.substring(temp.length - 2);
      result += ":";
      temp = "0" + reservMinute.toString();
      result += temp.substring(temp.length - 2);
    }
    return result;
  }
}

/// Reserve Bloc : Event Definition
abstract class ReserveEvent extends Equatable {
  ReserveEvent([List props = const []]) : super(props);
}

class StepChange extends ReserveEvent {
  // final ReserveState curState;
  final int stepIndex;
  final int reservGuestsNumber;
  final DateTime reservDateTime;
  final int reservHour;
  final int reservMinute;

  StepChange({
    this.stepIndex,
    this.reservGuestsNumber,
    this.reservDateTime,
    this.reservHour,
    this.reservMinute,
  });
}

/// Reserve Bloc : map Event to State.
class ReserveBloc extends Bloc<ReserveEvent, ReserveState> {
  @override
  ReserveState get initialState => ReserveState(reservDateTime: DateTime.now());

  @override
  Stream<ReserveState> mapEventToState(
    ReserveEvent event,
  ) async* {
    if (event is StepChange) {
      
      yield ReserveState(
        stepIndex: event.stepIndex,
        reservGuestsNumber: event.reservGuestsNumber,
        reservDateTime: event.reservDateTime,
        reservHour: event.reservHour,
        reservMinute: event.reservMinute,
      );
    }
  }
}
