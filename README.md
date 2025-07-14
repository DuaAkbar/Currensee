# 💱 Currensee

**Currensee** is a sleek, Flutter-based mobile app that simplifies currency conversion with real-time exchange rates, currency news, and customizable preferences — all wrapped in a modern pink-themed UI. Built as a semester project, Currensee reflects real-world functionality and clean coding practices using GetX and Supabase.

---

## 📖 Overview

Currensee is a feature-rich currency conversion app designed for users who want fast, accurate conversions and up-to-date financial info on the go. It includes real-time exchange rates, news integration, and persistent user preferences, backed by Supabase and managed via GetX.

---

## ✨ Features

- 🔐 **Authentication**
  - Register/login using secure Supabase Auth
  - Validated input forms using `form_validator`

- 💱 **Currency Conversion**
  - Select source and target currencies
  - Enter amount and get live conversion using a currency API

- 📊 **Exchange Rate List**
  - View current exchange rates relative to selected base currency
  - Persist base currency selection using `GetStorage`

- 📰 **Currency News**
  - Fetch and display the latest currency/finance news from an API
  - Tap to read full articles in browser

- ⚙️ **Settings**
  - Logout confirmation dialog
  - Access FAQs and a "Contact Us" form

- 📬 **Contact Form**
  - Submit feedback directly into Supabase database

- 🧠 **Well-Structured Codebase**
  - MVC-style folder organization with clean, reusable widgets

---

## 📸 Screenshots

### 🔐 Authentication 
![Register](screenshots/register.png)
![Login](screenshots/login.png)

### 💱 Currency Converter
![Converter](screenshots/conversion.png)

### 📊 Exchange Rate List
![Rates](screenshots/exchangerate.png)

### 📰 News Page
![News](screenshots/news.png)

### 📈 Chart Page
![Chart](screenshots/chart.png)

### ❓ FAQ Page
![FAQ](screenshots/faq.png)

### ✅ Confirmation Modal 
![Confirmation](screenshots/confirmationModal.png)

### 📬 Contact Us 
![Contact](screenshots/contactUs.png)

---

## 🛠️ Tech Stack

- **Framework:** Flutter
- **State Management:** GetX
- **Backend:** Supabase (Auth + Database)
- **APIs:** Currency Exchange API, News API
- **Local Storage:** GetStorage
- **UI:** Google Fonts

---

## 🚀 Installation & Setup

Follow these simple steps to run **Currensee** on your local machine:

### 🧾 1. Clone the Repository

```bash
git clone https://github.com/DuaAkbar/Currensee.git
cd currensee
```

---

### 📦 2. Install Flutter Dependencies

```bash
flutter pub get
```
---

### 🔧 3. Configure Supabase

1. Create a new project on [Supabase](https://supabase.io).
2. Add your Supabase credentials in your project’s config/constants file:

```dart
const String supabaseUrl = "https://ydvnzsxlvaegobqluqep.supabase.co",;
const String supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlkdm56c3hsdmFlZ29icWx1cWVwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE1NjcxMTQsImV4cCI6MjA2NzE0MzExNH0.SvbBaG1DEAwtRePf979ib1mqbcl8mK1OwyCXhehyWRM"
;
```

> 💡 Tip: You can store these securely using `.env` or a separate config file.

---

### ▶️ 4. Run the App

```bash
flutter run
```

> ✅ Make sure your emulator or physical device is connected before running the app.

---

🧭 Usage Guide
🔑 Authentication
Sign up or log in using your credentials

Auth state is maintained until logout

💸 Currency Converter
Choose from dropdowns, input an amount

Tap Convert for instant results

📈 Exchange Rates
Shows real-time exchange rate list

Base currency can be changed and is saved locally

📰 News
Displays latest currency-related headlines

Tap to open articles in external browser

⚙️ Settings & Contact
Logout with confirmation dialog

Contact form sends feedback to Supabase DB

🙋‍♀️ Author
Dua Akbar
📧 duaakbar912@gmail.com
🔗 LinkedIn Profile
🎓 Software Engineering Student | Flutter Enthusiast | Remote Internship Seeker

📄 License
This project is open source and available under the MIT License.
