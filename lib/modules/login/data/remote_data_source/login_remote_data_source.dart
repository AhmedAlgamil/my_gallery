import 'package:image_picker/image_picker.dart';

import '../../../../shared/network/dio_helper.dart';
import '../models/user_data_model.dart';

class LoginRemoteDataSource{
  Future<UserDataModel?> login({required String? email,required String? password}) async {
    try {
      final res = await DioHelper.postData(
          url: "auth/login",
          data: {
            "email": email,
            "password": password,
          }
      );
      return UserDataModel.fromJson(res.data);
    } catch (error) {
      rethrow;
    }
  }
}