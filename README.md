# 🐝 Bilim Bäygesi (Spelling Bee Game)

A Flutter-based spelling bee game designed for English language learners. The app features multiple difficulty levels and has been optimized for performance on older devices, including Windows systems.

## ✨ Features

### 🎯 Game Levels
- **Kids**: Basic vocabulary for children
- **Senior**: Intermediate level words
- **Absolute**: Advanced vocabulary challenges

### 🎮 Game Features
- **Audio Pronunciation**: Text-to-speech for word pronunciation
- **Multiple Rounds**: Various rounds within each level (Round 1, Semi-Final, Final, etc.)
- **Real-time Feedback**: Instant scoring and feedback
- **Result Tracking**: Performance analytics and scoring
- **Sound Effects**: Audio feedback for correct/incorrect answers

### 🚀 Performance Optimizations
- Optimized for older Windows devices
- Removed GPU-intensive effects (blur, shadows)
- Simplified animations and transitions
- Efficient memory management
- Minimal resource usage

## 🛠️ Installation

### Prerequisites
- Flutter SDK (3.32.8 or later)
- Dart SDK
- Android Studio / VS Code (for development)

### Setup
```bash
# Clone the repository
git clone https://github.com/blkhn000/bee.git

# Navigate to project directory
cd bee

# Get dependencies
flutter pub get

# Enable web support (if needed)
flutter config --enable-web

# Run the app
flutter run
```

## 🌐 Web Deployment

### Local Web Build
```bash
# Build for web
flutter build web

# Serve locally (optional)
flutter run -d web-server --web-port 8080
```

### GitHub Pages Deployment
The project includes automated GitHub Actions workflow for web deployment:

1. Push changes to `main` branch
2. GitHub Actions automatically builds and deploys to GitHub Pages
3. Access your app at: `https://[username].github.io/bee/`

### Manual Deployment
```bash
# Build for web
flutter build web --release

# Deploy the build/web folder to your hosting provider
```

## 📁 Project Structure

```
bee/
├── lib/
│   ├── data/
│   │   └── words.dart          # Word database for all levels
│   ├── pages/
│   │   ├── home_page.dart      # Main menu with level selection
│   │   ├── round_page.dart     # Round selection page
│   │   ├── game_page.dart      # Main game interface
│   │   ├── result_page.dart    # Score and results display
│   │   └── test_page.dart      # TTS testing functionality
│   └── main.dart               # App entry point
├── assets/
│   ├── images/                 # App icons and logos
│   └── sounds/                 # Audio files for feedback
├── web/                        # Web-specific files
└── .github/workflows/          # CI/CD for web deployment
```

## 🎨 Design Philosophy

The app follows a **performance-first** approach:

- **Simplified UI**: Clean, minimal design without heavy graphics
- **Optimized Animations**: Reduced or eliminated complex animations
- **Efficient Rendering**: Minimal widget rebuilds and state management
- **Resource Management**: Proper disposal of audio and TTS resources

## 🔧 Technical Details

### Dependencies
- `flutter/material.dart` - UI framework
- `audioplayers` - Sound effects playback  
- `flutter_tts` - Text-to-speech functionality

### Performance Optimizations Applied
1. **Removed GPU-intensive effects**:
   - BackdropFilter blur effects
   - Complex box shadows
   - Background images with opacity

2. **Simplified widget hierarchy**:
   - Reduced nesting levels
   - Eliminated unnecessary Stack widgets
   - Streamlined layout structure

3. **Audio optimization**:
   - Single AudioPlayer instance per page
   - Proper TTS initialization and error handling
   - Resource cleanup in dispose methods

4. **Memory management**:
   - Proper disposal of controllers and resources
   - Minimal setState calls
   - Efficient list rendering

## 📱 Platform Support

- ✅ **Web** (Primary target)
- ✅ **Android** 
- ✅ **iOS**
- ✅ **Windows** (Optimized for older systems)
- ✅ **macOS**
- ✅ **Linux**

## 🚀 Getting Started

1. **Select Level**: Choose from Kids, Senior, or Absolute difficulty
2. **Choose Round**: Pick a specific round or play all rounds
3. **Listen & Type**: Click the speaker icon to hear the word, then type it
4. **Get Feedback**: Immediate feedback with correct pronunciation
5. **Track Progress**: View results and accuracy scores

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines
- Follow Flutter best practices
- Maintain performance optimizations
- Test on multiple devices/browsers
- Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Contributors who helped optimize performance
- English language learning community

## 🐛 Issues & Support

If you encounter any issues or have suggestions:
1. Check existing [Issues](https://github.com/blkhn000/bee/issues)
2. Create a new issue with detailed description
3. Include device/browser information for performance issues

---

**Made with ❤️ and Flutter**