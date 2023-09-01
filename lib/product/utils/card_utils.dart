import 'package:flutter/cupertino.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/product/models/card_type.dart';

class CardUtils {

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp,"");
  }

  static CardType getCardTypeFromNumber(String input) {
    CardType cardType;
    String prefix = input.substring(0,2);
    if (prefix == "34" || prefix == "37") {
      cardType = CardType.Amex;
    } else if (prefix.startsWith("5")) {
      cardType = CardType.Master;
    } else if (prefix.startsWith("4")) {
      cardType = CardType.Visa;
    } else if (prefix.startsWith("6")) {
      cardType = CardType.Discover;
    } else {
      cardType = CardType.Others;
    }
    return cardType;
  }

  static getCardIcon(CardType? type) {
    Widget icon;
    switch(type) {
      case CardType.Master:
        icon = HTIcon(iconName: AssetConstants.icons.mastercard, height: 24, width: 24,);
        break;
      case CardType.Visa:
        icon = HTIcon(iconName: AssetConstants.icons.visa, height: 24, width: 24,);
        break;
      case CardType.Amex:
        icon = HTIcon(iconName: AssetConstants.icons.amex, height: 24, width: 24,);
        break;
      case CardType.Discover:
        icon = HTIcon(iconName: AssetConstants.icons.discover, height: 24, width: 24,);
        break;
      case CardType.Others:
        icon = const SizedBox.shrink();
        break;
      default:
        icon = const SizedBox.shrink();
    }
    return icon;
  }
}