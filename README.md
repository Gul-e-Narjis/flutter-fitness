# ⚡ FitPulse — Modern Fitness Tracker

FitPulse is a feature-rich, high-performance **Fitness Tracking Mobile Application** built using **Flutter** and **Dart**. Designed with a premium minimalist aesthetic, it empowers users to take charge of their physical health by tracking workouts, daily steps, calorie burn trends, body metrics, and personalized fitness schedules.

---

## 🎨 Design System & Palette

FitPulse employs a clean, calming, and modern design system with a tailored color palette:

*   **Background:** `#F4F8F7` (Soft Mint/Ice Green)
*   **Card/Surface:** `#FFFFFF` (Pure White)
*   **Primary/Sage Green:** `#1E9FA3` (Energetic Teal)
*   **Dark Teal:** `#0D7A7E` (Deep Focus Green)
*   **Secondary/Light Purple:** `#B39DDB` (Warm Lavender Accent)
*   **Text Dark:** `#1A2E2E` (High Contrast Charcoal)
*   **Text Grey:** `#6B7B7B` (Muted Slate)

---

## 🚀 Key Features

### 1. 📊 Interactive Dashboard (Home Screen)
*   **Daily Analytics summary:** Displays total workouts completed, cumulative duration (minutes), and total calories burned.
*   **Daily Challenge Card:** Suggests a daily featured activity to keep users motivated.
*   **Workout Categories:** Browse preloaded workouts across five domains.
*   **Recent History Snippet:** A quick glance at recent activity logs.

### 2. 🏋️ Workout & Exercise Walkthroughs
*   **5 Preloaded Categories:** Cardio, Arm, Leg, Core, and Full Body.
*   **Structured Exercises:** Detailed guides with target duration, reps, description, step-by-step instructions, specific benefits, targeted muscles, and equipment required.
*   **Built-in Action Timer:** Interactive, real-time stopwatch/countdown timer inside the exercise detail view to guide users through their training sessions.

### 3. ➕ Custom Workout Creator
*   Create personalized routines.
*   Configure custom exercise names, targeted categories, expected durations, and estimated calorie burns.

### 4. 📅 Weekly Workout Planner
*   Schedule workouts for specific days of the week (Monday through Sunday).
*   Toggle favorites to quickly access preferred routines.
*   Remove planned items dynamically.

### 5. 🚶 Step Counter & Target Tracker
*   Configure daily step count goals (e.g., 10,000 steps).
*   Visual circular progress indicator displaying steps taken and percent completion.

### 6. 📊 Progress Analytics (Charts Screen)
*   Integrates dynamic graphs using `fl_chart`.
*   **Calorie Burn Trend:** Line chart showcasing calories burned over the last 7 days.
*   **Workout Duration Analytics:** Bar chart displaying exercise minutes per day over the last 7 days.

### 7. 🧮 Smart BMI Calculator
*   Calculate Body Mass Index (BMI) dynamically from profile weight and height.
*   Provides instant health classifications (*Underweight, Normal, Overweight, Obese*).
*   Offers tailored fitness/diet suggestions based on the result.

### 8. 📜 Workout History Log
*   A dedicated screen logging all past completed workouts.
*   Provides clear date timestamps, duration, and calories burned for each session.
*   Option to clear logs to restart training history.

### 9. ⚙️ Profile Management & Settings
*   Update personal parameters (name, email, age, weight, height, and core fitness goals).
*   Persistent toggle for app notifications and daily workout reminders.

---

## 🛠️ Architecture & Tech Stack

### Framework & Language
*   **Flutter SDK:** `^3.8.1` environment compatibility.
*   **Dart:** Clean object-oriented, strongly-typed programming.

### State Management
*   **Provider Pattern:** Powered by `provider: ^6.1.2`. `AppState` acts as the single source of truth, managing profile details, step goals, planned workouts, notifications, and exercise histories reactively via `ChangeNotifier`.

### Local Storage (Offline Persistence)
*   **Shared Preferences:** Saves user profile configurations, active schedules, step logs, and completed history entries locally on the device to survive app restarts.

### Database & Auth Support (Ready)
*   Pre-configured with Firebase dependencies (`firebase_core`, `firebase_auth`, `cloud_firestore`) for future authentication and cloud database synchronization.

---

## 📂 Folder Structure

```
lib/
 ├── main.dart                  # App entry point, route mappings, and global Provider initialization
 ├── pages/
 │    ├── app_colors.dart        # Central palette theme definitions (sageGreen, darkTeal, etc.)
 │    ├── bmi_screen.dart        # BMI computation interface, metrics logger & health tips
 │    ├── custom_workout.dart    # Custom exercise entry creator
 │    ├── exercise_detail.dart   # Interactive workout timer, directions, and metrics logger
 │    ├── history_screen.dart    # List of past completed activities & clear history controls
 │    ├── home.dart              # Main dashboard with summaries, categories list, and daily challenge
 │    ├── landing.dart           # Onboarding splash page to orient new users
 │    ├── login.dart             # Email/Password authentication interface
 │    ├── signup_screen.dart     # User registration layout
 │    ├── profile_screen.dart    # Editable user parameters (height, weight, target goal)
 │    ├── progress_charts.dart   # Calorie/Duration charts powered by fl_chart
 │    ├── search_page.dart       # Live exercise browser with filter/query capabilities
 │    ├── shared_widgets.dart    # Reusable button, card, and layout wrappers
 │    ├── step_counter.dart      # Daily progress step target editor & current counts view
 │    ├── workout_detail.dart    # List of exercises matching the selected category
 │    └── workout_planner.dart   # Day-of-the-week scheduler & favorites manager
 └── services/
      ├── app_state.dart         # ChangeNotifier holding profile, planner, history & steps logic
      ├── exercise_data.dart     # Central catalog of preloaded exercise models and descriptions
      └── notification_service.dart # Local device notifications scheduling interface
```

---

## 📦 Installation & Setup

### Prerequisites
Make sure you have Flutter installed on your system. Run `flutter doctor` to verify your environment setup.

### Getting Started
1.  **Clone the Repository**
    ```bash
    git clone https://github.com/your-username/flutter-fitness.git
    cd flutter-fitness
    ```

2.  **Fetch Dependencies**
    ```bash
    flutter pub get
    ```

3.  **Run the Application**
    *   To run on a connected simulator/device:
        ```bash
        flutter run
        ```
    *   To build a release APK (Android):
        ```bash
        flutter build apk --release
        ```
    *   To build a release Bundle (iOS):
        ```bash
        flutter build ipa --release
        ```

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:
1.  Fork the project repository.
2.  Create your feature branch (`git checkout -b feature/AmazingFeature`).
3.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4.  Push to the branch (`git push origin feature/AmazingFeature`).
5.  Open a Pull Request.

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

*FitPulse — Built with 💪 using Flutter.*
