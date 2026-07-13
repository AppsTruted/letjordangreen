import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageViewProvider with ChangeNotifier, DiagnosticableTreeMixin {


  bool _isLoading = false;

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  jumpToNextPage(int valueIndex){
    _pageController.animateToPage(valueIndex, duration: const Duration(milliseconds: 10), curve: Curves.linear);
    notifyListeners();
  }


  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  changeIndexNavigationBar(int index){
    _currentIndex = index;
    notifyListeners();
  }



  PageController get pageController => _pageController;


  int _pageViewIndex = 0;



  void changeIndex(int index) {
    _pageViewIndex = index;

    notifyListeners();
  }


  set pageViewIndex(int value) {
    _pageViewIndex = value;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

  }




}

