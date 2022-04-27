import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_flex/business_logic/cubit/search_cubit/search_states.dart';

import '../business_logic/cubit/search_cubit/search_cubit.dart';
import '../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 55,
                child: BlocBuilder<SearchCubit, SearchStates>(
                  builder: (ctx, state) {
                    var cubit = SearchCubit.get(ctx);
                    return TextField(
                      autofocus: true,
                      onSubmitted: (String value) {
                        cubit.searchQuery(searchController.text);
                      },
                      onChanged: (value) {
                        cubit.searchQuery(value);
                      },
                      controller: searchController,
                      style: const TextStyle(color: Colors.white70),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 8),
                        fillColor: Colors.white10,
                        border: InputBorder.none,
                        filled: true,
                        hintText: "The Walking Dead, ..",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          gapPadding: 0,
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          gapPadding: 0,
                          borderSide: BorderSide.none,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchStates>(
                  builder: (ctx, state) {
                    var cubit = SearchCubit.get(ctx);
                    if (state is GetSearchResultsLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return cubit.searchResults.isNotEmpty
                        ? GridView.builder(
                            itemCount: cubit.searchResults.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 2 / 3),
                            itemBuilder: (ctx, index) {
                              return buildSearchedItem(
                                  cubit.searchResults[index], index,ctx);
                            },
                          )
                        : const Center(
                            child: Text("No Results"),
                          );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
