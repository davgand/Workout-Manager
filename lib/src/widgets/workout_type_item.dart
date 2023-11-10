import 'package:flutter/material.dart';
import 'package:workout_manager/src/constants/app_styles.dart';

class WorkoutTypeItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Widget navigateTo;

  const WorkoutTypeItem({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.navigateTo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Align(
            alignment: Alignment.center,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, size: 35, color: Palette.textColor),
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: AppStyles.workoutTypeStyle,
                  )
                ])),
        tileColor: bgColor,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => navigateTo,
            )));
  }
}
