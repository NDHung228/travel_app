import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class BookingDate extends StatelessWidget {
  final ValueNotifier<DateTime?> startDateNotifier;
  final ValueNotifier<DateTime?> endDateNotifier;
  const BookingDate(
      {super.key,
      required this.startDateNotifier,
      required this.endDateNotifier});

  String _getMonthName(int month) {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ][month - 1];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.01),
          CommonText(
            text: 'Booking Date',
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: height * 0.02),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  final pickedDateRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );

                  if (pickedDateRange != null) {
                    startDateNotifier.value = pickedDateRange.start;
                    endDateNotifier.value = pickedDateRange.end;
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFF77777).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: Color(0xFFF77777),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(text: 'Check-in'),
                  SizedBox(height: height * 0.01),
                  ValueListenableBuilder<DateTime?>(
                    valueListenable: startDateNotifier,
                    builder: (context, startDate, _) {
                      return CommonText(
                        text: startDate != null
                            ? '${startDate.day}, ${_getMonthName(startDate.month)}'
                            : 'Select Date',
                        fontWeight: FontWeight.bold,
                        size: 14,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(width: width * 0.15),
              InkWell(
                onTap: () async {
                  final pickedDateRange = await showDateRangePicker(
                    context: context,
                    firstDate: startDateNotifier.value ?? DateTime.now(),
                    lastDate: DateTime(DateTime.now().year + 1),
                  );
                  if (pickedDateRange != null) {
                    endDateNotifier.value = pickedDateRange.end;
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorConstant.tealColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: ColorConstant.tealColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(text: 'Check-out'),
                  SizedBox(height: height * 0.01),
                  ValueListenableBuilder<DateTime?>(
                    valueListenable: endDateNotifier,
                    builder: (context, endDate, _) {
                      return CommonText(
                        text: endDate != null
                            ? '${endDate.day}, ${_getMonthName(endDate.month)}'
                            : 'Select Date',
                        fontWeight: FontWeight.bold,
                        size: 14,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: height * 0.01),
        ],
      ),
    );
  }
}
