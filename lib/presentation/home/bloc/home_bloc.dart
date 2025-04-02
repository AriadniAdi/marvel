import 'package:bloc/bloc.dart';
import 'package:marvel_app/data/marvel_data_source.dart';
import 'package:marvel_app/domain/entities/hero_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MarvelDatasource datasource;
  int offset = 0;
  final int limit = 20;

  HomeBloc(this.datasource) : super(HomeState.initial()) {
    on<LoadInitialHeroesEvent>((event, emit) async {
      offset = 0;
      final heroes = await datasource.getHeroes(limit: limit, offset: offset);
      emit(
        state.copyWith(
          allHeroes: heroes,
          filteredHeroes: heroes,
          loadingMore: false,
          query: '',
        ),
      );
    });

    on<LoadMoreHeroesEvent>((event, emit) async {
      if (state.loadingMore) return;

      emit(state.copyWith(loadingMore: true));

      offset += limit;
      final newHeroes = await datasource.getHeroes(
        limit: limit,
        offset: offset,
      );
      final updatedList = [...state.allHeroes, ...newHeroes];
      final filtered = _filterHeroes(updatedList, state.query);

      emit(
        state.copyWith(
          allHeroes: updatedList,
          filteredHeroes: filtered,
          loadingMore: false,
        ),
      );
    });

    on<SearchHeroesEvent>((event, emit) {
      final filtered = _filterHeroes(state.allHeroes, event.query);
      emit(state.copyWith(filteredHeroes: filtered, query: event.query));
    });
  }

  List<HeroModel> _filterHeroes(List<HeroModel> list, String query) {
    if (query.isEmpty) return list;
    return list
        .where((hero) => hero.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
