// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:provider/provider.dart';
// import 'package:workout_manager/src/constants/app_styles.dart';
// import 'package:workout_manager/src/constants/constants.dart';
// import 'package:workout_manager/src/model/day.dart';
// import 'package:workout_manager/src/model/warmup.dart';
// import 'package:workout_manager/src/model/workout.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'warmup_popup.dart';

// class WarmupItem extends StatelessWidget {
//   final Warmup warmup;
//   final Day day;

//   const WarmupItem({
//     super.key,
//     required this.day,
//     required this.warmup,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//         key: Key(day.id.toString()),
//         startActionPane: ActionPane(
//           motion: const DrawerMotion(),
//           children: [
//             SlidableAction(
//               onPressed: (context) => editWarmup(context, day, warmup),
//               backgroundColor: Palette.white,
//               foregroundColor: Palette.grey,
//               icon: Icons.edit,
//             ),
//             SlidableAction(
//               onPressed: (context) => deleteWarmup(context, day, warmup),
//               backgroundColor: Palette.red,
//               foregroundColor: Palette.white,
//               icon: Icons.delete,
//             ),
//           ],
//         ),
//         child: ListTile(
//             title: Row(
//               children: [
//                 Expanded(
//                     flex: 30,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             style: AppStyles.warmupTitleStyle,
//                             warmup.name,
//                             textAlign: TextAlign.start,
//                           )
//                         ])),
//                 Expanded(
//                     flex: 15,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           if (warmup.reps == AppConstants.emptyValue)
//                             Text("${warmup.series}")
//                           else
//                             Text("${warmup.series} x ${warmup.reps}"),
//                         ])),
//                 if (warmup.weight != AppConstants.emptyValue)
//                   Expanded(
//                       flex: 15,
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text("${warmup.weight} kg"),
//                           ])),
//                 if (warmup.time != AppConstants.emptyValue)
//                   Expanded(
//                       flex: 15,
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text("${warmup.time} s"),
//                           ])),
//               ],
//             ),
//             onTap: () {
//               showNotes(context, warmup);
//             }));
//   }

//   Future<void> showNotes(BuildContext context, Warmup warmup) {
//     return showDialog<void>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(AppLocalizations.of(context).notes),
//             content: Text(warmup.notes),
//             actions: <Widget>[
//               TextButton(
//                 child: Text(AppLocalizations.of(context).ok),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         });
//   }

//   Future<void> editWarmup(BuildContext context, Day day, Warmup warmup) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return WarmupDialog(day, warmup);
//         });
//   }

//   Future<void> deleteWarmup(BuildContext context, Day day, Warmup warmup) {
//     return showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(
//               AppLocalizations.of(context).delete_warmup_list_dialog_title,
//             ),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   Text(AppLocalizations.of(context)
//                       .delete_warmup_list_dialog_body(warmup.name)),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: Text(AppLocalizations.of(context).yes),
//                 onPressed: () {
//                   context.read<WorkoutModel>().deleteWarmup(day, warmup);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: Text(AppLocalizations.of(context).cancel),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         });
//   }
// }
