import '../models/user_data_model.dart';
import '../remote_data_source/login_remote_data_source.dart';

class LoginRepository {

  final LoginRemoteDataSource _loginRemoteDataSource = LoginRemoteDataSource();

  Future<UserDataModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _loginRemoteDataSource.login(email: email, password: password);
    } catch (error) {
      rethrow;
    }
  }

}