import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/hotel_bloc/hotel_bloc.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_filed.dart';
import 'package:travo_app/pages/hotel/hotel_components/hotel_appbar.dart';
import 'package:travo_app/pages/hotel/hotel_components/hotel_body.dart';
import 'package:travo_app/repo/hotel_repo/hotel_impl.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({Key? key}) : super(key: key);

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  final searchController = TextEditingController();

  late HotelBloc _hotelBloc;

  @override
  void initState() {
    super.initState();
    final HotelImplement hotelImp = HotelImplement();
    _hotelBloc = HotelBloc(hotelImplement: hotelImp); // Initialize HotelBloc
  }

  @override
  void dispose() {
    _hotelBloc.close(); // Close HotelBloc when disposing
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocProvider.value(
            value: _hotelBloc,
            child: HotelAppBar(hotelBloc: _hotelBloc), // Pass _hotelBloc to HotelAppBar
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 10),
            child: CommonTextField(
              prefixIcon: const CommonIcon(
                icon: Icons.search,
                color: Colors.black,
              ),
              controller: searchController,
              hintText: 'Search your destination',
              obscureText: false,
              keyboardType: TextInputType.name,
              onChanged: (String? keyword) {
                Future.delayed(const Duration(seconds: 2), () {
                  // Code to be executed after the delay
                  _hotelBloc.add(SearchHotelRequired(keyword: keyword!));
                });

                return;
              },
            ),
          ),
          Expanded(
            child: BlocProvider.value(
              value: _hotelBloc, // Provide existing _hotelBloc instance
              child: const HotelBody(),
            ),
          ),
        ],
      ),
    );
  }
}
