import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── WorkoutSession model ──────────────────────────────────────────────────────
class WorkoutSession {
  final String category;
  final String date;
  final int durationMinutes;
  final int exercisesCompleted;
  final double caloriesBurned;

  WorkoutSession({
    required this.category,
    required this.date,
    required this.durationMinutes,
    required this.exercisesCompleted,
    required this.caloriesBurned,
  });

  String toSaveString() =>
      '$category|$date|$durationMinutes|$exercisesCompleted|$caloriesBurned';

  static WorkoutSession fromSaveString(String s) {
    final p = s.split('|');
    return WorkoutSession(
      category: p[0],
      date: p[1],
      durationMinutes: int.parse(p[2]),
      exercisesCompleted: int.parse(p[3]),
      caloriesBurned: double.parse(p[4]),
    );
  }
}

// ── PlannedWorkout model ──────────────────────────────────────────────────────
class PlannedWorkout {
  final String id;
  final String category;
  final String day; // 'Monday', 'Tuesday' ...
  final String time; // '07:00 AM'
  bool isFavourite;

  PlannedWorkout({
    required this.id,
    required this.category,
    required this.day,
    required this.time,
    this.isFavourite = false,
  });

  String toSaveString() => '$id|$category|$day|$time|$isFavourite';

  static PlannedWorkout fromSaveString(String s) {
    final p = s.split('|');
    return PlannedWorkout(
      id: p[0],
      category: p[1],
      day: p[2],
      time: p[3],
      isFavourite: p[4] == 'true',
    );
  }
}

// ── AppState ──────────────────────────────────────────────────────────────────
class AppState extends ChangeNotifier {
  // ── User Profile ──────────────────────
  String _userName = 'Fitness User';
  String _userEmail = '';
  double _userWeight = 70.0;
  double _userHeight = 170.0;
  int _userAge = 25;
  String _fitnessGoal = 'Stay Fit';

  // ── Workout History ────────────────────
  List<WorkoutSession> _workoutHistory = [];

  // ── Workout Planner ────────────────────
  List<PlannedWorkout> _plannedWorkouts = [];

  // ── Step Counter ───────────────────────
  int _todaySteps = 0;
  int _stepGoal = 10000;

  // ── Notifications ──────────────────────
  bool _notificationsEnabled = true;

  // ── Getters — Profile ──────────────────
  String get userName => _userName;
  String get userEmail => _userEmail;
  double get userWeight => _userWeight;
  double get userHeight => _userHeight;
  int get userAge => _userAge;
  String get fitnessGoal => _fitnessGoal;

  // ── Getters — History ──────────────────
  List<WorkoutSession> get workoutHistory => _workoutHistory;

  int get totalWorkoutsCompleted => _workoutHistory.length;

  int get totalMinutesWorkedOut =>
      _workoutHistory.fold(0, (sum, s) => sum + s.durationMinutes);

  double get totalCaloriesBurned =>
      _workoutHistory.fold(0.0, (sum, s) => sum + s.caloriesBurned);

  int get weeklyWorkouts {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    return _workoutHistory.where((s) {
      final date = DateTime.parse(s.date);
      return date.isAfter(weekStart.subtract(const Duration(days: 1)));
    }).length;
  }

