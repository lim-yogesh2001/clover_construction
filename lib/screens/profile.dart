import 'package:clover_construction/constants/static_urls.dart';
import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/providers/auth.dart';
import 'package:clover_construction/providers/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = "profile-screen";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthProvider>(context, listen: false).userInfo;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white.withOpacity(1),
        elevation: 1,
        title: const Text(
          "User Profile",
          style: TextStyle(color: Colors.black, fontFamily: "Lato-Bold"),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: Provider.of<ProfileProvider>(context, listen: false)
                .fetchUserProfile(userData['userId']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Consumer<ProfileProvider>(
                  builder: (context, profileData, child) {
                    final profile = profileData.userProfile();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(domain + profile.imageUrl),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.person,
                              size: 24.0,
                              color: textHighlighter,
                            ),
                            title: Text(
                              profile.fullName,
                              style: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Divider(),
                            ListTile(
                            leading: const Icon(
                              Icons.email,
                              size: 24.0,
                              color: textHighlighter,
                            ),
                            title: Text(
                              profile.email,
                              style: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Divider(),
                           ListTile(
                            leading: const Icon(
                              Icons.location_on_rounded,
                              size: 24.0,
                              color: textHighlighter,
                            ),
                            title: Text(
                              profile.address,
                              style: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Divider(),
                           ListTile(
                            leading: const Icon(
                              Icons.date_range,
                              size: 24.0,
                              color: textHighlighter,
                            ),
                            title: Text(
                              DateFormat.yMMMEd().format(profile.dateOfBirth),
                              style: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(
                              Icons.contact_page_rounded,
                              size: 24.0,
                              color: textHighlighter,
                            ),
                            title: Text(
                              profile.phoneNo,
                              style: const TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
