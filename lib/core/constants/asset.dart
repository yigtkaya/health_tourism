class AssetConstants {
  static HTIcons icons = HTIcons();
  static String toLotti(String name) => 'assets/lottie/$name.json';
  static String toJpg(String name) => 'assets/image/$name.jpg';
  static String toPng(String name) => 'assets/image/$name.png';
  static String toIcon(String name) => 'assets/icon/ic_$name.svg';
  static String toJson(String name) => 'assets/mock/$name.json';
}

class HTIcons {
  final String googleIcon = AssetConstants.toIcon("google_icon");
  final String googleIconPlus = AssetConstants.toIcon("google_plus");
  final String facebookIcon = AssetConstants.toIcon("facebook_icon");
  final String facebookIconSimple = AssetConstants.toIcon("facebook");
  final String twitter = AssetConstants.toIcon("twitter");
  final String backIcon = AssetConstants.toIcon("back");
  final String infoIcon = AssetConstants.toIcon("info_icon");
  final String cameraIcon = AssetConstants.toIcon("camera_icon");
  final String sendIcon = AssetConstants.toIcon("send_icon");
  final String verticalDivider = AssetConstants.toIcon("vertical_divider_icon");
  final String visibilityOn = AssetConstants.toIcon("visibility");
  final String visibilityOff = AssetConstants.toIcon("visibility_off");
  final String checkMark = AssetConstants.toIcon("check_mark");
  final String chevronLeft = AssetConstants.toIcon("chevron_left");
  final String homeSelected = AssetConstants.toIcon("home_selected");
  final String homeUnselected = AssetConstants.toIcon("home_unselected");
  final String messageSelected = AssetConstants.toIcon("message_selected");
  final String messageUnselected = AssetConstants.toIcon("message_unselected");
  final String profileSelected = AssetConstants.toIcon("profile_selected");
  final String profileUnselected = AssetConstants.toIcon("profile_unselected");
}
