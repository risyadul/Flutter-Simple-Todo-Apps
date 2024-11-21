# Flutter Todo App

A simple and modern Flutter todo application using Hive for data storage.

## Features

- Add, edit, and delete todos
- Mark todos as completed
- View todos by date
- Cross-platform support (Android, iOS, Web)

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://docs.flutter.dev/get-started/install)
- Hive: A lightweight and fast key-value database written in pure Dart.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/flutter_todo_app.git
   cd flutter_todo_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters:**
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

### Project Structure

- `lib/data/models`: Contains the data models used in the app.
- `lib/data/repositories`: Contains the repository classes for data operations.
- `lib/domain/usecases`: Contains use case classes for business logic.
- `lib/presentation/pages`: Contains the UI pages of the app.
- `lib/presentation/widgets`: Contains reusable UI components.

### Key Technologies

- **Flutter**: UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Hive**: A lightweight and fast key-value database written in pure Dart, used for local data storage.

### Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any improvements or bug fixes.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Acknowledgments

- [Flutter](https://flutter.dev/)
- [Hive](https://pub.dev/packages/hive)
- [Intl](https://pub.dev/packages/intl) for date formatting

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.
