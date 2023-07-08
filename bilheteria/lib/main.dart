import 'package:bilheteria/logic/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bilheteria/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const Bilheteria());
}

class Bilheteria extends StatelessWidget {
  const Bilheteria({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) => MaterialApp(
          title: 'Bilheteria',
          theme: state,
          home: const Home(),
        ),
      ),
    );
  }
}
