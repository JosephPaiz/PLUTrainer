import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/core/style/custom_colors.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/services/navigation_service.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_button.dart';
import 'package:plu_trainer/viewmodels/sidebar_view_model.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/widgets/contract_button.dart';
import 'package:provider/provider.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SidebarMenuState createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  @override
  void initState() {
    super.initState();
    _loadSuperkeyAndInitialize();
  }

  Future<void> _loadSuperkeyAndInitialize() async {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final superkey = loginViewModel.superkeyValue;

    if (superkey != null) {
      final sideBarViewModel =
          Provider.of<SideBarViewModel>(context, listen: false);
      await sideBarViewModel.initialize(superkey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sideBarViewModel = Provider.of<SideBarViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);

    if (!sideBarViewModel.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: sideBarViewModel.isOpenSideBar ? 250 : 90,
      decoration: const BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Text(
                  sideBarViewModel.isOpenSideBar
                      ? LocalizationsEsp.titleApp
                      : 'PT',
                  style: Fonts.sidebarTitleTextStyle,
                ),
                sideBarViewModel.isOpenSideBar
                    ? (sideBarViewModel.profileName != null
                        ? Text(
                            sideBarViewModel.profileName!,
                            style: const TextStyle(
                                fontSize: 14, color: CustomColors.darkGreen),
                          )
                        : const CircularProgressIndicator())
                    : const Text(
                        '',
                        style: TextStyle(
                            fontSize: 14, color: CustomColors.darkGreen),
                      ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SideBarButton(
                  icon: HugeIcons.strokeRoundedHome11,
                  text: LocalizationsEsp.homeButton,
                  index: 0,
                  isSelected: sideBarViewModel.selectedIndex == 0,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  onTap: () {
                    sideBarViewModel.selectIndex(0);
                    NavigationService.navigateTo(context, '/home');
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedBlockGame,
                  text: LocalizationsEsp.trainingButton,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  index: 1,
                  isSelected: sideBarViewModel.selectedIndex == 1,
                  onTap: () {
                    sideBarViewModel.selectIndex(1);
                    NavigationService.navigateTo(context, '/training');
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedBlockchain04,
                  text: LocalizationsEsp.examButton,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  index: 2,
                  isSelected: sideBarViewModel.selectedIndex == 2,
                  onTap: () {
                    sideBarViewModel.selectIndex(2);
                    NavigationService.navigateTo(context, '/exam');
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedWorkHistory,
                  text: LocalizationsEsp.historyButton,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  index: 3,
                  isSelected: sideBarViewModel.selectedIndex == 3,
                  onTap: () {
                    sideBarViewModel.selectIndex(3);
                    NavigationService.navigateTo(context, '/history');
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedUser,
                  text: LocalizationsEsp.userButton,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  index: 4,
                  isSelected: sideBarViewModel.selectedIndex == 4,
                  onTap: () {
                    sideBarViewModel.selectIndex(0);
                    loginViewModel.logout(context);
                    // NavigationService.navigateTo(context, '/user');
                  },
                ),
                ContractButton(onTap: sideBarViewModel.contractSideBar)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
