import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travo_app/models/place_model.dart';
import 'package:travo_app/repo/place_repo/place_impl.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceImplement _placeImPlaceImplement;

  PlaceBloc({required placeImPlaceImplement})
      : _placeImPlaceImplement = placeImPlaceImplement,
        super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetPlace>(_onPlaceGetData);
  }

  void _onPlaceGetData(GetPlace event, Emitter<PlaceState> emit) async {
    emit(PlaceLoading());

    try {
      final data = await _placeImPlaceImplement.getPlaces();
      emit(PlaceLoaded(data));
    } catch (e) {
      emit(PlaceError(e.toString()));
    }
  }
}
