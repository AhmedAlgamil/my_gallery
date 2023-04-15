abstract class HomeGalleryStates{}

class HomeGalleryIntialState extends HomeGalleryStates{}

class LoadingImagesInGallery extends HomeGalleryStates{}
class ImagesLoaded extends HomeGalleryStates{}
class FailedToLoad extends HomeGalleryStates{}

class InitialUploadImage extends HomeGalleryStates{}
class InitialSelectImage extends HomeGalleryStates{}
class ShowUploadDialog extends HomeGalleryStates{}
class UnShowUploadDialog extends HomeGalleryStates{}
class UploadFaild extends HomeGalleryStates{}
class UploadSuccess extends HomeGalleryStates{}
