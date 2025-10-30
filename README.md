#  Flutter Assignment

A simple 3-page Flutter application demonstrating:

1. **Google Sign-In/Sign-Up** (frontend only)
2. **Hotel List (Home Page)** – displays popular hotels using API
3. **Search Results Page** – fetches hotels by query with pagination

---

## 📱 Features

### 🔹 Page 1 – Google Sign In / Sign Up

* Implemented using `google_sign_in` package.
* Frontend-only — no backend authentication required.
* Once the user signs in, they are redirected to the **Home Page**.

### 🔹 Page 2 – Home Page

* Displays a list of sample or popular hotels using the MyTravaly API.
* Includes:

  * Search bar (search by city name)
  * Tap any hotel card to view detailed hotel information

### 🔹 Page 3 – Search Results

* Displays hotels fetched dynamically from the API.
* Each hotel card includes:

  * Image
  * Name
  * City
  * Rating
  * Price
  * “View on MyTravaly” button (opens hotel page in-app webview)

---

## 🔧 Tech Stack

| Technology        | Purpose                   |
| ----------------- | ------------------------- |
| Flutter           | UI framework              |
| Dart              | Programming language      |
| `google_sign_in`  | Google login integration  |
| `http`            | API communication         |
| `url_launcher`    | Open MyTravaly hotel page |
| `webview_flutter` | In-app hotel page view    |

---

## 🧩 API Information

**Base URL:**

```
https://api.mytravaly.com/public/v1/
```

---

##  Installation & Setup

### 1️ Prerequisites

* Install [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.0 or higher)
* Install Android Studio or VS Code
* Set up an emulator or connect a physical device

---

### 2️ Clone this repository


git clone https://github.com/yourusername/Flutter_Assignmen.git
cd Flutter_Assignmen


---

### 3️ Install dependencies


flutter pub get


---

### 4️ Run the app


flutter run


---

## ⚙️ Folder Structure


lib/
│
├── main.dart                # Entry point
│
├── Pages/
│   ├── login_page.dart      # Google Sign-In screen
│   ├── home_page.dart       # Home page showing popular hotels
│   ├── search_page.dart     # Search result listing with pagination
│   └── detail_page.dart     # Hotel details + MyTravaly link
│
├── Services/
│   └── api_service.dart     # API integration (fetchHotels, searchHotels)
│
└── Widgets/
    └── hotel_card.dart      # Reusable card widget for hotel UI


## 🧠 Notes

* `Google Sign-In` is **frontend only** — no backend token verification required.
* API requests use the provided **Auth Token** and dynamically include **visitorToken**.
* Handles 404 image errors gracefully with placeholders.

---

## 👨‍💻 Developer

Name: Vishal Maurya

