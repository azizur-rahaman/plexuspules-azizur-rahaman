---
name: Clean Architecture - Presentation Layer (Pages vs Views)
description: Guidelines for separating UI state and layout logic from route entry points and dependency providers.
---

# Presentation Layer Separation (Pages vs Views)

When building screens in the Flutter application, you MUST strictly separate the routing/dependency injection layer from the UI layout/state layer. 

Follow this pattern for all new screens:

## 1. Pages and Views (`presentation/pages/[feature]/`)
A "Page" and its "View" should reside together in a feature-specific subfolder within `pages/`.

### The Page (`[feature]_page.dart`)
- Acts as the entry point for a route.
- It should almost always be a `StatelessWidget`.
- Its **sole responsibility** is to provide dependencies (like BLoC providers, Repositories via `getIt`) to the subtree.
- It should contain **zero** UI layout code (no `Scaffold`, no `Column`, no animations).
- It simply returns a `BlocProvider` whose child is the corresponding "View".

### The View (`[feature]_view.dart`)
- Handles the actual user interface and interaction.
- It can be a `StatelessWidget` or a `StatefulWidget` depending on state/animation needs.
- It contains the `Scaffold`, listens to BLoC state changes, and handles UI events.
- It should **not** instantiate BLoCs itself.

## 2. Widgets (`presentation/widgets/`)
Extracted, reusable, pure UI components that multiple Views can use or that are extracted for clarity.

### Folder Structure Example
```
lib/features/auth/presentation/
├── pages/
│   └── login/
│       ├── login_page.dart       <-- Provides LoginBloc
│       └── login_view.dart       <-- Contains Scaffold & UI
└── widgets/
    ├── login_header.dart
    └── login_footer.dart
```

Do not mix these responsibilities. When creating a new feature screen, instantly create the folder and both the `_page.dart` and `_view.dart`.