  // Last 7 days calories per day — chart ke liye
  List<double> get last7DaysCalories {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final day = now.subtract(Duration(days: 6 - i));
      return _workoutHistory
          .where((s) {
            final d = DateTime.parse(s.date);
            return d.year == day.year &&
                d.month == day.month &&
                d.day == day.day;
          })
          .fold(0.0, (sum, s) => sum + s.caloriesBurned);
    });
  }

  // Last 7 days workout minutes per day — bar chart ke liye
  List<double> get last7DaysMinutes {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final day = now.subtract(Duration(days: 6 - i));
      return _workoutHistory
          .where((s) {
            final d = DateTime.parse(s.date);
            return d.year == day.year &&
                d.month == day.month &&
                d.day == day.day;
          })
          .fold(0.0, (sum, s) => sum + s.durationMinutes);
    });
  }

  // ── Getters — Planner ──────────────────
  List<PlannedWorkout> get plannedWorkouts => _plannedWorkouts;

  List<PlannedWorkout> get favouritePlans =>
      _plannedWorkouts.where((p) => p.isFavourite).toList();

  List<PlannedWorkout> getWorkoutsForDay(String day) =>
      _plannedWorkouts.where((p) => p.day == day).toList();

  // ── Getters — Steps ────────────────────
  int get todaySteps => _todaySteps;
  int get stepGoal => _stepGoal;
  double get stepProgress => (_todaySteps / _stepGoal).clamp(0.0, 1.0);

  // ── Getters — Notifications ────────────
  bool get notificationsEnabled => _notificationsEnabled;

  // ── BMI ────────────────────────────────
  double get bmi {
    if (_userHeight <= 0) return 0;
    final h = _userHeight / 100;
    return _userWeight / (h * h);
  }

  String get bmiCategory {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Normal';
    if (bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  Color get bmiColor {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25.0) return Colors.green;
    if (bmi < 30.0) return Colors.orange;
    return Colors.red;
  }

  // ── Constructor ────────────────────────
  AppState() {
    _loadFromStorage();
  }

  // ── Profile update ─────────────────────
  void updateProfile({
    String? name,
    String? email,
    double? weight,
    double? height,
    int? age,
    String? goal,
  }) {
    if (name != null) _userName = name;
    if (email != null) _userEmail = email;
    if (weight != null) _userWeight = weight;
    if (height != null) _userHeight = height;
    if (age != null) _userAge = age;
    if (goal != null) _fitnessGoal = goal;
    _saveToStorage();
    notifyListeners();
  }

  // ── History ────────────────────────────
  void addWorkoutSession(WorkoutSession session) {
    _workoutHistory.insert(0, session);
    _saveToStorage();
    notifyListeners();
  }

  void clearHistory() {
    _workoutHistory.clear();
    _saveToStorage();
    notifyListeners();
  }

  // ── Planner ────────────────────────────
  void addPlannedWorkout(PlannedWorkout plan) {
    _plannedWorkouts.add(plan);
    _saveToStorage();
    notifyListeners();
  }

  void removePlannedWorkout(String id) {
    _plannedWorkouts.removeWhere((p) => p.id == id);
    _saveToStorage();
    notifyListeners();
  }

  void toggleFavourite(String id) {
    final i = _plannedWorkouts.indexWhere((p) => p.id == id);
    if (i != -1) {
      _plannedWorkouts[i].isFavourite = !_plannedWorkouts[i].isFavourite;
      _saveToStorage();
      notifyListeners();
    }
  }

  // ── Steps ──────────────────────────────
  void updateSteps(int steps) {
    _todaySteps = steps;
    notifyListeners();
  }

  void setStepGoal(int goal) {
    _stepGoal = goal;
    _saveToStorage();
    notifyListeners();
  }

  // ── Notifications ──────────────────────
  void setNotifications(bool value) {
    _notificationsEnabled = value;
    _saveToStorage();
    notifyListeners();
  }

  // ── Save ───────────────────────────────
  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    await prefs.setString('userEmail', _userEmail);
    await prefs.setDouble('userWeight', _userWeight);
    await prefs.setDouble('userHeight', _userHeight);
    await prefs.setInt('userAge', _userAge);
    await prefs.setString('fitnessGoal', _fitnessGoal);
    await prefs.setInt('stepGoal', _stepGoal);
    await prefs.setBool('notificationsEnabled', _notificationsEnabled);
    await prefs.setStringList(
      'workoutHistory',
      _workoutHistory.map((s) => s.toSaveString()).toList(),
    );
    await prefs.setStringList(
      'plannedWorkouts',
      _plannedWorkouts.map((p) => p.toSaveString()).toList(),
    );
  }

  // ── Load ───────────────────────────────
  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('userName') ?? 'Fitness User';
    _userEmail = prefs.getString('userEmail') ?? '';
    _userWeight = prefs.getDouble('userWeight') ?? 70.0;
    _userHeight = prefs.getDouble('userHeight') ?? 170.0;
    _userAge = prefs.getInt('userAge') ?? 25;
    _fitnessGoal = prefs.getString('fitnessGoal') ?? 'Stay Fit';
    _stepGoal = prefs.getInt('stepGoal') ?? 10000;
    _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    final historyStr = prefs.getStringList('workoutHistory') ?? [];
    _workoutHistory = historyStr
        .map((s) => WorkoutSession.fromSaveString(s))
        .toList();
    final planStr = prefs.getStringList('plannedWorkouts') ?? [];
    _plannedWorkouts = planStr
        .map((s) => PlannedWorkout.fromSaveString(s))
        .toList();
    notifyListeners();
  }
}
