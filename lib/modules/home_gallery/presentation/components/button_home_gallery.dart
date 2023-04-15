import 'package:flutter/material.dart';

class CustomButtonGallery extends StatelessWidget {
  CustomButtonGallery({
    Key? key,
    required this.name,
    required this.imageName,
    this.arrowName,
    this.buttonColor = Colors.white,
    this.onTapAction,
  }) : super(key: key);
  final String? name;
  final String? imageName;
  final String? arrowName;
  final Color? buttonColor;
  final GestureTapCallback? onTapAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonColor,
      ),
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: onTapAction,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageName!),
                ),
              ),
              width: 25,
              height: 25,
              padding: EdgeInsets.all(6),
              child: arrowName == null? Container() : Image.asset(
                arrowName!,
                width: 10,
                height: 10,
              ),
            ),
            SizedBox(width: 10,),
            Text(
              name!,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
