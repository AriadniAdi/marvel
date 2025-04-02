import 'package:flutter/material.dart';
import 'package:marvel_app/presentation/details/bloc/hero_detail_bloc.dart';
import 'package:marvel_app/presentation/details/bloc/heroes_detail_event.dart';
import 'package:marvel_app/presentation/details/bloc/heroes_detail_state.dart';
import '../../core/injector.dart';

class HeroDetailScreen extends StatefulWidget {
  final int heroId;

  const HeroDetailScreen({super.key, required this.heroId});

  @override
  State<HeroDetailScreen> createState() => _HeroDetailScreenState();
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  late HeroDetailBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HeroDetailBloc(sl());
    bloc.stream.listen((state) {
      setState(() {});
    });
    bloc.add(LoadHeroDetailEvent(widget.heroId));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = bloc.state;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/marvel.png',
          height: 36,
          fit: BoxFit.contain,
        ),
      ),
      body: Builder(
        builder: (context) {
          if (state is HeroDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (state is HeroDetailLoaded) {
            final hero = state.hero;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(hero.imageUrl),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          hero.name,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          hero.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is HeroDetailError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
