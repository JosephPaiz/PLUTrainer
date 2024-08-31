import 'package:flutter/material.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
import 'package:provider/provider.dart';
import 'package:plu_trainer/viewmodels/Training/sidebar_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/selectionbar_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/timer_view_model.dart';
import 'package:plu_trainer/Views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://aepefcpkfkkucftcbuup.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFlcGVmY3BrZmtrdWNmdGNidXVwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQyMTAwMjAsImV4cCI6MjAzOTc4NjAyMH0.3rlKy3nWYbbdvTCk7ComrNGqVIuLNz8AA9-AqwcfW9Y',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SideBarViewModel()),
        ChangeNotifierProvider(create: (context) => SelectionBarViewModel()),
        ChangeNotifierProvider(create: (context) => TimerViewModel()),
        ChangeNotifierProvider(create: (context) => PlayStopButtonViewModel()),
        ChangeNotifierProvider(create: (context) => ProductViewModel()),
        ChangeNotifierProvider(create: (context) => PLUHelperViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PluTrainer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
