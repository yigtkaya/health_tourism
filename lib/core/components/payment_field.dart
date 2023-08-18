import 'package:flutter/material.dart';
import 'package:health_tourism/core/components/ht_text.dart';

import '../../product/theme/styles.dart';
import '../constants/horizontal_space.dart';
import '../constants/vertical_space.dart';

class PaymentField extends StatefulWidget {
  final TextEditingController cardHolderNameController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final TextEditingController cityController;
  final TextEditingController countryController;
  final TextEditingController addressController;
  final TextEditingController postalCodeController;
  const PaymentField({super.key,
    required this.cardHolderNameController,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.cvvController,
    required this.cityController,
    required this.countryController,
    required this.addressController,
    required this.postalCodeController
  });

  @override
  State<PaymentField> createState() => _PaymentFieldState();
}

class _PaymentFieldState extends State<PaymentField> {
  String cardHolderName = "";
  String cardNumber = "";
  String expiryDate = "";
  String cvvCode = "";
  String city = "";
  String country = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HTText(label: "Card Info", style: htDarkBlueLargeStyle),
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
              controller: widget.cardHolderNameController,
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
              controller: widget.cardNumberController,
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
                    controller: widget.expiryDateController,
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
                    controller: widget.cvvController,
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
        const VerticalSpace(spaceAmount: 24,),
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
                    controller: widget.cityController,
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
                    controller: widget.countryController,
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
              controller: widget.addressController,
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
                  address = value;
                });
              },
              maxLines: 1,
              controller: widget.postalCodeController,
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
}
