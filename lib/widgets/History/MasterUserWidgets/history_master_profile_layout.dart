import 'package:flutter/material.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/viewmodels/Exam/exam_history_download_view_model.dart';
import 'package:plu_trainer/widgets/History/MasterUserWidgets/history_button_download.dart';
import 'package:plu_trainer/widgets/History/MasterUserWidgets/history_datepicker.dart';
import 'package:plu_trainer/widgets/History/history_combination_view.dart';
import 'package:provider/provider.dart';
import 'package:plu_trainer/viewmodels/History/profile_with_role_view_model.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/widgets/History/MasterUserWidgets/history_profile_button.dart';

class HistoryMasterProfileLayout extends StatefulWidget {
  const HistoryMasterProfileLayout({super.key});

  @override
  State<HistoryMasterProfileLayout> createState() =>
      _HistoryMasterProfileLayoutState();
}

class _HistoryMasterProfileLayoutState
    extends State<HistoryMasterProfileLayout> {
  int? _selectedSuperkey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  void init() {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    if (loginViewModel.isAuthorized) {
      Provider.of<ProfileWithRoleViewModel>(context, listen: false)
          .fetchProfilesWithRoles();
    }
    final examHistoryDownloadViewModel =
        Provider.of<ExamHistoryDownloadViewModel>(context, listen: false);
    examHistoryDownloadViewModel.resetDates();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileWithRoleViewModel>(context);
    final examHistoryDownloadViewModel =
        Provider.of<ExamHistoryDownloadViewModel>(context);

    final loginViewModel = Provider.of<LoginViewModel>(context);

    if (_selectedSuperkey != null) {
      return HistoryCombinationView(superkey: _selectedSuperkey!);
    }

    return Align(
      alignment: Alignment.topCenter,
      child: loginViewModel.isAuthorized
          ? viewModel.isLoading
              ? const CircularProgressIndicator()
              : viewModel.errorMessage != null
                  ? Text('Error: ${viewModel.errorMessage}')
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Historial grobal',
                            style: Fonts.historyViewTitleTextStyle,
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Fecha inicial:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: HistoryDatepicker(
                                    onDateSelected: (dateTime) {
                                  examHistoryDownloadViewModel
                                      .setStartDate(dateTime);
                                }),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Fecha final:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: HistoryDatepicker(
                                    onDateSelected: (dateTime) {
                                  examHistoryDownloadViewModel
                                      .setEndDate(dateTime);
                                }),
                              ),
                              HistoryButtonDownload(
                                downloadHistory: () {
                                  examHistoryDownloadViewModel
                                      .fetchExamHistory();
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  examHistoryDownloadViewModel.error ?? '',
                                  style: Fonts.errorMessageFont,
                                ),
                              )
                            ],
                          ),
                          Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            children: List.generate(
                              viewModel.profilesWithRoles.length,
                              (index) {
                                final profileWithRoles =
                                    viewModel.profilesWithRoles[index];
                                final profileName =
                                    profileWithRoles.profile.name;
                                final profileSuperkey =
                                    profileWithRoles.profile.superkey;
                                final role = profileWithRoles.roles.isNotEmpty
                                    ? profileWithRoles.roles.first.roleName
                                    : 'No role';

                                return HistoryProfileButton(
                                  name: profileName,
                                  rol: role,
                                  onTap: () {
                                    setState(() {
                                      _selectedSuperkey = profileSuperkey;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
          : HistoryCombinationView(superkey: loginViewModel.superkeyValue ?? 0),
    );
  }
}
