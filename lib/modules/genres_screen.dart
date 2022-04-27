import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flex/business_logic/cubit/genres_cubit/genres_cubit.dart';
import 'package:top_flex/business_logic/cubit/genres_cubit/genres_states.dart';
import 'package:top_flex/shared/components/components.dart';

class GenresScreen extends StatelessWidget {
  const GenresScreen({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Genres"),
        centerTitle: true,
      ),
      body: BlocBuilder<GenresCubit, GenresStates>(
        builder: (c, state) {
          var cubit = GenresCubit.get(c);
          if (state is GetGenresLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
              separatorBuilder: (c, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                      color: Colors.white70,
                      width: double.infinity,
                      height: 1,
                    ),
              ),
              itemCount:
                  index == 1 ? cubit.movieGenres.length : cubit.tvGenres.length,
              itemBuilder: (ctx, i) {
                return buildGenresItem(
                    index == 1 ? cubit.movieGenres : cubit.tvGenres, ctx,i,index);
              });
        },
      ),
    );
  }
}
