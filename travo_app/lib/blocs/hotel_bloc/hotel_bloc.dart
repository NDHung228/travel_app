import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travo_app/models/hotel.model.dart';
import 'package:travo_app/repo/hotel_repo/hotel_impl.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final HotelImplement _hotelImplement;
  HotelBloc({required hotelImplement})
      : _hotelImplement = hotelImplement,
        super(HotelInitial()) {
    on<HotelEvent>((event, emit) {});

    on<GetHotel>(_onGetHotels);

    on<SearchHotelRequired>(_onSearchHotel);
  }

  void _onGetHotels(GetHotel event, Emitter<HotelState> emit) async {
    emit(HotelLoading());
    try {
      final data = await _hotelImplement.getHotels();
      emit(HotelLoaded(data));
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }

  void _onSearchHotel(
      SearchHotelRequired event, Emitter<HotelState> emit) async {
    try {
      String? keyword = event.keyword;
      double? startPrice = event.startPrice;
      double? endPrice = event.endPrice;
      String? sort = event.sort;

      if (state is SearchHotelLoaded) {
        keyword ??= (state as SearchHotelLoaded).keyword;
        startPrice ??= (state as SearchHotelLoaded).startPrice;
        endPrice ??= (state as SearchHotelLoaded).endPrice;
        sort ??= (state as SearchHotelLoaded).sort;

      }

      List<Hotel> listHotel =
          await _hotelImplement.filterHotels(keyword, startPrice, endPrice,sort);
      emit(SearchHotelLoading());

      emit(SearchHotelLoaded(
        hotelList: listHotel,
        keyword: keyword,
        endPrice: endPrice,
        startPrice: startPrice,
        sort: sort
      ));
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }
}
