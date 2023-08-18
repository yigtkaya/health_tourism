import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
import '../../core/constants/vertical_space.dart';
import '../../product/theme/styles.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  DateTime? date = DateTime.now();
  String dateText = 'Date of Birth';
  List gender = ["Male", "Female", "Other"];
  String selectedGender = "";
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: const Color(0xff2D9CDB),
        elevation: 0,
        centerTitle: true,
        title: HTText(
          label: "Profile",
          style: htToolBarLabel,
        ),
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://image.shutterstock.com/image-photo/hospital-interior-operating-surgery-table-260nw-1407429638.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const VerticalSpace(spaceAmount: 26),
                HTText(label: "Personal Information", style: htSubTitle),
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
                              setState(() {});
                            },
                            maxLines: 1,
                            controller: nameController,
                            style: htDarkBlueNormalStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Name",
                              hintStyle: htHintTextDarkStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const HorizontalSpace(spaceAmount: 8),
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
                              setState(() {});
                            },
                            maxLines: 1,
                            controller: surnameController,
                            style: htDarkBlueNormalStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Surname",
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
                        setState(() {});
                      },
                      maxLines: 1,
                      controller: emailController,
                      style: htDarkBlueNormalStyle,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Email",
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
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          addGenderButton(0, gender[0]),
                          const HorizontalSpace(),
                          addGenderButton(1, gender[1]),
                          const HorizontalSpace(),
                          addGenderButton(2, gender[2]),
                        ],
                      ),
                    )),
                const VerticalSpace(),
                GestureDetector(
                  onTap: () async {
                    date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1945),
                      lastDate: DateTime(2025),
                    );
                    if (date == null) {
                      setState(() {
                        dateText = 'Date of Birth';
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: const Color(0xFFD3E3F1).withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 17.0),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget addGenderButton(int index, String title) => GestureDetector(
    onTap: () {
      setState(() {
        selectedIndex = index;
      });
    },
    child: Row(
      children: [
        Container(
          width: 16.0,
          height: 16.0,
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(25.0),
            color: selectedIndex == index ? Colors.blue : Colors.white,
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), color: selectedIndex == index ? Colors.blue : Colors.white,
            ),
          ),
        ),
        const HorizontalSpace(spaceAmount: 8),
        HTText(label: title, style: htDarkBlueLargeStyle),
      ],
    ),
  );
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
}

