import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/payment_field.dart';
import 'package:health_tourism/cubit/payment/payment_cubit.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';
import 'package:health_tourism/product/utils/card_utils.dart';
import 'package:health_tourism/product/utils/input_formatters.dart';
import '../../core/components/dialog/package_detail_dialog.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
import '../../core/constants/vertical_space.dart';
import '../../product/models/card_type.dart';
import '../../product/models/clinic.dart';
import '../../product/models/package.dart';
import '../../product/theme/styles.dart';

class PaymentView extends StatefulWidget {
  final Clinic clinic;

  PaymentView({super.key, required this.clinic});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  CardType cardType = CardType.Invalid;
  List<bool> isSelected = [true, false];
  List<Package> packages = [];
  DateTime? date = DateTime.now();
  String dateText = "Select a Date";
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String city = "";
  String country = "";
  String address = "";
  String postalCode = "";
  bool isCvvFocused = false;
  int selectedIndex = 0;

  final cardHolderNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvCodeController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void extractPackages() {
    final details = widget.clinic.packages;
    for (final package in details) {
      packages.add(Package.fromData(package));
    }
  }

  void getCardTypeFromNumber() {
    if(cardNumberController.text.length <= 6 && cardNumberController.text.length >= 2) {
      String cardNum = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFromNumber(cardNum);
      if(type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    cardNumberController.addListener(() {
      getCardTypeFromNumber();
    });
    extractPackages();
    context.read<PackageCubit>().selectPackage(packages[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: const Color(0xff2D9CDB),
        elevation: 0,
        centerTitle: true,
        leadingWidth: 42,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: HTIcon(
            iconName: AssetConstants.icons.chevronLeft,
            onPress: () {
              context.pop();
            },
            width: 24,
            height: 24,
          ),
        ),
        title: HTText(
          label: "Make an Appointment",
          style: htToolBarLabel,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                showSelectedClinic(widget.clinic),
                const VerticalSpace(
                  spaceAmount: 24,
                ),
                HTText(label: "Packages", style: htTitleStyle),
                const VerticalSpace(
                  spaceAmount: 12,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: size.height * 0.36,
                  ),
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: packages.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                                context
                                    .read<PackageCubit>()
                                    .selectPackage(packages[index]);
                              },
                              child: packageCard(
                                  packages[index], selectedIndex == index)),
                        );
                      }),
                ),
                const VerticalSpace(
                  spaceAmount: 24,
                ),
                HTText(label: "Choose a Date", style: htSubTitle),
                const VerticalSpace(
                  spaceAmount: 12,
                ),
                // create date picker
                datePicker(),
                const VerticalSpace(),
                const Divider(
                  color: Color(0xffD3E3F1),
                  thickness: 1,
                ),
                const VerticalSpace(
                  spaceAmount: 20,
                ),
                paymentColumn(
                  cardHolderNameController,
                  cardNumberController,
                  expiryDateController,
                  cvvCodeController,
                  cityController,
                  countryController,
                  postalCodeController,
                  addressController,
                ),
                const VerticalSpace(),
                const Divider(
                  color: Color(0xffD3E3F1),
                  thickness: 1,
                ),
                const VerticalSpace(
                  spaceAmount: 24,
                ),
                HTText(label: "Payment Details", style: htSubTitle),
                const VerticalSpace(
                  spaceAmount: 16,
                ),
                BlocBuilder<PackageCubit, Package?>(
                  builder: (context, selectedPackage) {
                    if (selectedPackage is Package) {
                      return paymentDetail(selectedPackage);
                    } else {
                      return paymentDetail(null);
                    }
                  },
                ),
                const VerticalSpace(
                  spaceAmount: 24,
                ),
                checkoutButton(),
                const VerticalSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentColumn(
      TextEditingController cardHolderNameController,
      TextEditingController cardNumberController,
      TextEditingController expiryDateController,
      TextEditingController cvvController,
      TextEditingController cityController,
      TextEditingController countryController,
      TextEditingController postalCodeController,
      TextEditingController addressController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HTText(label: "Card Info", style: htDarkBlueLargeStyle),
        const VerticalSpace(
          spaceAmount: 2,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color(0xFFD3E3F1).withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  cardHolderName = value;
                });
              },
              maxLines: 1,
              controller: cardHolderNameController,
              style: htDarkBlueNormalStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Name on Card",
                hintStyle: htHintTextDarkStyle,
              ),
            ),
          ),
        ),
        const VerticalSpace(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color(0xFFD3E3F1).withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
                CardNumberInputFormatter()
              ],
              onChanged: (value) {
                setState(() {
                  cardNumber = value;
                });
              },
              maxLines: 1,
              controller: cardNumberController,
              style: htDarkBlueNormalStyle,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: CardUtils.getCardIcon(cardType)),
                border: InputBorder.none,
                labelText: "Card Number",
                hintStyle: htHintTextDarkStyle,
              ),
            ),
          ),
        ),
        const VerticalSpace(),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFFD3E3F1).withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        expiryDate = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      CardMonthInputFormatter(),
                    ],
                    maxLines: 1,
                    controller: expiryDateController,
                    style: htDarkBlueNormalStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "MM/YY",
                      hintStyle: htHintTextDarkStyle,
                    ),
                  ),
                ),
              ),
            ),
            const HorizontalSpace(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFFD3E3F1).withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        cvvCode = value;
                      });
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4)
                    ],
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    controller: cvvController,
                    style: htDarkBlueNormalStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "CVV",
                      hintStyle: htHintTextDarkStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const VerticalSpace(
          spaceAmount: 24,
        ),
        HTText(label: "Billing Info", style: htDarkBlueLargeStyle),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFFD3E3F1).withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        city = value;
                      });
                    },
                    maxLines: 1,
                    controller: cityController,
                    style: htDarkBlueNormalStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "City",
                      hintStyle: htHintTextDarkStyle,
                    ),
                  ),
                ),
              ),
            ),
            const HorizontalSpace(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color(0xFFD3E3F1).withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        country = value;
                      });
                    },
                    maxLines: 1,
                    controller: countryController,
                    style: htDarkBlueNormalStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Country",
                      hintStyle: htHintTextDarkStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const VerticalSpace(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color(0xFFD3E3F1).withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
              maxLines: 1,
              controller: addressController,
              style: htDarkBlueNormalStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Address",
                hintStyle: htHintTextDarkStyle,
              ),
            ),
          ),
        ),
        const VerticalSpace(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color(0xFFD3E3F1).withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  postalCode = value;
                });
              },
              maxLines: 1,
              controller: postalCodeController,
              style: htDarkBlueNormalStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Postal Code",
                hintStyle: htHintTextDarkStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget packageCard(Package package, bool isSelected) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xffc2e1ff).withOpacity(0.6)
            : Colors.white,
        border: Border.all(color: const Color(0xff58a2eb)),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            HTText(
              label: package.packageName,
              style: htBlueLabelStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff58a2eb)),
            ),
            const VerticalSpace(
              spaceAmount: 8,
            ),
            HTText(
                label: package.packageDescription, style: htDarkBlueLargeStyle),
            const VerticalSpace(),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xfff3f3f3),
            ),
            const VerticalSpace(),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: package.packageFeatures.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HTIcon(
                          iconName: AssetConstants.icons.checkMark,
                          color: const Color(0xff58a2eb),
                          width: 14,
                          height: 14,
                        ),
                        const HorizontalSpace(
                          spaceAmount: 4,
                        ),
                        Expanded(
                          child: Text(
                            package.packageFeatures[index],
                            style: htDarkBlueLargeStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  String monthFromInt(int index) {
    switch (index) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "July";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      default:
        return "Dec";
    }
  }

  Widget checkoutButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        var expireMonth = expiryDate.split('/')[0];
        var expireYear = '20${expiryDate.split('/')[1]}';
        var firstName = cardHolderName.split(' ')[0];
        var surName = cardHolderName.split(' ')[1];
        var cardNum = cardNumber.replaceAll(' ', '');

        var buyer = {
          'id': '1',
          'name': firstName,
          'surname': surName,
          'email': '',
          'city': '',
          'country': '',
          'address': '',
        };

        var package = {
          'id': "widget.package!.id",
          'name': "widget.package!.name",
          'category': "widget.package!.category",
          'price': 24.5,
        };

        if (context.read<PaymentCubit>().isAmexCard(cardNumber)) {
          if (context
              .read<PaymentCubit>()
              .isCreditCardExpireDateValid(expireMonth, expireYear)) {
            context.read<PaymentCubit>().createPayment(firstName, surName, 1.2,
                cardHolderName, cardNumber, expireMonth, expireYear, cvvCode);
          }
        } else {
          if (context
                  .read<PaymentCubit>()
                  .isCreditCardExpireDateValid(expireMonth, expireYear) &&
              context
                  .read<PaymentCubit>()
                  .isCreditCardNumberValid(cardNumber)) {
            context.read<PaymentCubit>().createPayment(firstName, surName, 1.2,
                cardHolderName, cardNumber, expireMonth, expireYear, cvvCode);
          }
        }
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff58a2eb)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Center(
              child: HTText(label: 'Checkout', style: htBoldLabelStyle),
            ),
          )),
    );
  }

  Widget datePicker() {
    return GestureDetector(
      onTap: () async {
        date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2025),
        );

        if (date == null) {
          setState(() {
            dateText = 'Select a Date';
          });
        } else {
          setState(() {
            dateText =
                '${monthFromInt(date!.month.toInt())} ${date!.day}, ${date!.year}';
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffD3E3F1),
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: Row(
            children: [
              HTText(label: dateText, style: htBlueLabelStyle),
              const Spacer(),
              HTIcon(
                iconName: AssetConstants.icons.calendar,
                width: 24,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentDetail(Package? package) {
    return Column(
      children: [
        Row(
          children: [
            HTText(
                label: "${package?.packageName} Package",
                style: htDarkBlueNormalStyle),
            const Spacer(),
            HTText(
                label: "\$${package?.price}".toString(),
                style: htDarkBlueNormalStyle),
          ],
        ),
        const VerticalSpace(
          spaceAmount: 16,
        ),
        Row(
          children: [
            HTText(label: "Down Payment", style: htDarkBlueNormalStyle),
            const Spacer(),
            HTText(
                label: "\$${package!.price / 10}",
                style: htDarkBlueNormalStyle),
          ],
        ),
        const VerticalSpace(
          spaceAmount: 16,
        ),
        Row(
          children: [
            HTText(label: "Total", style: htBoldDarkLabelStyle),
            const Spacer(),
            HTText(
                label: "\$${package!.price / 10}", style: htBoldDarkLabelStyle),
          ],
        ),
      ],
    );
  }

  Widget showSelectedClinic(Clinic clinic) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Image.network(
              clinic.profilePicture,
            ),
          ),
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          HTText(
                              label: clinic.name, style: htBoldDarkLabelStyle),
                        ],
                      ),
                      const Spacer(),
                      HTIcon(
                        iconName: AssetConstants.icons.star,
                        width: 20,
                        height: 20,
                      ),
                      const HorizontalSpace(
                        spaceAmount: 3,
                      ),
                      HTText(
                          label: "${clinic.averageRating}",
                          style: htBlueLabelStyle),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HTText(
                          label: "${clinic.city}, ${clinic.country}",
                          style: htBlueLabelStyle),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF123258),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 2),
                          child: Row(
                            children: [
                              HTIcon(iconName: AssetConstants.icons.chatBubble),
                              const HorizontalSpace(
                                spaceAmount: 4,
                              ),
                              HTText(label: "Chat", style: htWhiteLabelStyle),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  ");
      }
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(
        offset: buffer.toString().length,
      ),
    );
  }
}
