import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:top_flex/business_logic/cubit/app_cubit/app_cubit.dart';
import 'package:top_flex/business_logic/cubit/app_cubit/app_states.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
        var cubit = AppCubit.get(context);
        return FutureBuilder(
          future: Hive.openBox("list"),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return const Scaffold(body: Text("Error"),);
              }
              else{
                return Scaffold(
                  body: cubit.screens[cubit.index],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: cubit.index,
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.theater_comedy), label: "Movies"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.personal_video_outlined), label: "TV Shows"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search), label: "Search"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings), label: "Settings"),
                    ],
                    onTap: (i) {
                      cubit.changeBottomNavigationState(i,context);
                    },
                  ),
                );
              }
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          },
        );
      }),
    );
  }
}
