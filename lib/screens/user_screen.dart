import 'package:flutter/material.dart';
import 'package:musicapp/screens/user_screens/about.dart';
import 'package:musicapp/screens/user_screens/get_help.dart';
import 'package:musicapp/screens/user_screens/privacy_policy.dart';
import 'package:musicapp/screens/user_screens/rate_us.dart';
import 'package:musicapp/screens/user_screens/share_us.dart';
// import 'package:musicapp/providers/token_manager.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              child: ListTile(
                                minTileHeight: 50,
                                leading: const Icon(Icons.lock),
                                title: const Text('Privacy'),
                                subtitle:
                                    const Text('Privacy and security settings'),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PrivacyPolicyScreen()),
                                  );
                                  // Navigate to privacy settings
                                },
                              ),
                            ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              child: ListTile(
                                minTileHeight: 50,
                                leading: const Icon(Icons.help),
                                title: const Text('Help'),
                                subtitle: const Text('Get help and support'),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => GetHelpScreen()),
                                  );
                                },
                              ),
                            ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              child: ListTile(
                                minTileHeight: 50,
                                leading: const Icon(Icons.info),
                                title: const Text('About'),
                                subtitle: const Text('App version and info'),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => AboutScreen()),
                                  );
                                },
                              ),
                            ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              child: ListTile(
                                minTileHeight: 50,
                                leading: const Icon(Icons.star_rate_rounded),
                                title: const Text('Rate us'),
                                subtitle:
                                    const Text('Give a star on playstore'),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => RateUsScreen()),
                                  );
                                },
                              ),
                            ),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              child: ListTile(
                                minTileHeight: 50,
                                leading: const Icon(Icons.share),
                                title: const Text('Share'),
                                subtitle:
                                    const Text('Share us on social meadia'),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ShareUsScreen()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Positioned(
                        bottom: 15,
                        child: Center(
                          child: Text(
                            'In apps developed using Flutter, creator expressions can be seen in building custom UI widgets, creative layouts.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ))
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
