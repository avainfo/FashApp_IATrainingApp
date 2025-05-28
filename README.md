# 🧠 FashApp Training Feedback Tool

**FashApp Training Feedback Tool** is a Flutter-based mobile/web application designed exclusively for collecting user feedback on generated outfits to improve the performance of FashApp's recommendation AI.

> 📱 Internal tool to gather real human preferences and train a supervised fashion AI model with real-world feedback.

---

## 🌟 GitHub Badges (Optional)

You can add these at the top of your README to display useful info:

```markdown
![License](https://img.shields.io/github/license/avainfo/fashapp-training-feedback)
![Stars](https://img.shields.io/github/stars/avainfo/fashapp-training-feedback?style=social)
![Flutter](https://img.shields.io/badge/built%20with-flutter-blue)
```

---

## 🌟 Purpose

* Allow testers to **like/dislike** automatically generated fashion looks.
* Store feedback in Firebase (`looks_feedback` collection).
* Regularly retrain the recommendation model using new data.

---

## 🧱 Tech Stack

| Component      | Technology                            |
| -------------- | ------------------------------------- |
| Frontend       | Flutter (mobile/web)                  |
| Backend        | Firebase (Firestore + Storage + Auth) |
| AI Engine      | Python + scikit-learn (external)      |
| Datasets       | DeepFashion, Polyvore Outfits         |
| Authentication | Firebase Auth (anonymous or email)    |

---

## 🖼️ Key Features

* **Gender selection**: Men, Women, Boys, Girls
* **Look viewer**: Display pre-generated outfits from Firebase
* **Feedback actions**: 👍 "Like" / 👎 "Dislike"
* **Data storage**: User responses are logged in Firestore

---

## 📂 Firebase Structure

```plaintext
looks_generated/     # Random AI-generated outfits
looks_curated/       # Human-curated looks (Polyvore)
looks_feedback/      # User responses with timestamps
```

Example document in `looks_feedback`:

```json
{
  "user_id": "user_123",
  "ensemble_id": "Women_05",
  "feedback": 1,
  "timestamp": "2025-05-28T14:33:00Z"
}
```

---

## 🚀 Getting Started

### ✅ Prerequisites

* Flutter SDK installed
* Firebase CLI installed (`npm install -g firebase-tools`)
* Firebase project with Firestore, Storage, and Auth enabled

### 🔧 Local Setup

```bash
git clone https://github.com/avainfo/fashapp-training-feedback.git
cd fashapp-training-feedback

flutter pub get

# Launch the app
flutter run
```

---

### 🔐 Sensitive Files (DO NOT COMMIT)

These files should be created manually and kept private:

* `android/app/google-services.json`
* `ios/Runner/GoogleService-Info.plist`
* `lib/firebase_options.dart` (generated via `flutterfire configure`)

Make sure your `.gitignore` includes these paths.

---

## 🧠 AI Training

Feedback collected from the app is exported to an external Python script using `scikit-learn`:

* Model: Logistic Regression or Random Forest
* Retrained regularly with new user data

---

## 👤 Author

Developed by [Antonin Do Souto](https://github.com/avainfo)
This project is an internal learning and prototyping tool for real-world data-driven fashion recommendation systems.

---

## 📄 License

This repository is intended for research and prototyping purposes only.
**Not licensed for public production use without explicit permission.**
