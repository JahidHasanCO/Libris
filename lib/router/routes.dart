part of 'router.dart';

sealed class Routes {
  static const aboutUs = 'about_us';
  static const categoryDetails = 'category_details';
  static const categoryList = 'category_list';
  static const onboard = 'onboard';
  static const bottomNavigation = 'bottom_navigation';
  static const pdfRead = 'pdf_read';
  static const privateFolderPin = 'private_folder_pin';
  static const privateFolder = 'private_folder';
}

extension AsPathExt on String {
  String get asPath => '/$this';
}
