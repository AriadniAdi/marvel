abstract class HomeEvent {}

class LoadInitialHeroesEvent extends HomeEvent {}

class LoadMoreHeroesEvent extends HomeEvent {}

class SearchHeroesEvent extends HomeEvent {
  final String query;
  SearchHeroesEvent(this.query);
}
