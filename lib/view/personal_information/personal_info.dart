import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/cubit/profile/profile_cubit.dart';
import 'package:health_tourism/cubit/profile/profile_cubit_state.dart';
import 'package:health_tourism/product/utils/skelton.dart';
import 'package:health_tourism/view/sign_up/sign_up_view.dart';
import '../../core/components/dialog/image_picker.dart';
import '../../core/components/ht_icon.dart';
import '../../core/components/ht_text.dart';
import '../../core/constants/asset.dart';
import '../../core/constants/horizontal_space.dart';
import '../../core/constants/vertical_space.dart';
import '../../product/models/user.dart';
import '../../product/theme/styles.dart';
import 'package:recase/recase.dart';

class PersonalInfoView extends StatefulWidget {
  final User user;
  const PersonalInfoView({super.key, required this.user});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController chronic = TextEditingController();
  final TextEditingController allergies = TextEditingController();
  final TextEditingController medications = TextEditingController();
  final TextEditingController surgeries = TextEditingController();
  final TextEditingController diseases = TextEditingController();
  final TextEditingController hairTransplantation = TextEditingController();
  final TextEditingController supplements = TextEditingController();
  final TextEditingController alcoholOrSmoking = TextEditingController();

  DateTime? date = DateTime.now();
  String dateText = 'Date of Birth';
  List gender = ["Male", "Female", "Other"];
  late String selectedGender;
  late int selectedIndex;
  late User forImg;
  bool isChanged = false;

