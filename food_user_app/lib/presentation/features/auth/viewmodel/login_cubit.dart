import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../data/entities/user.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository;

  LoginCubit({required this.userRepository}) : super(LoginInitial());

  Future<void> loginWithEmail(String email) async {
    emit(LoginLoading());

    final result = await userRepository.loginWithEmail(email);
    print(result);

    if (result.isLeft) {
      emit(LoginFailure(result.left!.message));
    } else {
      if (result.right != null) {
        emit(LoginSuccess(result.right!));
      } else {
        emit(LoginFailure('لم يتم العثور على مستخدم بهذا البريد الإلكتروني'));
      }
    }
  }

  void resetState() {
    emit(LoginInitial());
  }
}
