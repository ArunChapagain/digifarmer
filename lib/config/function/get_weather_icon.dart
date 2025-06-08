import 'package:digifarmer/constants/app_images.dart';

String getWeathericonFromAssets(String? icon) {
  if (icon == null) {
    return AppImages.sunPath;
  }
  return "assets/images/weather/$icon";
}
