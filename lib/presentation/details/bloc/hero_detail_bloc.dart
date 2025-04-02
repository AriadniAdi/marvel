import 'package:bloc/bloc.dart';
import 'package:marvel_app/core/usecases/get_hero_detail_usecase.dart';
import 'package:marvel_app/domain/entities/hero_model.dart';
import 'package:marvel_app/presentation/details/bloc/heroes_detail_event.dart';
import 'package:marvel_app/presentation/details/bloc/heroes_detail_state.dart';

class HeroDetailBloc extends Bloc<HeroDetailEvent, HeroDetailState> {
  final GetHeroDetailUseCase useCase;

  HeroDetailBloc(this.useCase) : super(HeroDetailInitial()) {
    on<LoadHeroDetailEvent>((event, emit) async {
      emit(HeroDetailLoading());
      try {
        final HeroModel hero = await useCase(event.id);
        emit(HeroDetailLoaded(hero));
      } catch (e) {
        emit(HeroDetailError('Erro ao carregar herói.'));
      }
    });
  }
}
