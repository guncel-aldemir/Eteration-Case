# Eteration-Case


This project is a modular e-commerce application developed with Swift using modern iOS development patterns. This project showcases how to build a scalable architecture with clean separation of concerns, testability, and maintainability.

---

## 🚀 Features

- Home screen product listing with infinite scroll
- Filtering with multiple brand and model selections
- Add/remove favorites with Core Data persistence
- View and manage favorite products
- Cart management: add, remove, increase, decrease items
- Live updates across screens with NotificationCenter
- Detail screen with add-to-cart functionality
- Unit tests for core ViewModels
- Fully programmatic UI with Auto Layout

---

## 📸 Screenshots

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/e96bf948-d79a-4d1c-ab66-d6027786b683" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/81ccd921-7885-4fa9-bef8-166fa043384c" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/da2af50e-edf9-4cf3-849f-37af1a4ac84c" width="200"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/a6278a12-6a21-4924-a24b-fd86ecaff910" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/932f19b1-ee46-4a36-897e-de907cb47034" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/818ea474-3a98-4dc8-96d5-2207d4dff76e" width="200"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/a4f089d1-320c-4909-b35d-0b34bc05d723" width="200"/></td>
  </tr>
</table>

---

## 🧱 Architecture & Patterns

- **MVVM (Model-View-ViewModel)** for clean separation
- **Coordinator Pattern** for navigation flow
- **UseCase & Repository Pattern** to separate business logic
- **Dependency Injection** via `AppFactory` and `ScreenFactory`
- **NotificationCenter** for state sync across views
- **Core Data** for local persistence (favorites, cart)

---

## 🧪 Testing Strategy

Unit tests are written for all critical view models:

- ✅ `HomeViewModelTests`
- ✅ `DetailViewModelTests`
- ✅ `CartViewModelTests`

Test cases are built using:
- Mock repositories
- Dummy use case implementations
- XCTExpectations for async flows

---

## 🛠 Technologies

- Swift (iOS 15+)
- UIKit with Auto Layout (no Storyboards)
- Core Data
- XCTest
- MVVM + Coordinator
- NotificationCenter
- Modular architecture

---

## ▶️ How It Works

### Product Listing
Fetched from mock or real APIs using `NetworkManager`, supports infinite scrolling.

### Product Details
Displays product info with ability to add to cart.

### Favorites
Products can be favorited/unfavorited and persisted in Core Data.

### Cart
Items are added/removed from Core Data. TabBar shows live badge updates.

### Filtering
Users can filter products by brand or model via multiple selection UI.

---

## 🚀 Getting Started

### Requirements
- Xcode 15+
- iOS 15+
- Swift 5.9+




