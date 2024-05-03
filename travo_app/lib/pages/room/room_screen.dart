import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/room_bloc/room_bloc.dart';
import 'package:travo_app/pages/room/room_components.dart/room_appbar.dart';
import 'package:travo_app/pages/room/room_components.dart/room_body.dart';

class RoomScreen extends StatefulWidget {
  final String hotelId;
  const RoomScreen({super.key, required this.hotelId});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RoomAppBar(),
          BlocProvider(
            create: (context) => RoomBloc(),
            child: 
            RoomBody(hotelId: widget.hotelId),
          ),
        ],
      ),
    );
  }
}
