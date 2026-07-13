
import 'package:bloc/bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  int currentIndex = 0;
  NavigationBloc() : super(NavigationInitial(currentIndex: 0)) {
    on<NavigationEvent>((event, emit) {
      if (event is PageTapped) {
        currentIndex = event.index;

        emit (CurrentIndexChanged(currentIndex: currentIndex));

      }
    });
  }
}
