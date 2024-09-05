import 'package:flutter/material.dart';
import 'package:plu_trainer/Views/training_view.dart';
import 'package:plu_trainer/viewmodels/Login/login_title_view_model.dart';
import 'package:plu_trainer/viewmodels/Login/login_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/plu_list_stopwatch_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/pluhelper_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/stop_watch_view_model.dart';
import 'package:plu_trainer/viewmodels/Training/training_view_model.dart';
import 'package:plu_trainer/viewmodels/products_view_model.dart';
import 'package:plu_trainer/viewmodels/score_view_model.dart';
import 'package:plu_trainer/views/Trainings/show_your_knowledge_view.dart';
import 'package:plu_trainer/views/Trainings/train_your_eyesight_view.dart';
import 'package:plu_trainer/views/Trainings/train_your_mind_view.dart';
import 'package:plu_trainer/views/auth_checker.dart';
import 'package:plu_trainer/views/exam_view.dart';
import 'package:plu_trainer/views/history_view.dart';
import 'package:plu_trainer/views/leaning_viewd.dart';
import 'package:plu_trainer/views/login_view.dart';
import 'package:plu_trainer/views/user_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:plu_trainer/viewmodels/Training/playstop_button_view_model.dart.dart';
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
        ChangeNotifierProvider(create: (context) => ScoreViewModel()),
        ChangeNotifierProvider(create: (context) => LoginTitleViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => TrainingViewModel()),
        ChangeNotifierProvider(
            create: (context) => PLUListStopWatchViewModel()),
        ChangeNotifierProvider(create: (context) => StopWatchViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PluTrainer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthChecker(),
        routes: {
          '/home': (context) => const HomeView(),
          '/learning': (context) => const LearningView(),
          '/training': (context) => const TrainingView(),
          '/training/showyourknowledge': (context) =>
              const ShowYourKnowledgeView(),
          '/training/trainyourmind': (context) => const TrainYourMindView(),
          '/training/trainyoureyesight': (context) =>
              const TrainYourEyesightView(),
          '/exam': (context) => const ExamView(),
          '/history': (context) => const HistoryView(),
          '/user': (context) => const UserView(),
          '/login': (context) => const LoginView(),
        },
      ),
    );
  }
}
