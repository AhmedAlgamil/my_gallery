import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_gallery/modules/home_gallery/data/models/home_gallery_model.dart';

import '../models/image_file_model.dart';
import '../remote_data_source/home_gallery_remote_data_source.dart';

class HomeGalleryRepository {

  final HomeGalleryRemoteDataSource _loginRemoteDataSource = HomeGalleryRemoteDataSource();

  Future<ImageFileModel?> makeUpload({
    required FormData? file,
    required String? myToken,
  }) async {
    try {
      return await _loginRemoteDataSource.makeUpload(file: file!,myToken: myToken);
    } catch (error) {
      rethrow;
    }
  }

  Future<HomeGalleryModel?> getAllImages({
    required String? myToken,
  }) async {
    try {
      return await _loginRemoteDataSource.getAllImages(myToken: myToken);
    } catch (error) {
      rethrow;
    }
  }

}