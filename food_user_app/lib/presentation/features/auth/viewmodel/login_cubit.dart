import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/authentication_repository.dart'; // Use AuthenticationRepository
import '../../../../data/models/user.dart'; // Use UserModel
import 'login_state.dart';
import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
import '../../../../core/responses/result.dart';
import '../../../../core/models/failure.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository
  authenticationRepository; // Use AuthenticationRepository

  LoginCubit({required this.authenticationRepository})
    : super(LoginInitial()); // Use AuthenticationRepository

  Future<void> loginWithEmail(String email, String password) async {
    emit(LoginLoading());

    final result = await authenticationRepository.login(
      email: email,
      password: password,
    ); // Use AuthenticationRepository

    if (result.isSuccess) {
      emit(LoginSuccess(result.data!));
    } else {
      // استخدام رسالة خطأ أكثر تحديدًا للمستخدم
      String errorMessage = 'invalidCredentials'.tr();
      emit(LoginFailure(errorMessage));
    }
  }

  void resetState() {
    emit(LoginInitial());
  }
}
