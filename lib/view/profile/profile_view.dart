import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_tourism/core/components/ht_icon.dart';
import 'package:health_tourism/core/constants/asset.dart';
import 'package:health_tourism/core/constants/vertical_space.dart';
import 'package:health_tourism/cubit/auth/auth_cubit.dart';
import 'package:health_tourism/cubit/profile/profile_cubit.dart';
import 'package:health_tourism/cubit/profile/profile_cubit_state.dart';
import 'package:health_tourism/product/models/user.dart';
import 'package:health_tourism/product/navigation/route_paths.dart';
import 'package:health_tourism/product/navigation/router.dart';
import 'package:health_tourism/product/utils/skelton.dart';

import '../../core/components/ht_text.dart';
import '../../core/constants/horizontal_space.dart';
import '../../product/theme/styles.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late IUser user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
        title: HTText(
          label: "My Profile",
          style: htToolBarLabel,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalSpace(
                spaceAmount: 30,
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoadingState) {
                    return Column(
                      children: [
                        const CircleSkeleton(
                          size: 100,
                        ),
                        const VerticalSpace(),
                        Skeleton(
                          height: 12,
                          width: size.width * 0.5,
                        ),
                        const VerticalSpace(),
                        Skeleton(
                          height: 12,
                          width: size.width * 0.5,
                        ),
                        const VerticalSpace(
                          spaceAmount: 40,
                        ),
                      ],
                    );
                  }

                  if (state is ProfileLoadedState) {
                    return userInfo(state, size);
                  } else {
                    return const Center(
                      child: HTText(
                          label: "Something went wrong",
                          style: htLabelBlackStyle),
                    );
                  }
                },
              ),
              const VerticalSpace(
                spaceAmount: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: settings.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: index == 5
                            ? () {
                                context.read<AuthCubit>().signOut();
                              }
                            : () {
                                context.pushNamed(
                                  '/${settings[index].toString().replaceAll(" ", "")}',
                                  queryParameters: {'title': settings[index]}, extra: user
                                );
                                print("object");
                              },
                        child: getSettings(
                            iconList[index], settings[index], index));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  List settings = [
    "Personal Info",
    "My Appointments",
    "My Favorites",
    "Payment Methods",
    "Help",
    "Log Out",
  ];

  List iconList = [
    AssetConstants.icons.profileUnSelected,
    AssetConstants.icons.emptyStar,
    AssetConstants.icons.appointment,
    AssetConstants.icons.payment,
    AssetConstants.icons.help,
    AssetConstants.icons.logout,
  ];

  Widget userInfo(ProfileLoadedState state, Size size) {
    return StreamBuilder(
        stream: state.userSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                const CircleSkeleton(
                  size: 100,
                ),
                const VerticalSpace(),
                Skeleton(
                  height: 12,
                  width: size.width * 0.5,
                ),
                const VerticalSpace(),
                Skeleton(
                  height: 12,
                  width: size.width * 0.5,
                ),
              ],
            );
          }
          if (snapshot.hasData) {
            Map<String, dynamic> data =
            snapshot.data?.data() as Map<String, dynamic>;
            user = IUser.fromData(data);
            return Column(
              children: [
                Container(
                  height: size.height * 0.16,
                  width: size.height * 0.16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: user.profilePhoto,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Text("Unable to load this image"),
                      ),
                    ),
                ),
                const VerticalSpace(),
                HTText(
                    label: '${user.name} ${user.surname}', style: htTitleStyle),
                HTText(label: user.email, style: htBlueLabelStyle),
              ],
            );
          }

          return Column(
            children: [
              const CircleSkeleton(
                size: 100,
              ),
              const VerticalSpace(),
              Skeleton(
                height: 12,
                width: size.width * 0.5,
              ),
              const VerticalSpace(),
              Skeleton(
                height: 12,
                width: size.width * 0.5,
              ),
            ],
          );
        });
  }

  Widget getSettings(String iconName, String label, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              HTIcon(
                iconName: iconName,
                width: 32,
                height: 32,
                color: const Color(0xff123258),
              ),
              const HorizontalSpace(spaceAmount: 16),
              HTText(label: label, style: htDarkBlueBoldLargeStyle),
              const Spacer(),
              index == 5
                  ? const SizedBox.shrink()
                  : HTIcon(
                      iconName: AssetConstants.icons.chevronRight,
                      color: const Color(0xff123258),
                      width: 16,
                      height: 16),
            ],
          ),
          index == 5
              ? const SizedBox.shrink()
              : const Divider(
                  color: Color(0xffd3e3f1),
                  thickness: 2,
                ),
        ],
      ),
    );
  }
}
