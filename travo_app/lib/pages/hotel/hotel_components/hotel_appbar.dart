import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travo_app/blocs/hotel_bloc/hotel_bloc.dart';
import 'package:travo_app/common_widgets/common_icon_button_widget.dart';

import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/pages/hotel/hotel_components/hotel_filter_bottom_sheet.dart';

class HotelAppBar extends StatefulWidget implements PreferredSizeWidget {
  final HotelBloc hotelBloc;

  const HotelAppBar({Key? key, required this.hotelBloc}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(200);

  @override
  // ignore: library_private_types_in_public_api
  _HotelAppBarState createState() => _HotelAppBarState();
}

class _HotelAppBarState extends State<HotelAppBar> {
  static const Size _preferredSize = Size.fromHeight(200);
  late ValueNotifier<RangeValues> _rangeValuesNotifier;
  late ValueNotifier<String> _sortNotifier;

  late AppLocalizations l10n;
  late HotelBloc _hotelBloc;

  @override
  void initState() {
    super.initState();
    _rangeValuesNotifier =
        ValueNotifier<RangeValues>(const RangeValues(0, 1000));
    _sortNotifier = ValueNotifier<String>('');
    _hotelBloc = widget.hotelBloc;
  }

  @override
  void dispose() {
    _rangeValuesNotifier.dispose();
    _sortNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    l10n = AppLocalizations.of(context)!;
    var width = MediaQuery.of(context).size.width;

    return Container(
        height: _preferredSize.height, // Use preferredSize.height here
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.backgroundImg,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(35.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Navigator.canPop(context)
                  ? CommonIconButton(
                      color: const Color(0xFF232323),
                      icon: Icons.arrow_back,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : const SizedBox(),
              Center(
                child: CommonText(
                  text: 'Hotels',
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.bold,
                  size: 30,
                ),
              ),
              CommonIconButton(
                color: const Color(0xFF232323),
                icon: Icons.menu,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return HotelFilterBottomSheet(
                        rangeValuesNotifier: _rangeValuesNotifier,
                        hotelBloc: _hotelBloc,
                        l10n: l10n,
                        sortNotifier: _sortNotifier,
                      );
                    },
                  );
                },
              )
            ],
          ),
        ));
  }
}
