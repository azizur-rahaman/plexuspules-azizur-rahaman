# PlexusPules - Real-Time Network Monitoring (NOC Simulator)

PlexusPules is a premium, modern Flutter mobile application designed as a Network Operations Center (NOC) simulator. It provides real-time monitoring of network device health, performance metrics, and system alerts through a sleek, data-driven interface.

## 🚀 Features

*   **Secure Authentication**: Multi-layered authentication flow with JWT handling and persistent sessions.
*   **Intelligence Dashboard**: Holistic overview of network health with metrics for Total, Online, and Offline devices, including active alert counts.
*   **Infrastructure Monitoring**: Comprehensive device list with real-time status tracking, advanced search, and category filtering.
*   **Performance Analytics (Dual Graphs)**: Dedicated views for high-fidelity CPU and Memory usage tracking with data-rich visual history.
*   **Real-Time Alerts**: Dynamic notification system that polls for critical network events every 30 seconds.
*   **FCM Push Notifications**: End-to-end integration for background critical alerts with automatic backend triggers.
*   **Dark Mode Support**: Context-aware UI components optimized for high-visibility in both light and dark environments.
*   **Modern Design**: Built with premium aesthetics, glassmorphism elements, and smooth micro-animations.

## 📸 Screenshots

| Dashboard | Devices | Performance |
| :---: | :---: | :---: |
| ![Dashboard Placeholder](https://via.placeholder.com/200x400?text=Dashboard) | ![Devices Placeholder](https://via.placeholder.com/200x400?text=Devices) | ![Performance Placeholder](https://via.placeholder.com/200x400?text=Performance) |

## 🛠 Tech Stack

*   **Framework**: [Flutter](https://flutter.dev/) (3.11+)
*   **Language**: [Dart](https://dart.dev/)
*   **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) (BLoC pattern)
*   **Networking**: [Dio](https://pub.dev/packages/dio) with JSON Serialization
*   **Architecture**: Feature-First Clean Architecture
*   **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) & [injectable](https://pub.dev/packages/injectable)
*   **Navigation**: [go_router](https://pub.dev/packages/go_router)
*   **Visualizations**: [fl_chart](https://pub.dev/packages/fl_chart)
*   **Local Storage**: [Hive](https://pub.dev/packages/hive) & [Secure Storage](https://pub.dev/packages/flutter_secure_storage)
*   **Functional Programming**: [dartz](https://pub.dev/packages/dartz) (Either for error handling)

## 🏗 Architecture

The project follows a **Feature-First Clean Architecture** pattern, ensuring high modularity, testability, and scalability.

### Layers within each Feature:
-   **Domain Layer**: Contains business logic, Entities (plain data classes), and Use Cases. It defines Repository interfaces but is independent of external frameworks.
-   **Data Layer**: Responsible for data retrieval. Includes Models (JSON-serializable entities), Data Sources (Remote API/Local DB), and Repository implementations.
-   **Presentation Layer**: Responsible for the UI. Includes **BLoCs** for state management, **Pages** for routing entry, **Views** for layout, and **Widgets** for atomic UI components.
-   **Core Layer**: Houses shared utilities such as custom network clients, error handling (Failures/Exceptions), and global constants.

## 📁 Folder Structure

```text
lib/
├── config/             # Theme & App Routing configuration
├── core/               # Universal utilities, DI, and shared widgets
│   ├── di/             # Dependency Injection setup
│   ├── network/        # Base API client configuration
│   └── error/          # Failure & Exception definitions
└── features/           # Feature-based modular structure
    ├── auth/           # Login & Session management
    ├── dashboard/      # Metrics visualization
    ├── devices/        # Inventory and monitoring
    ├── performance/    # Dual-graph system analytics
    └── alerts/         # Real-time event notifications
```

## 🚥 Getting Started

### Prerequisites
-   Flutter SDK (^3.11.1)
-   Dart SDK

### Installation
1.  **Clone the repository**:
    ```bash
    git clone https://github.com/azizur-rahaman/plexuspules-azizur-rahaman.git
    cd plexuspules-azizur-rahaman
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Generate code (Dependency Injection & JSON Serializers)**:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Setup Environment**:
    Ensure you have a `.env` file in the root directory (or assets) pointing to your backend API.

5.  **Run the application**:
    ```bash
    flutter run
    ```

## 🔑 Demo Credentials

-   **Email**: `admin@plexus.com`
-   **Password**: `password123`

## 📡 Real-Time Data Handling

PlexusPules utilizes a hybrid approach for real-time data synchronization:
-   **Periodic Polling**: Dedicated BLoCs utilize `Timer.periodic` to trigger Fetch events (e.g., Performance data every 5s, Alerts every 30s) from the REST API.
-   **FCM Push Notifications**: Leverages **Firebase Cloud Messaging** for high-priority background alerts. A dedicated `PushNotificationService` manages token lifecycle and message handling, ensuring users are notified of critical system deviations even when the app is in the background.

## 📦 Offline Support

The application utilizes **Hive** for light-weight local caching of metadata and **Flutter Secure Storage** for encrypted handling of sensitive authentication tokens, allowing the app to retain the last known state during intermittent connectivity.

## ✅ Testing

PlexusPules is built with a commitment to high code quality and reliability. The project targets **100% logic coverage** across all Clean Architecture layers.

*   **Unit Tests**: Comprehensive verification of Use Cases, Repositories, Data Sources, and BLoCs.
*   **Widget Tests**: Systematic UI verification for complex views including state transitions and layout accuracy.
*   **Infrastructure**: Mocking with `mocktail` and specialized test helpers for robust, isolated verification.

### Running Tests

To execute the test suite:
```bash
flutter test
```

To generate a coverage report:
```bash
flutter test --coverage
# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
```

## 👤 Author

**Azizur Rahaman**
*   GitHub: [azizur-rahaman](https://github.com/azizur-rahaman)

---
© 2024 PlexusPules. Designed for Network Professionals.