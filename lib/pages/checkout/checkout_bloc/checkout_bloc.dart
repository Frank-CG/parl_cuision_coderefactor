import 'package:bloc/bloc.dart';

import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  @override
  CheckoutState get initialState => CheckoutStep1();

  @override
  Stream<CheckoutState> mapEventToState(
    CheckoutEvent event,
  ) async* {
    if(event is CheckoutInitial) {
      yield CheckoutStep1();
    }
    if(event is CheckoutNext){
      switch (event.stepIndex) {
        case 0:
          yield CheckoutStep2(hour: event.hour, minute: event.minute);
          break;
        case 1:
          yield CheckoutStep3(hour: event.hour, minute: event.minute);
          break;
        case 2:
          yield CheckoutConfirmed();
          break;
        default:
          break;
      }
    }
    if(event is CheckoutSetTime){
      yield CheckoutTimeSetting(hour: currentState.hour, minute: currentState.minute);
      yield CheckoutStep2(hour: event.hour, minute: event.minute);
    }
    if(event is CheckoutCancel){
      yield CheckoutCanceled();
    }
    if(event is CheckoutFinish){
      yield CheckoutConfirmed();
    }
  }
}