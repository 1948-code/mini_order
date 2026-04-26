#  Mini Order App

A lightweight E-commerce mobile application built with **Flutter** and **Firebase**, designed to streamline food ordering and product management.

---

##  Architecture Explanation

This project follows a **Layered Clean Architecture** pattern to ensure high maintainability and a clear separation of concerns. By decoupling the UI Layer (Views) from the Data Layer (Services), the app remains scalable and easier to debug.

The architecture is divided into three primary pillars:
* **Presentation Layer:** Contains UI screens and reusable widgets that respond to user input.
* **Domain/Model Layer:** Defines the data structures and business logic blueprints.
* **Data/Service Layer:** Handles all external communications, including **Firebase Firestore** for real-time data, **Firebase Storage** for assets, and **SharedPreferences** for local persistence.

---

##  Setup Instructions

To get a local copy of this project up and running, follow these steps:

###  Prerequisites
* Ensure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
* A Firebase project created on the [Firebase Console](https://console.firebase.google.com/).

###  Installation

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/1948-code/mini_order.git]
    cd mini_order
    ```

2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Firebase Configuration:**
    * Download `google-services.json` from your Firebase project settings.
    * Place it in the `android/app/` directory.

4.  **Run the App:**
    ```bash
    flutter run
    ```

---

##  Project Structure
Based on the clean folder structure implementation:
* `lib/services/`: Cloud and local data handling logic.
* `lib/views/`: Organized UI screens (Admin, User, Auth).


