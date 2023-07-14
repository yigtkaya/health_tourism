class AssetConstants {
  static DTIcons icons = DTIcons();
  static String toLotti(String name) => 'assets/lottie/$name.json';
  static String toJpg(String name) => 'assets/image/$name.jpg';
  static String toPng(String name) => 'assets/image/$name.png';
  static String toIcon(String name) => 'assets/icon/ic_$name.svg';
  static String toJson(String name) => 'assets/mock/$name.json';
}

class DTIcons {
  final String googleIcon = AssetConstants.toIcon("google_icon");
  final String facebookIcon = AssetConstants.toIcon("facebook_icon");
  final String infoIcon = AssetConstants.toIcon("info_icon");
  final String verticalDivider = AssetConstants.toIcon("vertical_divider_icon");
  final String rightChevron = AssetConstants.toIcon("right_chevron");
  final String leftChevron = AssetConstants.toIcon("left_chevron");
  final String inbox = AssetConstants.toIcon("inbox");
}
