import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bottom_navigation_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(NavbarInitial());

  static NavbarCubit get(context) => BlocProvider.of(context);

  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    emit(BottomNavState());
  }
}