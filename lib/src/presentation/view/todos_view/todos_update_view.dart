import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mgmt/app/router/routr_constants.dart';
import 'package:task_mgmt/src/application/core/status.dart';
import 'package:task_mgmt/src/application/todos/todos_bloc.dart';
import 'package:task_mgmt/src/application/users/users_bloc.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/todos_model/todos_model.dart';
import 'package:task_mgmt/src/domain/core/model/data_model/users_model/users_model.dart';
import 'package:task_mgmt/src/presentation/core/values/form_validators.dart';
import 'package:task_mgmt/src/presentation/core/widget/custom_message.dart';
import 'package:task_mgmt/src/presentation/core/widget/customdrop_down.dart';
import 'package:task_mgmt/src/presentation/core/widget/loading.dart';
import 'package:task_mgmt/src/presentation/core/widget/loading_widget.dart';
import 'package:task_mgmt/src/presentation/core/widget/primary_button.dart';
import 'package:task_mgmt/src/presentation/core/widget/todo_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_mgmt/src/presentation/view/todos_view/widget/custom_drop_down.dart';
import '../../core/constants/string.dart';
import '../../core/theme/color.dart';
import '../../core/widget/custom_appbar.dart';

class TodosUpdateView extends StatefulWidget {
  const TodosUpdateView({super.key, required this.data});

  final TodosModel data;

  @override
  State<TodosUpdateView> createState() => _TodosUpdateViewState();
}

class _TodosUpdateViewState extends State<TodosUpdateView> {
  final formKey = GlobalKey<FormState>();

  get data => widget.data;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priorityController = TextEditingController();
  final _dueDate = TextEditingController();
  String selectedStatus = '';
  int? selectedUser;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityController.dispose();
    _dueDate.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context.read<UsersBloc>().add(const UsersListEvent());
    _titleController.text = data.title ?? '';
    _descriptionController.text = data.description ?? '';
    _priorityController.text = data.priority ?? '';
    _dueDate.text = data.dueDate ?? '';
    selectedStatus = data.status ?? '';
    selectedUser = data.userId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodosBloc, TodosState>(
      listenWhen: (previous, current) =>
          previous.todosUpdateStatus != current.todosUpdateStatus,
      listener: (context, state) {
        if (state.todosUpdateStatus is StatusLoading) {
          CustomLoading(context: context).show();
        } else if (state.todosUpdateStatus is StatusSuccess) {
          CustomLoading.dissmis(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouterConstants.todosRoute,
            (route) => false,
          );
        } else if (state.todosUpdateStatus is StatusFailure) {
          CustomLoading.dissmis(context);
          CustomMessage(
            context: context,
            message: 'Failed to update task',
            style: MessageStyle.error,
          ).show();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: const CustomAppBar(
          title: AppStrings.todo,
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 16.w, top: 10.h, right: 16.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Hero(
                    tag: 'task-details ${data.id}',
                    child: SizedBox(height: 9.h),
                  ),
                  _buildTextField(
                      AppStrings.title, _titleController, 'Enter your title'),
                  _buildTextField(AppStrings.description,
                      _descriptionController, AppStrings.description),
                  CustomDropdown(
                    items: const ['High', 'Medium', 'Low'],
                    hintText: _priorityController.text.isNotEmpty
                        ? _priorityController.text
                        : 'Choose Priority',
                    label: AppStrings.priority,
                    onChanged: (value) {
                      _priorityController.text = value!;
                    },
                  ),
                  SizedBox(height: 9.h),
                  _buildTextField(
                      AppStrings.dueDate, _dueDate, 'Enter due date'),
                  CustomDropdown(
                    items: const ['Todo', 'In progress', 'Done'],
                    hintText: selectedStatus.isNotEmpty
                        ? selectedStatus
                        : 'Choose Status',
                    label: AppStrings.status,
                    onChanged: (value) {
                      selectedStatus = value!;
                    },
                  ),
                  SizedBox(height: 9.h),
                  BlocBuilder<UsersBloc, UsersState>(
                      buildWhen: (previous, current) =>
                          previous.usersListStatus != current.usersListStatus,
                      builder: (context, state) {
                        if (state.usersListStatus is StatusLoading) {
                          return LoadingWidget(
                            length: 1,
                            height: 55.h,
                          );
                        } else if (state.usersListStatus is StatusSuccess) {
                          List<UsersModel> data = state.usersList;

                          if (data.isEmpty) {
                            return CustomModelDropDown(
                              valueList: const [],
                              title: AppStrings.users,
                              hintText: 'No users found',
                              onSelected: (value) {},
                            );
                          }
                          return CustomModelDropDown(
                            valueList: data,
                            title: AppStrings.users,
                            hintText: 'Select users to assign',
                            selectedItem: selectedUser,
                            onSelected: (value) {
                              selectedUser = value!.id;
                            },
                          );
                        } else if (state.usersListStatus is StatusFailure) {
                          return CustomModelDropDown(
                            valueList: const [],
                            title: AppStrings.users,
                            hintText: 'No users found',
                            onSelected: (value) {},
                          );
                        }
                        return Container();
                      }),
                  SizedBox(height: 35.h),
                  PrimaryButton(
                    width: MediaQuery.of(context).size.width - 32.w,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (selectedStatus == '' ||
                            selectedUser == null ||
                            _priorityController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please select ${selectedStatus == '' ? 'Status' : _priorityController.text.isEmpty ? 'Priority' : 'User'}'),
                            ),
                          );
                          return;
                        }
                        final todos = TodosModel(
                          id: data.id,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dueDate: _dueDate.text,
                          status: selectedStatus,
                          priority: _priorityController.text,
                          userId: selectedUser,
                          completed: false,
                        );
                        context
                            .read<TodosBloc>()
                            .add(TodosUpdateEvent(todosModel: todos));
                      }
                    },
                    title: 'Save',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ToDoTextField(
          controller: controller,
          errorMessage: 'please enter ${label.toLowerCase()}',
          keyboardType: TextInputType.text,
          hintText: hintText,
          readOnly: label == 'Date of Purchase',
          validator: TextFieldValidation.emptyValidate,
          onTap: () {
            if (label == 'Due Date') {
              _showDatePicker();
            }
          },
          label: label,
          maxLines: label == 'Description' ? 6 : 1,
          textCapitalization: TextCapitalization.sentences,
        ),
        SizedBox(height: 9.h),
      ],
    );
  }

  void _showDatePicker() {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2200),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: isDarkMode
                  ? const ColorScheme.dark(primary: AppColors.primaryColor)
                  : const ColorScheme.light(primary: AppColors.primaryColor),
            ),
            child: child!,
          );
        }).then((value) {
      if (value != null) {
        _dueDate.text = value.toString().split(' ')[0];
      }
    });
  }
}
