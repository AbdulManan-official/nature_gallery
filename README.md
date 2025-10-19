# Nature Gallery  (Flutter)

**Nature Gallery Pro** is a visually appealing Flutter mobile application that showcases a professional image carousel of natural landscapes, oceans, forests, and wildlife. It provides a smooth, interactive user experience with modern UI/UX features.

---

## Features

- **Optimized Carousel Slider:** Shows high-quality images with a peek of previous and next slides for a professional gallery feel.  
- **Gradient Captions:** Each image has a subtle animated caption overlay with gradient for better readability.  
- **Fullscreen Image Preview:** Tap any image to view fullscreen with zoom and pinch using `photo_view`.  
- **Shimmer & Lottie Loading Animations:** Displays a loader while images load, enhancing perceived performance.  
- **Toast Notifications:** Shows descriptive captions on image tap using `fluttertoast`.  
- **Cached Images:** Uses `cached_network_image` to improve performance and reduce network usage.  
- **Responsive Design:** Maintains consistent image heights and widths across devices.  

---


---

## Packages Used

- [`carousel_slider`](https://pub.dev/packages/carousel_slider) - Animated carousel slider  
- [`cached_network_image`](https://pub.dev/packages/cached_network_image) - Efficient image caching  
- [`lottie`](https://pub.dev/packages/lottie) - Loading animations  
- [`fluttertoast`](https://pub.dev/packages/fluttertoast) - Toast notifications  
- [`photo_view`](https://pub.dev/packages/photo_view) - Fullscreen zoomable images  

---

## Getting Started

### Prerequisites

- Flutter SDK installed ([Flutter Setup](https://flutter.dev/docs/get-started/install))  
- A device or emulator to run the app  

### Installation

1. Clone the repository:  
```bash
git clone https://github.com/<your-username>/nature_gallery_pro.git
Navigate to the project folder:

bash
Copy code
cd nature_gallery_pro
Install dependencies:

bash
Copy code
flutter pub get
Run the app:

bash
Copy code
flutter run
How It Works
The app initially shows a Lottie loader for 2–3 seconds while images are being fetched.

The carousel displays images with gradient captions and peek of adjacent images.

Tap an image to view it in fullscreen with zoom/pinch.

Toast notifications show image captions on tap.

Images are cached for smoother performance.

Project Structure
vbnet
Copy code
nature_gallery_pro/
│
├─ android/
├─ ios/
├─ lib/
│   └─ main.dart
├─ assets/
│   └─ lottie/ (optional for local lottie files)
├─ pubspec.yaml
└─ README.md
License
This project is open source and free to use.
