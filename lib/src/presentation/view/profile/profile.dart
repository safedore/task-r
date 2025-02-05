import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/app/router/routr_constants.dart';
import 'package:task_mgmt/src/application/auth/auth_bloc.dart';
import 'package:task_mgmt/src/application/core/status.dart';
import 'package:task_mgmt/src/application/users/users_bloc.dart';
import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';
import 'package:task_mgmt/src/presentation/core/constants/string.dart';
import 'package:task_mgmt/src/presentation/core/theme/color.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_alert.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_appbar.dart';
import 'package:task_mgmt/src/presentation/core/widget/loading_widget.dart';
import 'package:task_mgmt/src/presentation/view/profile/widget/account_info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/widget/app_bar_actions.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    context.read<UsersBloc>().add(const UsersProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      buildWhen: (previous, current) =>
          previous.usersProfileStatus != current.usersProfileStatus,
      builder: (context, state) {
        int loadState = state.usersProfileStatus is StatusSuccess
            ? 1
            : state.usersProfileStatus is StatusFailure
                ? 2
                : (state.usersProfileStatus is StatusLoading ||
                        state.usersProfileStatus is StatusInitial)
                    ? 3
                    : 0;
        return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: const CustomAppBar(
              title: AppStrings.profile,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'profile',
                      child: loadState == 2
                          ? SizedBox(
                              width: 90.w,
                              child: LoadingWidget(length: 1, height: 40.h))
                          : CircleAvatar(
                              radius: 90.r,
                              backgroundColor: AppColors.whiteColor,
                              backgroundImage: loadState == 3
                                  ? null
                                  : NetworkImage(state.usersProfile.avatar!),
                            ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AccountInfoTile(
                      title:
                          '${state.usersProfile.firstName ?? 'Anonymous'} ${state.usersProfile.lastName ?? 'User'}',
                      iconPath: AppImages.profileUnfilledIcon,
                    ),
                    AccountInfoTile(
                      title: state.usersProfile.email ?? 'No Email',
                      iconPath: AppImages.emailIcon,
                    ),
                    SizedBox(height: 23.h),
                    SizedBox(
                      height: 53.h,
                    ),
                    AppBarActions(
                      tag: 'dialog',
                      icon: AppImages.logoutIcon,
                      height: 53.h,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Hero(
                            tag: 'dialog',
                            child: Dialog(
                              child: CustomAlertBox(
                                title: 'Logout',
                                onPressed: () {
                                  AuthBloc.logout().then((_) {
                                    if (context.mounted) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouterConstants.loginRoute,
                                        (route) => false,
                                      );
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ]),
            ));
      },
    );
  }
}
