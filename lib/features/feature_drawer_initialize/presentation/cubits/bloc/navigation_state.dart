part of 'navigation_bloc.dart';

abstract class NavigationState  {}

class NavigationInitial extends NavigationState {
  final int currentIndex;

  NavigationInitial({required this.currentIndex});
}

class CurrentIndexChanged extends NavigationState {
  final int currentIndex;

  CurrentIndexChanged({required this.currentIndex});

}