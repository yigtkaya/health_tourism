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
  final String chevronRight = AssetConstants.toIcon("chevron_right");
  final String homeSelected = AssetConstants.toIcon("home_selected");
  final String homeUnSelected = AssetConstants.toIcon("home_unselected");
  final String messageSelected = AssetConstants.toIcon("message_selected");
  final String messageUnSelected = AssetConstants.toIcon("message_unselected");
  final String profileSelected = AssetConstants.toIcon("profile_selected");
  final String profileUnSelected = AssetConstants.toIcon("profile_unselected");
  final String search = AssetConstants.toIcon("search");
  final String calendar = AssetConstants.toIcon("calendar");
  final String sort = AssetConstants.toIcon("sort_icon");
  final String star = AssetConstants.toIcon("star");
  final String chatBubble = AssetConstants.toIcon("chat_bubble");
  final String burger = AssetConstants.toIcon("burger");
  final String help = AssetConstants.toIcon("help");
  final String logout = AssetConstants.toIcon("logout");
  final String emptyStar = AssetConstants.toIcon("empty_star");
  final String appointment = AssetConstants.toIcon("appointment");
  final String payment = AssetConstants.toIcon("payment");
  final String vector = AssetConstants.toIcon("vector");
  final String creditCard = AssetConstants.toIcon("credit_card");
  final String clock = AssetConstants.toIcon("clock");
  final String location = AssetConstants.toIcon("location");
  final String edit = AssetConstants.toIcon("edit");
  final String discover = AssetConstants.toIcon("discover");
  final String amex = AssetConstants.toIcon("amex");
  final String visa = AssetConstants.toIcon("visa");
  final String mastercard = AssetConstants.toIcon("mastercard");
  final String warning = AssetConstants.toIcon("exclamation");
}
