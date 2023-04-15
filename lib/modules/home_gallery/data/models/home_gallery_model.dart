class HomeGalleryModel {
  HomeGalleryModel({
    required this.status,
    required this.data,
    required this.message,
  });
  late final String status;
  late final ImagesData data;
  late final String message;

  HomeGalleryModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = ImagesData.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class ImagesData {
  ImagesData({
    required this.images,
  });
  late final List<String> images;

  ImagesData.fromJson(Map<String, dynamic> json){
    images = List.castFrom<dynamic, String>(json['images']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['images'] = images;
    return _data;
  }
}