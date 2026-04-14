# Blind Quiz System - Mobile Application

Flutter mobile application for doctors to manage exams and view student answers in the Blind Quiz System.

## Features

- Doctor authentication
- Create and manage exams
- Add questions to exams
- View all exams
- View student answers (transcribed from audio)
- Beautiful Arabic UI
- Real-time updates
- Responsive design

## Requirements

- Flutter SDK 3.0 or higher
- Dart 3.0 or higher
- Android SDK (for Android builds)
- iOS development tools (for iOS builds)

## Installation

### 1. Install Flutter

Download and install Flutter SDK from: https://flutter.dev/

### 2. Install Dependencies

```cmd
flutter pub get
```

### 3. Configure Server IP

Edit `lib/services/api_service.dart` and update the server URL:

```dart
static const String baseUrl = 'http://YOUR_SERVER_IP:3000/api';
```

Replace `YOUR_SERVER_IP` with your backend server's IP address.

## Building

### Android APK (Release)

Build split APKs (smaller size):
```cmd
flutter build apk --release --split-per-abi
```

Build single APK (larger, works on all devices):
```cmd
flutter build apk --release
```

APK output location:
```
build/app/outputs/flutter-apk/
```

### iOS (Release)

```cmd
flutter build ios --release
```

## Running

### Development Mode

```cmd
flutter run
```

### On Specific Device

```cmd
flutter devices
flutter run -d <device-id>
```

## Project Structure

```
lib/
├── main.dart                      # App entry point
├── screens/                       # UI screens
│   ├── splash_screen.dart         # Splash screen
│   ├── login_screen.dart          # Login screen
│   ├── home_screen.dart           # Home screen with exams
│   ├── create_exam_screen.dart    # Create exam screen
│   ├── student_answers_screen.dart # View answers
│   └── exam_answers_detail_screen.dart # Answer details
└── services/                      # Business logic
    ├── api_service.dart           # API communication
    └── auth_service.dart          # Authentication
```

## Configuration

### API Service

The app communicates with the backend via REST API. All endpoints are defined in `lib/services/api_service.dart`.

### Authentication

User authentication is handled by `auth_service.dart` using Provider for state management.

## Test Credentials

Default login credentials (configured in backend):

Doctor Account:
- Email: doctor@test.com
- Password: 123456

## Features Detail

### Login Screen
- Email and password authentication
- Form validation
- Error handling
- Loading indicator

### Home Screen
- Display all exams
- Exam cards with details
- Navigation to create exam
- Navigation to view answers
- User profile display

### Create Exam Screen
- Add exam title and subject
- Set exam duration
- Add multiple questions
- Set question duration
- Form validation
- Save to backend

### Student Answers Screen
- List all exams
- Show exam details
- Navigate to answer details
- Display submission status

### Exam Answers Detail Screen
- Show all questions
- Display transcribed answers
- Show submission timestamps
- Audio indicator

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0              # HTTP requests
  provider: ^6.0.5          # State management
  shared_preferences: ^2.2.2 # Local storage
```

## API Endpoints Used

### Authentication
- POST /api/login

### Exams
- GET /api/exams
- GET /api/exams/:id
- POST /api/exams

### Answers
- GET /api/answers/:studentId
- GET /api/student/exams/:studentId

## Troubleshooting

### Cannot connect to server
- Check server IP in api_service.dart
- Ensure backend is running
- Check firewall allows port 3000
- Ensure phone and server on same WiFi

### Build fails
- Run: flutter clean
- Run: flutter pub get
- Check Flutter version: flutter --version
- Update Flutter: flutter upgrade

### Login fails
- Check backend is running
- Verify credentials in backend/data/students.json
- Check network connection
- Check server logs

### Arabic text not displaying
- Ensure UTF-8 encoding
- Check font support
- Verify API response encoding

## Development

### Hot Reload

During development, use hot reload for instant updates:
- Press 'r' in terminal for hot reload
- Press 'R' for hot restart

### Debug Mode

Run in debug mode:
```cmd
flutter run --debug
```

### Release Mode

Test release build:
```cmd
flutter run --release
```

## Performance

### APK Sizes:
- Split APK (arm64): ~16 MB
- Split APK (armeabi): ~14 MB
- Single APK: ~40 MB

### Startup Time:
- Cold start: ~2-3 seconds
- Warm start: ~1 second

## Customization

### Theme

Edit theme in `lib/main.dart`:
```dart
theme: ThemeData(
  primaryColor: const Color(0xFF1A237E),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Cairo',
),
```

### Colors

Main colors used:
- Primary: #1A237E (Dark Blue)
- Accent: #FFC857 (Yellow)
- Background: #FFFFFF (White)
- Text: #000000 (Black)

## Testing

### Unit Tests

```cmd
flutter test
```

### Integration Tests

```cmd
flutter test integration_test
```

## Deployment

### Android

1. Build release APK
2. Transfer to phone
3. Enable "Install from Unknown Sources"
4. Install APK

### iOS

1. Build release IPA
2. Upload to TestFlight or App Store
3. Follow Apple guidelines

## Security Notes

### Current Implementation

This is a development/testing setup with:
- Simple password authentication
- No encryption
- HTTP (not HTTPS)
- Open CORS

### For Production

Implement:
- JWT tokens
- Password hashing
- HTTPS/SSL
- Proper CORS configuration
- Input validation
- Rate limiting

## License

MIT License

## Support

For issues or questions, please open an issue on GitHub.
