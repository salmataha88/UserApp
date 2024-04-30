import 'dart:io';
import 'dart:typed_data';
import 'package:app/helper/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../helper/database_helper.dart';
import 'editPage.dart';


class ProfilePage extends StatefulWidget {
  String userEmail;
  
  ProfilePage({required this.userEmail});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  Users user = Users() ;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      Map<String, dynamic>? userData = await DatabaseHelper.instance.getUserByEmail(widget.userEmail);
      if (userData != null) {
        setState(() {
          user = Users(
            name: userData['name'],
            email: userData['email'],
            studentId: userData['studentId'],
            password: userData['password'],
            profilePhoto: userData['profilePhoto'],
            level: userData['level'],
            gender: userData['gender']
          );
        });
      } else {
        setState(() {
          user = Users(
            name: 'N/A',
            email: 'N/A',
            studentId: 'N/A',
            password: 'N/A',
            level: 'N/A',
            gender: 'N/A',
          );
        });
      }
    } catch (e) {
      print('Error fetching user data from SQLite: $e');
    }
  }


  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  /*Future<void> _uploadPhoto() async {
    try {
      if (_image != null) {
        firebase_storage.FirebaseStorage storage =
            firebase_storage.FirebaseStorage.instance;

        firebase_storage.Reference ref = storage
            .ref()
            .child('profile_photos/${user?.studentId}.jpg');

        await ref.putFile(_image!);

        String downloadURL = await ref.getDownloadURL();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile photo uploaded successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No photo selected')),
        );
      }
    } catch (e) {
      print('Error uploading photo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading photo')),
      );
    }
  }

  Future<void> _uploadPhoto() async {
    try {
      if (_image != null) {
        List<int> imageBytes = await _image!.readAsBytes();

        // Save the image bytes along with other user data
        Map<String, dynamic> userData = {
          'name': user.name,
          'email': user.email,
          'studentId': user.studentId,
          'password': user.password,
          'profilePhoto': imageBytes,
        };
        await DatabaseHelper.instance.updateUser(widget.userEmail, userData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile photo uploaded successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No photo selected')),
        );
      }
    } catch (e) {
      print('Error uploading photo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading photo')),
      );
    }
  }
*/

  Future<void> _uploadPhoto() async {
    try {
      if (_image != null) {
        // Get the photo data as bytes
        List<int> photoBytes = await _image!.readAsBytes();

        // Update the user's photo data in the SQLite database
        await DatabaseHelper.instance.updateUserPhoto(user.email!, Uint8List.fromList(photoBytes));

        setState(() {
          // Assign the new photo data to the user object
          user.profilePhoto = photoBytes;
        });
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile photo uploaded successfully')),
        );
      } else {
        // If no photo is selected, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No photo selected')),
        );
      }
    } catch (e) {
      // Show error message if an error occurs
      print('Error uploading photo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading photo')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(user: user),
                ),
              ).then((newEmail) {
                widget.userEmail = newEmail;
                _fetchUserData();
                print('Returned data: $newEmail');
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: user.profilePhoto != null
                  ? CircleAvatar(
                radius: 60,
                backgroundImage: MemoryImage(Uint8List.fromList(user.profilePhoto!)),
              )
                  : Icon(Icons.person, size: 60),
            ),


            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.gallery),
                  child: Text('Gallery'),
                ),
                ElevatedButton(
                  onPressed: () => _getImage(ImageSource.camera),
                  child: Text('Camera'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            if (user.name != null)
              Text(
                'Name: ${user.name}',
                style: TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 10),
            if (user.email != null)
              Text(
                'Email: ${user.email}',
                style: TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 10),
            if (user.studentId != null)
              Text(
                'Student ID: ${user.studentId}',
                style: TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 10),
            if (user.level != null)
              Text(
                'Level: ${user.level}',
                style: TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 10),
            if (user.gender != null)
              Text(
                'Gender: ${user.gender}',
                style: TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _uploadPhoto,
              child: Text('Change Photo'),
            ),
          ],
        ),
      ),
    );
  }
}