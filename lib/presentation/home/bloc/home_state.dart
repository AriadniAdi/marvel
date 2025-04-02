import 'package:marvel_app/domain/entities/hero_model.dart';

class HomeState {
  final List<HeroModel> allHeroes;
  final List<HeroModel> filteredHeroes;
  final bool loadingMore;
  final String query;

  HomeState({
    required this.allHeroes,
    required this.filteredHeroes,
    required this.loadingMore,
    required this.query,
  });

  factory HomeState.initial() => HomeState(
    allHeroes: [],
    filteredHeroes: [],
    loadingMore: false,
    query: '',
  );

  HomeState copyWith({
    List<HeroModel>? allHeroes,
    List<HeroModel>? filteredHeroes,
    bool? loadingMore,
    String? query,
  }) {
    return HomeState(
      allHeroes: allHeroes ?? this.allHeroes,
      filteredHeroes: filteredHeroes ?? this.filteredHeroes,
      loadingMore: loadingMore ?? this.loadingMore,
      query: query ?? this.query,
    );
  }
}
