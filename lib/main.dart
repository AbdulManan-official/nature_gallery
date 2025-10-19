import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nature Gallery Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const NatureGalleryScreen(),
    );
  }
}

class NatureGalleryScreen extends StatefulWidget {
  const NatureGalleryScreen({super.key});

  @override
  State<NatureGalleryScreen> createState() => _NatureGalleryScreenState();
}

class _NatureGalleryScreenState extends State<NatureGalleryScreen> {
  int _currentIndex = 0;
  bool _isLoading = true;

  final List<Map<String, String>> _images = [
    {
      'url': 'https://images.unsplash.com/photo-1501785888041-af3ef285b470',
      'caption': 'Majestic Mountain'
    },
    {
      'url': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'caption': 'Forest Trail'
    },
    {
      'url': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
      'caption': 'Ocean Waves'
    },
    {
      'url': 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e',
      'caption': 'Serene Beach'
    },
    {
      'url': 'https://images.unsplash.com/photo-1508672019048-805c876b67e2',
      'caption': 'Cute Fox'
    },
    {
      'url': 'https://images.unsplash.com/photo-1523413651479-597eb2da0ad6',
      'caption': 'Green Forest'
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  void _openFullscreen(String imageUrl) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            FullscreenImageView(imageUrl: imageUrl),
        transitionDuration: const Duration(milliseconds: 150), // faster
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double carouselHeight = 250;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text(
          "Nature Gallery",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: _isLoading
            ? Lottie.network(
          'https://assets10.lottiefiles.com/packages/lf20_usmfx6bp.json',
          width: 150,
          height: 150,
          repeat: true,
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: _images.length,
              options: CarouselOptions(
                height: carouselHeight,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration:
                const Duration(milliseconds: 800),
                viewportFraction: 0.75, // peek previous & next
                onPageChanged: (index, reason) {
                  setState(() => _currentIndex = index);
                },
              ),
              itemBuilder: (context, index, realIdx) {
                return GestureDetector(
                  onTap: () {
                    _showToast(_images[index]['caption']!);
                    _openFullscreen(_images[index]['url']!);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: _images[index]['url']!,
                          height: carouselHeight,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: carouselHeight,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                        ),
                        // Gradient overlay
                        Container(
                          height: carouselHeight,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        // Animated caption
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity:
                            _currentIndex == index ? 1.0 : 0.0,
                            child: Text(
                              _images[index]['caption']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 6,
                                    color: Colors.black45,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _images.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => setState(() {
                    _currentIndex = entry.key;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentIndex == entry.key ? 12 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == entry.key
                          ? Colors.redAccent
                          : Colors.grey.shade400,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class FullscreenImageView extends StatelessWidget {
  final String imageUrl;
  const FullscreenImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
            backgroundDecoration:
            const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3.0,
          ),
        ),
      ),
    );
  }
}
