import 'package:bekkams_lending/features/presentation/home/provider/homeprovider.dart';
import 'package:bekkams_lending/features/presentation/home/widgets/profilewidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Myprofilepage extends StatelessWidget {
  const Myprofilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProfileprovider>(
      builder: (context, profileProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            leading: const BackButton(),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.settings),
              ),
            ],
          ),
          body:
              profileProvider.userProfile == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                            "${profileProvider.userProfile!.userimagedata?[0].profileUrl}",
                          ),
                        ),

                        const SizedBox(height: 12),
                        Text(
                          '${profileProvider.userProfile!.firstName} ${profileProvider.userProfile!.lastName}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 30),

                        MyProfileWidget(
                          title: 'Mobile Number',
                          value:
                              '+91 ${profileProvider.userProfile!.phoneNumber}',
                          onUpdate: () {},
                        ),

                        MyProfileWidget(
                          title: 'Email',
                          value: profileProvider.userProfile!.email!,
                          onUpdate: () {},
                        ),

                        MyProfileWidget(
                          title: 'PAN',
                          value:
                              profileProvider
                                  .userProfile!
                                  .userimagedata![0]
                                  .pan, // from image data (hook later)
                          onUpdate: () {},
                        ),

                        MyProfileWidget(
                          title: 'Aadhaar',
                          value:
                              profileProvider
                                  .userProfile!
                                  .userimagedata![0]
                                  .aadhar,
                          onUpdate: () {},
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: () async {
                              await profileProvider.appSignOut();
                            },
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
