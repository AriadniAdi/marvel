import 'package:marvel_app/domain/entities/hero_model.dart';

abstract class HeroDetailState {}

class HeroDetailInitial extends HeroDetailState {}

class HeroDetailLoading extends HeroDetailState {}

class HeroDetailLoaded extends HeroDetailState {
  final HeroModel hero;
  HeroDetailLoaded(this.hero);
}

class HeroDetailError extends HeroDetailState {
  final String message;
  HeroDetailError(this.message);
}
