import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/modules/home_gallery/data/models/home_gallery_model.dart';
import 'package:my_gallery/modules/home_gallery/data/repository/home_gallery_repository.dart';
import 'package:my_gallery/modules/home_gallery/presentation/store/home_gallery_states.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeGalleryCubit extends Cubit<HomeGalleryStates> {
  HomeGalleryCubit() : super(HomeGalleryIntialState());

  static HomeGalleryCubit get(BuildContext context) => BlocProvider.of(context);
  final HomeGalleryRepository _homeGalleryRepository = HomeGalleryRepository();
  bool isShowen = false;
  HomeGalleryModel? homeGalleryModel;
  List<String>? images;
  String? message ;

  File? image, photo;

  showUploadDialog(bool showDialog) {
    isShowen = showDialog;
    emit(ShowUploadDialog());
  }

  requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
    await Permission.storage.request();
    }
  }

  Future pickImage(String? myToken) async {
    try {
      emit(InitialSelectImage());
      final ImagePicker picker = ImagePicker();
      final XFile? myImage =
      await picker.pickImage(
          source: ImageSource.gallery);
      if (myImage == null) return;
      File imageFile = File(myImage.path);
      image = imageFile;
      makeUploading(image,myToken);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future takePhoto(String? myToken) async {
    try {
      emit(InitialSelectImage());
      final ImagePicker picker = ImagePicker();
      final XFile? myImage =
      await picker.pickImage(
          source: ImageSource.camera);
      if (myImage == null) return;
      File imageFile = File(myImage.path);
      photo = imageFile;
      makeUploading(photo,myToken);
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  makeUploading(File? file, String? myToken) async {
    emit(InitialUploadImage());
    String fileName = file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "img": await MultipartFile.fromFile(file.path, filename:fileName),
    });
    _homeGalleryRepository
        .makeUpload(file: formData, myToken: myToken)
        .then((value) {
      print(value);
      message = value!.message;
      emit(UploadSuccess());
    }).catchError((e) {
      emit(UploadFaild());
      print(e.toString());
    });
  }

  getImages({required String? token}) async {
    emit(LoadingImagesInGallery());
    _homeGalleryRepository
        .getAllImages(
      myToken: token,
    )
        .then((value) {
      images = value!.data!.images;
      homeGalleryModel = value;
      print(images);
      emit(ImagesLoaded());
    }).catchError((e) {
      emit(FailedToLoad());
      print(e.toString());
    });
  }
}
