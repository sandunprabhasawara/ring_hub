import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareUsScreen extends StatelessWidget {
  const ShareUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Share the App with Your Friends!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'If you love our app, let your friends know! Share it easily using the options below.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => _shareApp(),
              icon: const Icon(Icons.share),
              label: const Text('Share with Friends'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Thank you for helping us grow!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Function to share the app with others
  void _shareApp() {
    final String appLink = 'https://play.google.com/store/apps/details?id=com.yourappname'; // Update for iOS too
    final String message = 'Check out this awesome app! $appLink';
    Share.share(message);
  }
}
