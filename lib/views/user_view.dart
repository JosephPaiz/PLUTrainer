import 'package:flutter/material.dart';
import 'package:plu_trainer/widgets/SideBar/sidebar_menu.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return const Center(
            child: Text(
              'Not yet available for mobile',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          return Row(
            children: [
              const SidebarMenu(),
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.green,
                  child: const Text('Learning View'),
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
