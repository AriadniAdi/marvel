import 'package:flutter/material.dart';
import 'package:marvel_app/core/injector.dart';
import 'package:marvel_app/core/theme/app_text_style.dart';
import 'package:marvel_app/generated/l10n.dart';
import 'package:marvel_app/presentation/home/bloc/home_bloc.dart';
import 'package:marvel_app/presentation/home/bloc/home_event.dart';
import 'package:marvel_app/presentation/home/bloc/home_state.dart';
import 'package:marvel_app/presentation/shared_widgets/marvel_app_bar.dart';
import 'package:marvel_app/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc(sl());
    bloc.add(LoadInitialHeroesEvent());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        bloc.add(LoadMoreHeroesEvent());
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MarvelAppBar(),
      body: StreamBuilder<HomeState>(
        stream: bloc.stream,
        initialData: bloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data!;
          final heroes = state.filteredHeroes;
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).featuredCharacters.toUpperCase(),
                  style: AppTextStyles.title,
                ),
                SizedBox(height: 13),
                SizedBox(
                  height: 180,
                  child:
                      heroes.isEmpty && _searchController.text.isNotEmpty
                          ? Center(
                            child: Text(
                              S.of(context).noCharacterFound,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: heroes.length.clamp(0, 5),
                            itemBuilder: (context, index) {
                              final hero = heroes[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                  right: 8,
                                ),
                                child: SizedBox(
                                  width: 140,
                                  height: 120,
                                  child: GestureDetector(
                                    onTap:
                                        () => Navigator.pushNamed(
                                          context,
                                          AppRoutes.heroDetailScreen,
                                          arguments: hero.id,
                                        ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: Image.network(
                                              hero.imageUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 6,
                                                    horizontal: 8,
                                                  ),
                                              child: Text(
                                                hero.name,
                                                style: AppTextStyles.heroName,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                ),
                SizedBox(height: 13),
                Text(
                  S.of(context).marvelCharacters.toUpperCase(),
                  style: AppTextStyles.title,
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _searchController,
                  onChanged: (text) {
                    bloc.add(SearchHeroesEvent(text));
                  },
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    hintText: S.of(context).searchCharacters,
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    isDense: true,
                    contentPadding: EdgeInsets.only(bottom: 12),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                Expanded(
                  child:
                      heroes.isEmpty && _searchController.text.isNotEmpty
                          ? Center(
                            child: Text(
                              S.of(context).noCharacterFound,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.75,
                                ),
                            controller: _scrollController,
                            itemCount:
                                heroes.length + (state.loadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= heroes.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }

                              final hero = heroes[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.heroDetailScreen,
                                    arguments: hero.id,
                                  );
                                },
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Image.network(
                                          hero.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 6,
                                          ),
                                          child: Text(
                                            hero.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
