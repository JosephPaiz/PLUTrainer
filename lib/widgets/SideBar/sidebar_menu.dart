import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:plu_trainer/Widgets/contract_button.dart';
import 'package:plu_trainer/core/localization/plutrainer_localizations_esp.dart';
import 'package:plu_trainer/core/style/fonts.dart';
import 'package:plu_trainer/services/navigation_service.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_button.dart';
import 'package:plu_trainer/viewmodels/Training/sidebar_view_model.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:provider/provider.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

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
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        ),
      ),
      child: Column(
        children: [
          DrawerHeader(
            child: Text(
              sideBarViewModel.isOpenSideBar ? LocalizationsEsp.titleApp : 'PT',
              style: Fonts.sidebarTitleTextStyle,
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
                  icon: HugeIcons.strokeRoundedEditRoad,
                  text: LocalizationsEsp.learningButton,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  index: 1,
                  isSelected: sideBarViewModel.selectedIndex == 1,
                  onTap: () {
                    sideBarViewModel.selectIndex(1);
                    NavigationService.navigateTo(context, '/learning');
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedBlockGame,
                  text: LocalizationsEsp.trainingButton,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  index: 2,
                  isSelected: sideBarViewModel.selectedIndex == 2,
                  onTap: () {
                    sideBarViewModel.selectIndex(2);
                    NavigationService.navigateTo(context, '/training');
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedBlockchain04,
                  text: LocalizationsEsp.examButton,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  index: 3,
                  isSelected: sideBarViewModel.selectedIndex == 3,
                  onTap: () {
                    sideBarViewModel.selectIndex(3);
                    NavigationService.navigateTo(context, '/exam');
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedWorkHistory,
                  text: LocalizationsEsp.historyButton,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  index: 4,
                  isSelected: sideBarViewModel.selectedIndex == 4,
                  onTap: () {
                    sideBarViewModel.selectIndex(4);
                    NavigationService.navigateTo(context, '/history');
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedUser,
                  text: LocalizationsEsp.userButton,
                  isSidebarOpen: sideBarViewModel.isOpenSideBar,
                  index: 5,
                  isSelected: sideBarViewModel.selectedIndex == 5,
                  onTap: () {
                    sideBarViewModel.selectIndex(0);
                    loginViewModel.logout(context);
                    // NavigationService.navigateTo(context, '/user');
                  },
                ),
                ContractButton(
                  onTap: () {
                    sideBarViewModel.contractSideBar();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
