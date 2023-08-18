import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/cubit/payment/payment_cubit.dart';
import 'package:health_tourism/cubit/payment/payment_state.dart';
import 'package:health_tourism/product/models/package.dart';

import '../../core/components/dialog/package_detail_dialog.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
import '../../core/constants/vertical_space.dart';
import '../../product/models/buyer.dart';
import '../../product/navigation/route_paths.dart';
import '../../product/theme/styles.dart';

class PaymentView extends StatefulWidget {
  Buyer? buyer;
  Package? package;
  double? price;

  PaymentView(this.buyer, this.package, this.price, {super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  List<bool> isSelected = [true, false];
  DateTime? date = DateTime.now();
  String dateText = "Select a Date";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showSelectedClinic(),
              const VerticalSpace(
                spaceAmount: 24,
              ),
              HTText(label: "Packages", style: htTitleStyle),
              const VerticalSpace(
                spaceAmount: 12,
              ),
              togglePackages(),
              const VerticalSpace(
                spaceAmount: 24,
              ),
              HTText(label: "Choose Date", style: htSubTitle),
              const VerticalSpace(),
              // create date picker
              datePicker(),
              const VerticalSpace(
                spaceAmount: 32,
              ),
              HTText(label: "Payment Details", style: htSubTitle),
              const VerticalSpace(),
              paymentDetail(),
              const VerticalSpace(),
              const Divider(
                color: Color(0xffD3E3F1),
                thickness: 1,
              ),
              const Spacer(),
              totalButtonRow(),
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

  Widget totalButtonRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HTText(label: "Total", style: htHintTextStyle),
              const VerticalSpace(
                spaceAmount: 4,
              ),
              HTText(label: "\$24.8", style: htTitleStyle),
            ],
          ),
        ),
        const HorizontalSpace(),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.push(RoutePath.payment);
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff58a2eb)),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 14.0),
                  child: Center(
                    child: HTText(
                        label: 'Checkout', style: htBoldLabelStyle),
                  ),
                )),
          ),
        ),
      ],
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
        const VerticalSpace(),
        Row(
          children: [
            HTText(label: "selectedPackageName", style: htDarkBlueNormalStyle),
            const Spacer(),
            HTText(label: "\$24.8", style: htDarkBlueNormalStyle),
          ],
        ),
        const VerticalSpace(),
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

  Widget togglePackages() {
    return Center(
      child: ToggleButtons(
        isSelected: isSelected,
        renderBorder: true,
        borderColor: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
        selectedBorderColor: Colors.blue,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: HTText(
              label: "Regular Package",
              style: htBlueLabelStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: HTText(
              label: "Exclusive Package",
              style: htBlueLabelStyle,
            ),
          ),
        ],
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
