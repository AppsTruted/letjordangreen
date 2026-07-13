part of 'navigation_bloc.dart';

abstract class NavigationEvent  {
  const NavigationEvent();
}
class AppStarted extends NavigationEvent {
  @override
  String toString() => 'AppStarted';
}

class PageTapped extends NavigationEvent {
  final int index;
  PageTapped({required this.index});

  @override
  String toString() => 'PageTapped: $index';
}