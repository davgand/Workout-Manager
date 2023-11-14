import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workout_manager/src/constants/app_styles.dart';
import 'package:workout_manager/src/constants/enums.dart';

class SlidableActionList extends StatelessWidget {
  final ActionEnum action;
  final Function(BuildContext)? onPressed;

  const SlidableActionList(
      {super.key, required this.action, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var icon = action == ActionEnum.edit ? Icons.edit : Icons.delete;
    var iconColor = action == ActionEnum.edit ? Palette.grey : Palette.red;
    return SlidableAction(
      onPressed: onPressed,
      backgroundColor: Palette.white,
      foregroundColor: iconColor,
      icon: icon,
    );
  }
}
