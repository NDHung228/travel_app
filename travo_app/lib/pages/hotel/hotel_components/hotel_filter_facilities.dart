import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HotelFilterFacilities extends StatelessWidget {
  const HotelFilterFacilities({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          CommonTopContainer(title: l10n.facilities, content: ''),
        ],
      ),
    );
  }
}
