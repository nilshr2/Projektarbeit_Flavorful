# Flavorful (Projektarbeit)

## Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio)
- [Git](https://git-scm.com/downloads)

## Getting Started

1. **Install the Flutter and Dart Plugin:**
   In Android Studio, navigate to `File` -> `Settings` -> `Plugins`. Then, search for "Flutter" and "Dart". Choose "Install" for both.

2. **Clone the Repository:** 
   ```
   git clone https://github.com/nilshr2/Projektarbeit_Flavorful.git
   ```

3. **Open the Project in Android Studio:**
   - Within Android Studio, choose `Open`.
   - Select the directory of the cloned repository.

4. **Install Dependencies:**
   - Android Studio will automatically detect the `pubspec.yaml` file, where all dependencies are defined.
   - Click on `Get dependencies` or run `flutter pub get` in the terminal.

5. **Create a `supabase_options.dart` File:**
   For access to the Supabase API, a file called `supabase_options.dart` inside the `lib` folder has to be created. Use the following as a template:

   ```dart
   class DefaultSupabaseOptions {
     static const String url = '<supabase-url>';
     static const String anonKey = '<supabase-api-key>';
   }
   ```

   Make sure to replace `<supabase-url>` with the actual Supabase URL and `<supabase-api-key>` with the Supabase API key. These can be obtained by contacting me.

6. **Run the Application:**
   - Make sure that an Android emulator or a physical device is connected.
   - Click on the `Run` button in Android Studio or alternatively run `flutter run` in the terminal.

## Architecture

Flavorful follows the [Bloc pattern](https://bloclibrary.dev) for state management. Here is an overview of the architecture:

- **lib/**: Contains all the Dart code for the application.
  - **bloc/**: Contains the top-level business logic components using the Bloc pattern.
    - **translation/**: Top-level bloc that is responsible for fetching dynamic translations from the API.
  - **data/**: Handles data-operations such as API calls etc.
    - **api/model/**: Defines all data models used within the application.
  - **l10n/**: Responsible for on-device translations.
  - **pages/**: Contains UI screens of the application as well as components and blocs on which these depend.
  - **shared/**: Reusable UI components, constants, etc.

The Bloc pattern separates the presentation layer from the business logic. It always consists of the following components:

- **Bloc:** Manages the state and business logic.
- **Event:** Contains events that are called from the UI layer.
- **State:** Contains possible states that the bloc can take.

Bloc ensures an unidirectional data flow and provides a more robust state-management solution than what Flutter provides natively.
