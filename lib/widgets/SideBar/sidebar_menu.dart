import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
// import 'package:plu_trainer/widgets/contract_button.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_button.dart';
import 'package:plu_trainer/viewmodels/Training/sidebar_view_model.dart';
import 'package:provider/provider.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({super.key});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
  bool isSidebarOpen = true;

  @override
  Widget build(BuildContext context) {
    final sideBarViewModel = Provider.of<SideBarViewModel>(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSidebarOpen ? 250 : 70,
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
              isSidebarOpen ? 'PLU Trainer' : 'PT',
              style: const TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SideBarButton(
                  icon: HugeIcons.strokeRoundedHome11,
                  text: 'Home: Coming Soon',
                  index: 0,
                  isSelected: sideBarViewModel.selectedIndex == 10,
                  isSidebarOpen: isSidebarOpen,
                  onTap: () {
                    sideBarViewModel.selectIndex(2);
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedEditRoad,
                  text: 'Learning: Coming Soon',
                  isSidebarOpen: isSidebarOpen,
                  index: 1,
                  isSelected: sideBarViewModel.selectedIndex == 10,
                  onTap: () {
                    sideBarViewModel.selectIndex(2);
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedBlockGame,
                  text: 'Trainning',
                  isSidebarOpen: isSidebarOpen,
                  index: 2,
                  isSelected: sideBarViewModel.selectedIndex == 2,
                  onTap: () {
                    sideBarViewModel.selectIndex(2);
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedBlockchain04,
                  text: 'Exam',
                  isSidebarOpen: isSidebarOpen,
                  index: 3,
                  isSelected: sideBarViewModel.selectedIndex == 10,
                  onTap: () {
                    sideBarViewModel.selectIndex(2);
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedWorkHistory,
                  text: 'History: Coming Soon',
                  isSidebarOpen: isSidebarOpen,
                  index: 4,
                  isSelected: sideBarViewModel.selectedIndex == 10,
                  onTap: () {
                    sideBarViewModel.selectIndex(2);
                  },
                ),
                SideBarButton(
                  icon: HugeIcons.strokeRoundedUser,
                  text: 'User: Coming Soon',
                  isSidebarOpen: isSidebarOpen,
                  index: 5,
                  isSelected: sideBarViewModel.selectedIndex == 10,
                  onTap: () {
                    sideBarViewModel.selectIndex(2);
                  },
                ),
                // ContractButton(
                //   onTap: () {},
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
