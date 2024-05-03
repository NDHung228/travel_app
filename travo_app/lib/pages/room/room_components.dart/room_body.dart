import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/room_bloc/room_bloc.dart';
import 'package:travo_app/common_widgets/skeleton.dart';
import 'package:travo_app/models/room_model.dart';
import 'package:travo_app/pages/room/room_components.dart/room_child.dart';

class RoomBody extends StatefulWidget {
  final String hotelId;
  const RoomBody({super.key, required this.hotelId});

  @override
  State<RoomBody> createState() => _RoomBodyState();
}

class _RoomBodyState extends State<RoomBody> {
  @override
  void initState() {
    BlocProvider.of<RoomBloc>(context).add(GetRoom(widget.hotelId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20)
          .copyWith(top: height * 0.15),
      child: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: height * 0.04),
                  child: const Skeleton(height: 200,width: 200,)
                );
              },
            );
          }
          if (state is RoomLoaded) {
            List<Room> roomList = state.roomList;
            return ListView.builder(
              itemCount: roomList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: height * 0.04),
                  child: RoomChild(
                    room: roomList[index],
                  ),
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
