import 'dart:io';

import 'package:flutter/material.dart';
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
    final path = await useCase.execute();

    final normalizedPath =
        Platform.isIOS ? path?.replaceFirst('file://', '') : path;

    print(normalizedPath);
    final file = File(normalizedPath!);

    setState(() {
      _selectedImage = file;
    });
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
                      onPressed: _onPickImagePressed,
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
