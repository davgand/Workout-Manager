import 'dart:convert';
import 'dart:io';

import 'package:gym_manager/src/model/workout.dart';
import 'package:path_provider/path_provider.dart';

import '../src/constants/constants.dart';

class FileHandler {
  static bool fileExists = false;

  // Fetch content from the json file
  static Future<WorkoutModel> readWorkout() async {
    final file = await _localFile;

    // If the workout file do not exists then create it
    fileExists = await file.exists();
    if (!fileExists) {
      createWorkoutJson(file);
    }

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

  static void createWorkoutJson(File file) {
    WorkoutModel model = WorkoutModel(days: AppConstants.dummyDays);
    final jsonModel = model.toJson();
    final jsonModelString = jsonEncode(jsonModel);
    file.writeAsString(jsonModelString);
  }
}
