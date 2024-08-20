import 'package:flutter/material.dart';
import 'package:provider_with_mvvm/resources/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPress,
      child: Container(
        height: size.height * .06,
        width: size.width * .6,
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: loading == true
            ? const CircularProgressIndicator(
                color: AppColors.whiteColor,
              )
            : Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
