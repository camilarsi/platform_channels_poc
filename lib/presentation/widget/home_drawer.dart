import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../core/dependencies_injector.dart';
import '../../domain/usecases/pick_image_usecase.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  File? _selectedImage;
  late final PickImageUseCase useCase;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    useCase =
        Provider.of<DependenciesInjector>(
          context,
          listen: false,
        ).pickImageUseCase;
  }

  Future<void> _onPickImagePressed() async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      final path = DependenciesInjector.instance.pickImageUseCase;
      setState(() {
        _selectedImage = File(path as String);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Photo library permission rejected')),
      );
    }
  }

  _onPickImage() async {
    _onPickImagePressed();
    final imagePath = await useCase.execute();
    if (imagePath != null) {
      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child:
                          _selectedImage != null
                              ? ClipOval(
                                child: Image.file(
                                  _selectedImage!,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : Icon(
                                Icons.person,
                                size: 65,
                                color: Colors.grey,
                              ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        color:
                            _selectedImage != null
                                ? Colors.white
                                : Colors.black54,
                      ),
                      onPressed: _onPickImage,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Profile',
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
