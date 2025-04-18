import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Text(
            _privacyText,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

const String _privacyText = '''
Privacy Policy

Effective Date: April 17, 2025

Your privacy is important to us. This Privacy Policy explains how our app collects, uses, and protects your information.

1. Information We Collect
We do not collect personally identifiable information. However, we may collect anonymized usage data to improve user experience.

2. Audio Files
All audio files in the app are provided for entertainment and personalization purposes only. Users are responsible for how they use them.

3. Permissions
Our app may request access to:
- Storage: To download and set audio as ringtones or notifications.
- Internet: To stream or download audio content from our servers.

4. Third-Party Services
We may use third-party services (e.g., AdMob) which may collect data as described in their privacy policies.

5. Data Security
We do not store any sensitive information. Data is transmitted over secure protocols.

6. Changes to This Policy
We may update this policy occasionally. You will be notified through the app in case of significant changes.

7. Contact Us
If you have any questions about this policy, you can contact us at:
support@yourappname.com

Thank you for using our app!
''';
