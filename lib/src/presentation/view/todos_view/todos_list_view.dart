import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/app/router/routr_constants.dart';
import 'package:task_mgmt/src/application/auth/auth_bloc.dart';
import 'package:task_mgmt/src/application/core/status.dart';
import 'package:task_mgmt/src/application/todos/todos_bloc.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/todos_model/todos_model.dart';
import 'package:task_mgmt/src/presentation/core/widget/app_bar_actions.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_alert.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_message.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_placeholder.dart';
import 'package:task_mgmt/src/presentation/core/widget/loading.dart';
import 'package:task_mgmt/src/presentation/core/widget/loading_widget.dart';
import 'package:task_mgmt/src/presentation/view/todos_view/widget/todos_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/app_images.dart';
import '../../core/constants/string.dart';
import '../../core/theme/color.dart';
import '../../core/theme/typography.dart';
import '../../core/widget/custom_appbar.dart';

class TodosListView extends StatefulWidget {
  const TodosListView({super.key});

  @override
  State<TodosListView> createState() => _TodosListViewState();
}

class _TodosListViewState extends State<TodosListView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  int limit = 5;
  int page = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _refreshPage();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _refreshPage() async {
    setState(() {
      page = 0;
      limit = 5;
    });
    context.read<TodosBloc>().add(const TodosListEvent(
          offset: 0,
          limit: 5,
          isRefresh: true,
        ));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        page += limit;
      });
      context.read<TodosBloc>().add(TodosListEvent(
            offset: page,
            limit: limit,
            isRefresh: false,
          ));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TodosBloc, TodosState>(
          listenWhen: (previous, current) =>
              previous.todosDeleteStatus != current.todosDeleteStatus,
          listener: (context, state) {
            if (state.todosDeleteStatus is StatusLoading) {
              CustomLoading(context: context).show();
            } else if (state.todosDeleteStatus is StatusSuccess) {
              CustomLoading.dissmis(context);
              CustomMessage(
                context: context,
                message: 'Task Removed',
              ).show();
              _refreshPage();
              // } else if (state.todosDeleteStatus is StatusFailure) {
            } else {
              CustomLoading.dissmis(context);
              CustomMessage(
                context: context,
                message: 'Failed to delete task',
                style: MessageStyle.warning,
              ).show();
            }
          },
        ),
        BlocListener<TodosBloc, TodosState>(
          listenWhen: (previous, current) =>
              previous.todosUpdateCompleteStatus !=
              current.todosUpdateCompleteStatus,
          listener: (context, state) {
            if (state.todosUpdateCompleteStatus is StatusLoading) {
              CustomLoading(context: context).show();
            } else if (state.todosUpdateCompleteStatus is StatusSuccess) {
              CustomLoading.dissmis(context);
              _refreshPage();
            } else {
              CustomLoading.dissmis(context);
              CustomMessage(
                context: context,
                message: 'Failed to update task state',
                style: MessageStyle.warning,
              ).show();
            }
          },
        ),
      ],
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: CustomAlertBox(
                title: 'Exit and quit the app?',
                onPressed: () {
                  SystemNavigator.pop(animated: true);
                },
              ),
            ),
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CustomAppBar(
            title: 'Todos',
            imagePath: AppImages.todoIcon,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarActions(
                  icon: AppImages.profileUnfilledIcon,
                  onPressed: () {
                    Navigator.pushNamed(context, RouterConstants.profileRoute);
                  },
                  tag: 'profile',
                ),
                AppBarActions(
                  tag: 'dialog',
                  icon: AppImages.logoutIcon,
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
              ],
            ),
          ),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshPage,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, top: 10.h, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.myTodos,
                        style: AppTypography.rubikRegular.copyWith(
                          fontSize: 17.sp,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          _refreshPage();
                        },
                        icon: SvgPicture.asset(
                          AppImages.refreshIcon,
                          width: 6.r,
                          height: 11.r,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  BlocBuilder<TodosBloc, TodosState>(
                    buildWhen: (previous, current) =>
                        previous.todosListStatus != current.todosListStatus ||
                        previous.todosList != current.todosList,
                    builder: (context, state) {
                      if (state.todosListStatus is StatusLoading) {
                        return const Expanded(
                          child: LoadingWidget(length: 5),
                        );
                      } else if (state.todosListStatus is StatusSuccess) {
                        List<TodosModel> data = state.todosList;
                        final count = state.totalCount;
                        return count == 0
                            ? const CustomPlaceholder()
                            : Expanded(
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: data.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index < data.length) {
                                      return TodosList(data: [data[index]]);
                                    } else {
                                      return page + limit >= count
                                          ? const SizedBox()
                                          : LoadingWidget(
                                              length: 1,
                                              height: 90.h,
                                            );
                                    }
                                  },
                                ),
                              );
                      }
                      return const Center(child: CustomPlaceholder());
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouterConstants.createTodosRoute);
                        },
                        child: Hero(
                          tag: 'hero-fab',
                          transitionOnUserGestures: true,
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor:
                                AppColors.primaryColor.withOpacity(0.7),
                            child: SvgPicture.asset(
                              AppImages.addIcon,
                              width: 25.r,
                              height: 25.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
