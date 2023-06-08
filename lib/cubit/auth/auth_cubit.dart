import 'package:bloc/bloc.dart';
import '../../core/services/auth_repo.dart';
import 'AuthState.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());


}