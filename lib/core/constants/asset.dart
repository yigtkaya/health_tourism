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
  final String facebookIcon = AssetConstants.toIcon("facebook_icon");
  final String backIcon = AssetConstants.toIcon("back");
  final String infoIcon = AssetConstants.toIcon("info_icon");
  final String cameraIcon = AssetConstants.toIcon("camera_icon");
  final String sendIcon = AssetConstants.toIcon("send_icon");
  final String verticalDivider = AssetConstants.toIcon("vertical_divider_icon");
}
