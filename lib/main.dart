import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orbix_chat/features/home/presentation/bloc/home_bloc.dart';
import 'package:orbix_chat/features/home/presentation/pages/home_screen.dart';
import 'package:orbix_chat/features/voice_input/presentation/cubit/voice_cubit.dart';
import 'package:orbix_chat/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const OrbixApp());
}

class OrbixApp extends StatelessWidget {
  const OrbixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Chatbot UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1A1A2E)),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<HomeBloc>(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
