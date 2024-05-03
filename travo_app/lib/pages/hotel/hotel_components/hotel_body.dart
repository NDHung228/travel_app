import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/hotel_bloc/hotel_bloc.dart';
import 'package:travo_app/models/hotel.model.dart';
import 'package:travo_app/pages/hotel/hotel_components/hotel_child.dart';

class HotelBody extends StatefulWidget {
  const HotelBody({Key? key}) : super(key: key);

  @override
  State<HotelBody> createState() => _HotelBodyState();
}

class _HotelBodyState extends State<HotelBody> {
  @override
  void initState() {
    super.initState();

    context.read<HotelBloc>().add(const GetHotel());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading || state is SearchHotelLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HotelLoaded) {
            List<Hotel> hotelList = state.hotelList;
            return ListView.builder(
              itemCount: hotelList.length,
              itemBuilder: (context, index) {
                return HotelChild(
                  hotel: hotelList[index],
                );
              },
            );
          } else if (state is SearchHotelLoaded) {
            List<Hotel> hotelList = state.hotelList;
            return ListView.builder(
              itemCount: hotelList.length,
              itemBuilder: (context, index) {
                return HotelChild(
                  hotel: hotelList[index],
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
