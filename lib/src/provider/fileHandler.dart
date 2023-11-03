import 'dart:convert';
import 'dart:io';

import 'package:workout_manager/src/model/workout.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/constants.dart';

class FileHandler {
  static bool fileExists = false;

  // Fetch content from the json file
  static Future<WorkoutModel> readWorkout() async {
    final file = await verifyFile();
    final data = await file.readAsString();
    Map<String, dynamic> dataJson = json.decode(data);

    WorkoutModel model = WorkoutModel.fromJson(dataJson);

    return model;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$AppConstants.fileName');
  }

  static void writeWorkout(WorkoutModel workout) async {
    final file = await verifyFile();
    createWorkoutJson(file, workout);
  }

  static void createWorkoutJson(File file, [WorkoutModel? workout]) {
    if (workout != null) {
      file.writeAsString(jsonEncode(workout.toJson()));
    } else {
      file.writeAsString(
          jsonEncode(WorkoutModel(AppConstants.dummyDays).toJson()));
    }
  }

  static Future<File> verifyFile() async {
    final file = await _localFile;
    // If the workout file do not exists then create it
    fileExists = await file.exists();
    if (!fileExists) {
      createWorkoutJson(file);
    }

    return file;
  }
}
