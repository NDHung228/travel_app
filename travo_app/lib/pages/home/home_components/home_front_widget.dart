import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';

class HomeFrontWidget extends StatelessWidget {
  final Color color;
  final String imgUrl;
  final String title;
  final VoidCallback onPressed;
  
  
  const HomeFrontWidget({Key? key, required this.imgUrl, required this.title, required this.color, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        InkWell(
          onTap: () => onPressed.call(),
          child: Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            width: width * 0.23,
            height: height * 0.1,
            child: Image.asset(imgUrl),
          ),
        ),
        SizedBox(height: height * 0.02),
        CommonText(text: title,fontWeight: FontWeight.w400,),
      ],
    );
  }
}
