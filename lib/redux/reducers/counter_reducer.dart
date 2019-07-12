import '../actions/counter_actions.dart';

int counterReducer(preState, action) {
  int newState = preState;

  if (action == IncrementAction) {
    newState += 1;
  }

  return newState;
}
