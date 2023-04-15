import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/modules/login/data/repository/login_repository.dart';
import 'package:my_gallery/modules/login/presentation/store/login_states.dart';

import '../../data/models/user_data_model.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitalState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);
  final LoginRepository _authRepository = LoginRepository();

  UserDataModel? userDataModel;

  login({required String email, required String password}) async {
    emit(LoginLoadingState());
    _authRepository
        .login(
      email: email,
      password: password,
    ).then((value) {
      userDataModel = value;
      print(value!.data);
      emit(LoginLoadedState());
    }).catchError((e) {
      emit(LoginFailedState());
      print(e.toString());
    });
  }

}