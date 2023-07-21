import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tourism/cubit/profile/profile_cubit.dart';
import 'package:health_tourism/cubit/profile/profile_cubit_state.dart';
import 'package:health_tourism/product/models/customer.dart';

import '../../core/components/ht_text.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Customer customer;

  @override
  void initState() {
    // TODO: implement initState
     context.read<ProfileCubit>().getUserData();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoadedState) {
          // return customer data in the screen

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProfileCubit>().getUserData();
             },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HTText.labelMedium(state.costumer.fullName, context: context)
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
