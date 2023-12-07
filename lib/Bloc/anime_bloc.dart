import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../repostory/api/anime_api.dart';
import '../repostory/modelclass/AnimeModel.dart';

part 'anime_event.dart';
part 'anime_state.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  late AnimeModel animeModel;
  AnimeApi animeApi=AnimeApi();
  AnimeBloc() : super(AnimeInitial()) {
    on<AnimeEvent>((event, emit)async {
      emit(AnimeblocLoading());
      try{

        animeModel = await animeApi.getAnime();
        emit(AnimeblocLoaded());
      } catch(e){
        print(e);
        emit(AnimeblocError());}
    });
  }
}
