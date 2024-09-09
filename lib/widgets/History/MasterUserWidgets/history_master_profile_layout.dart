// import 'package:flutter/material.dart';
// import 'package:plu_trainer/widgets/History/history_profile_layout.dart';
// import 'package:provider/provider.dart';
// import 'package:plu_trainer/viewmodels/History/profile_with_role_view_model.dart';
// import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
// import 'package:plu_trainer/widgets/History/MasterUserWidgets/history_profile_button.dart';

// class HistoryMasterProfileLayout extends StatefulWidget {
//   const HistoryMasterProfileLayout({super.key});

//   @override
//   State<HistoryMasterProfileLayout> createState() =>
//       _HistoryMasterProfileLayoutState();
// }

// class _HistoryMasterProfileLayoutState
//     extends State<HistoryMasterProfileLayout> {
//   int? _selectedSuperkey;

//   @override
//   void initState() {
//     super.initState();
//     final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
//     if (loginViewModel.isAuthorized) {
//       Provider.of<ProfileWithRoleViewModel>(context, listen: false)
//           .fetchProfilesWithRoles();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = Provider.of<ProfileWithRoleViewModel>(context);
//     final loginViewModel = Provider.of<LoginViewModel>(context);

//     if (_selectedSuperkey != null) {
//       return Expanded(
//         child: HistoryProfileLayout(superkey: _selectedSuperkey!),
//       );
//     }

//     return Align(
//       alignment: Alignment.topCenter,
//       child: loginViewModel.isAuthorized
//           ? viewModel.isLoading
//               ? const CircularProgressIndicator()
//               : viewModel.errorMessage != null
//                   ? Text('Error: ${viewModel.errorMessage}')
//                   : Expanded(
//                       child: SingleChildScrollView(
//                         child: Wrap(
//                           spacing: 4.0,
//                           runSpacing: 4.0,
//                           children: List.generate(
//                             viewModel.profilesWithRoles.length,
//                             (index) {
//                               final profileWithRoles =
//                                   viewModel.profilesWithRoles[index];
//                               final profileName = profileWithRoles.profile.name;
//                               final profileSuperkey = profileWithRoles.profile
//                                   .superkey; // Aquí tomamos la superkey del perfil seleccionado
//                               final role = profileWithRoles.roles.isNotEmpty
//                                   ? profileWithRoles.roles.first.roleName
//                                   : 'No role';
//                               final roleId = profileWithRoles.roles.isNotEmpty
//                                   ? profileWithRoles.roles.first.id
//                                   : 0;

//                               return HistoryProfileButton(
//                                 name: profileName,
//                                 rol: role,
//                                 selectColor: roleId - 1,
//                                 onTap: () {
//                                   setState(() {
//                                     _selectedSuperkey = profileSuperkey;
//                                   });
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     )
//           : Expanded(
//               child: HistoryProfileLayout(
//                 superkey: loginViewModel.superkeyValue ?? 0,
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plu_trainer/widgets/History/history_profile_layout.dart';
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
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    if (loginViewModel.isAuthorized) {
      Provider.of<ProfileWithRoleViewModel>(context, listen: false)
          .fetchProfilesWithRoles();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileWithRoleViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);

    if (_selectedSuperkey != null) {
      return HistoryProfileLayout(superkey: _selectedSuperkey!);
    }

    return Align(
      alignment: Alignment.topCenter,
      child: loginViewModel.isAuthorized
          ? viewModel.isLoading
              ? const CircularProgressIndicator()
              : viewModel.errorMessage != null
                  ? Text('Error: ${viewModel.errorMessage}')
                  : SingleChildScrollView(
                      child: Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: List.generate(
                          viewModel.profilesWithRoles.length,
                          (index) {
                            final profileWithRoles =
                                viewModel.profilesWithRoles[index];
                            final profileName = profileWithRoles.profile.name;
                            final profileSuperkey =
                                profileWithRoles.profile.superkey;
                            final role = profileWithRoles.roles.isNotEmpty
                                ? profileWithRoles.roles.first.roleName
                                : 'No role';
                            final roleId = profileWithRoles.roles.isNotEmpty
                                ? profileWithRoles.roles.first.id
                                : 0;

                            return HistoryProfileButton(
                              name: profileName,
                              rol: role,
                              selectColor: roleId - 1,
                              onTap: () {
                                setState(() {
                                  _selectedSuperkey = profileSuperkey;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    )
          : HistoryProfileLayout(
              superkey: loginViewModel.superkeyValue ?? 0,
            ),
    );
  }
}
