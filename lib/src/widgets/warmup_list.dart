// import 'package:flutter/material.dart';
// import 'package:workout_manager/src/model/day.dart';
// import 'package:workout_manager/src/model/warmup.dart';
// import 'package:workout_manager/src/widgets/warmup_item.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class WarmupList extends StatelessWidget {
//   final List<Warmup> warmups;
//   final Day day;
//   final ValueChanged<Warmup>? onTap;

//   const WarmupList({
//     required this.day,
//     required this.warmups,
//     this.onTap,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: warmups.length,
//         itemBuilder: (context, index) => WarmupItem(
//               day: day,
//               warmup: warmups[index],
//             ));
//   }
// }
