import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

class RateUsScreen extends StatelessWidget {
   RateUsScreen({super.key});

  final InAppReview _inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'We value your feedback!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'If you enjoy using our app, please take a moment to rate us. Your feedback helps us improve and provide a better experience.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _rateApp(),
              child: const Text('Rate Now'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Thank you for your support!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Function to open the app store rating prompt
  void _rateApp() async {
    final isAvailable = await _inAppReview;
    
    }
}