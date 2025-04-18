import 'package:flutter/material.dart';

class GetHelpScreen extends StatelessWidget {
  const GetHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Need help with something?',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Here are some common topics that might help:',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const HelpItem(
              title: 'How to set a ringtone?',
              description:
                  'To set a ringtone, download the audio file, then go to your phone\'s settings and choose it as your ringtone.',
            ),
            const HelpItem(
              title: 'Can I use downloaded sounds offline?',
              description:
                  'Yes! Once downloaded, the sound files can be used without an internet connection.',
            ),
            const HelpItem(
              title: 'App is not playing sound. What to do?',
              description:
                  'Make sure your media volume is up and you have given storage/audio permissions.',
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              'Still need help?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _sendEmail,
              icon: const Icon(Icons.email),
              label: const Text(
                'Contact Support',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@yourappname.com',
      query: 'subject=App Support Request',
    );
    // if (await canLaunchUrl(emailUri)) {
    //   await launchUrl(emailUri);
    // }
  }
}

class HelpItem extends StatelessWidget {
  final String title;
  final String description;

  const HelpItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
