abstract class HeroDetailEvent {}

class LoadHeroDetailEvent extends HeroDetailEvent {
  final int id;
  LoadHeroDetailEvent(this.id);
}
