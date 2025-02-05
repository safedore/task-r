import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/app/router/routr_constants.dart';
import 'package:task_mgmt/src/application/todos/todos_bloc.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/todos_model/todos_model.dart';
import 'package:task_mgmt/src/presentation/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_alert.dart';

import '../../../core/theme/color.dart';
import '../../../core/theme/typography.dart';

class TodosList extends StatefulWidget {
  const TodosList({
    super.key,
    required this.data,
  });

  final List<TodosModel> data;

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        final item = widget.data[index];
        return InkWell(
          borderRadius: BorderRadius.circular(5.r),
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pushNamed(context, RouterConstants.updateTodosRoute,
                arguments: [item]);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Container(
              height: 102.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(color: AppColors.lightGreyColor3),
                color: AppColors.skyBlueColor.withOpacity(0.1),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, top: 12.h, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: 'task-details ${item.id}',
                            child: Text(
                              item.title!,
                              style: AppTypography.rubikRegular.copyWith(
                                fontSize: 14.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        PopupMenuButton(
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                onTap: () {
                                  context.read<TodosBloc>().add(
                                      TodosUpdateCompleteEvent(
                                          id: item.id!,
                                          completed: !item.completed!));
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      item.completed!
                                          ? AppImages.inactiveIcon
                                          : AppImages.activeIcon,
                                      color: item.completed!
                                          ? AppColors.redColor
                                          : AppColors.greenColor,
                                      width: 12.r,
                                      height: 15.r,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                        'Set As ${item.completed! ? 'Pending' : 'Completed'}'),
                                  ],
                                ),
                              ),
                            ];
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 4.w),
                              SvgPicture.asset(
                                item.completed!
                                    ? AppImages.activeIcon
                                    : AppImages.inactiveIcon,
                                color: item.completed!
                                    ? AppColors.greenColor.withOpacity(0.5)
                                    : AppColors.redColor.withOpacity(0.3),
                                width: 12.r,
                                height: 15.r,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      item.description ?? 'No description',
                      style: AppTypography.latoLight.copyWith(
                        fontSize: 12.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: CustomAlertBox(
                                  title:
                                      'Are you sure you want to delete this task?',
                                  onPressed: () {
                                    context
                                        .read<TodosBloc>()
                                        .add(TodosDeleteEvent(id: item.id!));
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                            // context
                            //     .read<TodosBloc>()
                            //     .add(TodosDeleteEvent(id: item.id!));
                          },
                          borderRadius: BorderRadius.circular(5.r),
                          child: SvgPicture.asset(AppImages.deleteIcon,
                              height: 14.h, width: 12.w),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
