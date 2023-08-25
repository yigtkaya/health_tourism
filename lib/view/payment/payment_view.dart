import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/payment_field.dart';
import 'package:health_tourism/cubit/payment/payment_cubit.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
import '../../core/constants/vertical_space.dart';
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
  List<bool> isSelected = [true, false];
  DateTime? date = DateTime.now();
  String dateText = "Select a Date";
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final cardHolderNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvCodeController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                showSelectedClinic(),
                const VerticalSpace(
                  spaceAmount: 24,
                ),
                HTText(label: "Packages", style: htTitleStyle),
                const VerticalSpace(
                  spaceAmount: 20,
                ),
                togglePackages(size),
                const VerticalSpace(
                  spaceAmount: 24,
                ),
                HTText(label: "Choose Date", style: htSubTitle),
                const VerticalSpace(
                  spaceAmount: 20,
                ),
                // create date picker
                datePicker(),
                const VerticalSpace(),
                const Divider(
                  color: Color(0xffD3E3F1),
                  thickness: 1,
                ),
                const VerticalSpace(
                  spaceAmount: 32,
                ),
                PaymentField(
                  cardHolderNameController: cardHolderNameController,
                  cardNumberController: cardNumberController,
                  expiryDateController: expiryDateController,
                  cvvController: cvvCodeController,
                  cityController: cityController,
                  countryController: countryController,
                  addressController: addressController,
                  postalCodeController: postalCodeController,
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
                paymentDetail(),
                const VerticalSpace(
                  spaceAmount: 24,
                ),
                totalButtonRow(),
                const VerticalSpace(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: const Color(0xFF123258),
                      ),
                      height: size.height * 0.006,
                      width: size.width * 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget packageCard(Package package) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      decoration: BoxDecoration(
        color: Colors.white,
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
              style: htBlueLabelStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w600, color: const Color(
                  0xff58a2eb)),
            ),
            const VerticalSpace(
              spaceAmount: 8,
            ),
            HTText(
                label: package.packageDescription,
                style: htDarkBlueLargeStyle),
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
                                fontSize: 14, fontWeight: FontWeight.w400
                            ),),
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

  Widget checkoutColumn(Size size) {
    final cardHolderNameController = TextEditingController();
    final cardNumberController = TextEditingController();
    final expiryDateController = TextEditingController();
    final cvvCodeController = TextEditingController();
    final cityController = TextEditingController();
    final countryController = TextEditingController();
    final addressController = TextEditingController();

    return Column(
      children: [
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
            child: TextField(
              onChanged: (value) {
                setState(() {
                  cardNumber = value;
                });
              },
              maxLines: 1,
              controller: cardNumberController,
              style: htDarkBlueNormalStyle,
              decoration: InputDecoration(
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
                    maxLines: 1,
                    controller: expiryDateController,
                    style: htDarkBlueNormalStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Expiry Date",
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
                    maxLines: 1,
                    controller: cvvCodeController,
                    style: htDarkBlueNormalStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "CCV",
                      hintStyle: htHintTextDarkStyle,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
                        cvvCode = value;
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
                  cardNumber = value;
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
      ],
    );
  }

  Widget totalButtonRow() {
    return GestureDetector(
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

  Widget paymentDetail() {
    return Column(
      children: [
        Row(
          children: [
            HTText(label: "selectedPackageName", style: htDarkBlueNormalStyle),
            const Spacer(),
            HTText(label: "\$24.8".toString(), style: htDarkBlueNormalStyle),
          ],
        ),
        const VerticalSpace(
          spaceAmount: 16,
        ),
        Row(
          children: [
            HTText(label: "selectedPackageName", style: htDarkBlueNormalStyle),
            const Spacer(),
            HTText(label: "\$24.8", style: htDarkBlueNormalStyle),
          ],
        ),
        const VerticalSpace(
          spaceAmount: 16,
        ),
        Row(
          children: [
            HTText(label: "Total", style: htBoldDarkLabelStyle),
            const Spacer(),
            HTText(label: "\$24.8", style: htBoldDarkLabelStyle),
          ],
        ),
      ],
    );
  }

  Widget togglePackages(Size size) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ToggleButtons(
          isSelected: isSelected,
          renderBorder: true,
          borderColor: Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
          selectedBorderColor: const Color(0xff08233b),
          onPressed: (int newIndex) {
            setState(() {
              // looping through the list of booleans values
              for (int index = 0; index < isSelected.length; index++) {
                // checking for the index value
                if (index == newIndex) {
                  // one button is always set to true
                  isSelected[index] = true;
                } else {
                  // other two will be set to false and not selected
                  isSelected[index] = false;
                }
              }
            });
          },
          children: [
            Container(
              width: size.width * 0.45,
              decoration: const BoxDecoration(
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 6),
                    child: Center(
                        child: HTText(
                            label: "PackageTitle",
                            style: htDarkBlueLargeStyle)),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            HTIcon(iconName: AssetConstants.icons.checkMark),
                            const HorizontalSpace(),
                            Expanded(
                              child: HTText(
                                  label: "Maximum Graft",
                                  style: htSmallLabelStyle),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HTIcon(iconName: AssetConstants.icons.checkMark),
                            const HorizontalSpace(),
                            Expanded(
                              child: HTText(
                                  label: "Gives 100% satisfaction guarantee",
                                  style: htSmallLabelStyle),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HTIcon(iconName: AssetConstants.icons.checkMark),
                            const HorizontalSpace(),
                            Expanded(
                              child: HTText(
                                  label: "2 Nights stay in the Hotel",
                                  style: htSmallLabelStyle),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HTIcon(iconName: AssetConstants.icons.checkMark),
                            const HorizontalSpace(),
                            Expanded(
                              child: HTText(
                                  label: "Checkup and Consultation",
                                  style: htSmallLabelStyle),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width * 0.45,
              decoration: const BoxDecoration(
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 6),
                    child: Center(
                        child: HTText(
                            label: "PackageTitle",
                            style: htDarkBlueLargeStyle)),
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            HTIcon(iconName: AssetConstants.icons.checkMark),
                            const HorizontalSpace(),
                            Expanded(
                              child: HTText(
                                  label: "Maximum Graft",
                                  style: htSmallLabelStyle),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HTIcon(iconName: AssetConstants.icons.checkMark),
                            const HorizontalSpace(),
                            Expanded(
                              child: HTText(
                                  label: "Gives 100% satisfaction guarantee",
                                  style: htSmallLabelStyle),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HTIcon(iconName: AssetConstants.icons.checkMark),
                            const HorizontalSpace(),
                            Expanded(
                              child: HTText(
                                  label: "2 Nights stay in the Hotel",
                                  style: htSmallLabelStyle),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HTIcon(iconName: AssetConstants.icons.checkMark),
                            const HorizontalSpace(),
                            Expanded(
                              child: HTText(
                                  label: "Checkup and Consultation",
                                  style: htSmallLabelStyle),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showSelectedClinic() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Image.network(
              "https://healthwaymedical.com/wp-content/uploads/2022/01/Medico-Clinic-Surgery-1024x681.jpg",
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
                              label: "Vera Clinic",
                              style: htBoldDarkLabelStyle),
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
                      HTText(label: "4.5", style: htBlueLabelStyle),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HTText(
                          label: "Istanbul, Turkiye", style: htBlueLabelStyle),
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