  final changes = <dynamic, dynamic>{};
  @override
  void initState() {
    super.initState();
    initTextFields();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  try {
                    changes["uid"] = widget.user.uid;
                    context.read<ProfileCubit>().updateUser(changes);
                    setState(() {
                      isChanged = false;
                      changes.clear();
                    });
                  } catch (e) {
                    showToastMessage("An error happened during the update please try again");
                  }
                },
                child: Center(
                  child: HTText(
                    label: "Save",
                    style: isChanged
                        ? htToolBarLabel
                        : htToolBarLabel.copyWith(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          ],
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
          top: false,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                    if (state is ProfileLoadedState) {
                      return buildView(state, size);
                    }
                    if (state is ProfileErrorState) {
                      return Center(
                        child: HTText(
                          label: "Couldn't load the image",
                          color: Colors.white,
                          style: htHintTextDarkStyle,
                        ),
                      );
                    }
                    if (state is ProfileLoadingState) {
                      return Center(
                        child: CircleSkeleton(
                          size: size.width * 0.3,
                        ),
                      );
                    } else {
                      return Center(
                        child: CircleSkeleton(
                          size: size.width * 0.3,
                        ),
                      );
                    }
                  }),
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
                                changed();
                                changes["name"] = nameController.text;
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
                                changed();
                                changes["surname"] = surnameController.text;
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
                          changed();
                          changes["email"] = emailController.text;
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
                        initialDate: widget.user.birthday.toDate(),
                        firstDate: DateTime(1945),
                        lastDate: DateTime.now(),
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
                        changed();
                        changes["birthday"] = Timestamp.fromDate(date!);
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
                  const VerticalSpace(
                    spaceAmount: 32,
                  ),
                  HTText(label: "Medical Information", style: htSubTitle),
                  const VerticalSpace(
                    spaceAmount: 16,
                  ),
                  questionAndAnswer(
                      chronic,
                      "1. Does the patient have any chronic conditions? (Ex: heart disease, diabetes, high blood pressure, etc.). Please provide details.",
                      "Chronic Conditions"),
                  const VerticalSpace(
                    spaceAmount: 16,
                  ),
                  questionAndAnswer(
                      allergies,
                      "2.	Does the patient have any allergies or sensitivities? Please provide details.",
                      "Allergies"),
                  const VerticalSpace(
                    spaceAmount: 16,
                  ),
                  questionAndAnswer(
                      medications,
                      "3.	Is the patient currently taking any medications? (Ex: Especially blood thinners or immunosuppressive drugs, etc.). Please provide details.",
                      "Medications"),
                  const VerticalSpace(
                    spaceAmount: 16,
                  ),
                  questionAndAnswer(
                      diseases,
                      "4.	Does the patient have any infections or skin diseases on the scalp? (Ex: eczema, fungal infections, psoriasis, etc.). Please provide details.",
                      "Diseases"),
                  const VerticalSpace(
                    spaceAmount: 16,
                  ),
                  questionAndAnswer(
                      surgeries,
                      "5.	Does the patient have a surgical operation history? Please provide details.",
                      "Surgery History"),
                  const VerticalSpace(
                    spaceAmount: 16,
                  ),
                  questionAndAnswer(
                      alcoholOrSmoking,
                      "6.	Does the patient have a history of smoking or alcohol consumption? ",
                      "Alcohol or Smoking"),
                  const VerticalSpace(
                    spaceAmount: 16,
                  ),
                  questionAndAnswer(
                      hairTransplantation,
                      "7.	Has the patient undergone any previous hair transplantation procedures? Please provide details.",
                      "Hair Transplantation"),
                  const VerticalSpace(
                    spaceAmount: 16,
                  ),
                  questionAndAnswer(
                      supplements,
                      "8.	Does the patient take any supplements or herbal products? Please provide details.",
                      "Supplements"),
                  const VerticalSpace(
                    spaceAmount: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildView(ProfileLoadedState state, Size size) {
    return StreamBuilder(
        stream: state.userSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircleSkeleton(
                size: size.width * 0.3,
              ),
            );
          }
          Map<String, dynamic> data =
              snapshot.data?.data() as Map<String, dynamic>;
          forImg = User.fromData(data);

          return Center(
            child: Stack(
              children: [
                Container(
                  width: size.width * 0.35,
                  height: size.width * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(forImg.profilePhoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(context: context, builder: (BuildContext context) {
                        return ImagePickerDialog(uid: forImg.uid);
                      });
                    },
                    child: Container(
                          height: size.height * 0.04,
                          width: size.height * 0.04,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff2D9CDB),
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget addGenderButton(int index, String title) => GestureDetector(
        onTap: () {
          changed();
          setState(() {
            changed();
            selectedIndex = index;
            selectedGender = gender[index];
          });
          changes["gender"] = selectedGender;
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
                  borderRadius: BorderRadius.circular(10.0),
                  color: selectedIndex == index ? Colors.blue : Colors.white,
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

  Widget questionAndAnswer(
      TextEditingController controller, String question, String labelText) {
    return Column(
      children: [
        HTText(label: question, style: htDarkBlueNormalStyle),
        const VerticalSpace(
          spaceAmount: 6,
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
                changed();
                labelText = labelText.replaceAll(" ", "").camelCase;
                changes[labelText] = controller.text;
              },
              minLines: 1,
              maxLines: 3,
              controller: controller,
              style: htDarkBlueNormalStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labelText,
                hintStyle: htHintTextDarkStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void changed() {
    setState(() {
      isChanged = true;
    });
  }

  void initTextFields() {
    nameController.text = widget.user.name;
    surnameController.text = widget.user.surname;
    emailController.text = widget.user.email;
    medications.text = widget.user.medications;
    chronic.text = widget.user.chronicConditions;
    allergies.text = widget.user.allergies;
    surgeries.text = widget.user.surgeryHistory;
    diseases.text = widget.user.skinDiseases;
    hairTransplantation.text = widget.user.hairTransplantOperations;
    alcoholOrSmoking.text = widget.user.alcoholOrSmoke;
    supplements.text = widget.user.supplements;
    selectedGender = widget.user.gender;
    selectedIndex = gender.indexOf(selectedGender);
    date = widget.user.birthday.toDate();
    dateText = "${date?.day} ${monthFromInt(date!.month)}, ${date?.year}";
  }
}
