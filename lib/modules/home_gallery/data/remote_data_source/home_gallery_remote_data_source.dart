import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../shared/network/dio_helper.dart';
import '../models/home_gallery_model.dart';
import '../models/image_file_model.dart';

class HomeGalleryRemoteDataSource {
  Future<ImageFileModel?> makeUpload(
      {required FormData file, required String? myToken}) async {
    try {

      final res = await DioHelper.makePostData(
        url: "upload",
        data: file,
        token: myToken,
      );
      print("this is response $res");
      return ImageFileModel.fromJson(res.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<HomeGalleryModel?> getAllImages({required String? myToken}) async {
    try {
      final res = await DioHelper.getData(
        url: "https://technichal.prominaagency.com/api/my-gallery",
        token: myToken,
      );
      return HomeGalleryModel.fromJson(res.data);
    } catch (error) {
      rethrow;
    }
  }
}
