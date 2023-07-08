// create cubit for login screen

import 'package:bloc/bloc.dart';

import 'button_state.dart';


class ButtonCubit extends Cubit<ButtonState> {

  ButtonCubit() : super(ButtonState(isEnabled: false));

  void onTap() => emit(ButtonState(isEnabled: !state.isEnabled));

}