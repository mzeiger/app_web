import 'package:app_web/controllers/banner_controller.dart';
import 'package:app_web/views/side_bar_screens.dart/banner_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadBannersScreen extends StatefulWidget {
  static const String id = 'bannersScreen';
  const UploadBannersScreen({super.key});

  @override
  State<UploadBannersScreen> createState() => _UploadBannersScreenState();
}

class _UploadBannersScreenState extends State<UploadBannersScreen> {
  final BannerController _bannerController = BannerController();

  bool _isLoading = false;

  dynamic _image;
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            screenTitle(),
            divider(),
            section1(),
            divider(),
            BannerWidget(),
          ],
        ),
      ),
    );
  }

  Widget screenTitle() {
    return Container(
        alignment: Alignment.topCenter,
        child: const Text(
          'Banners',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ));
  }

  Widget section1() {
    return Form(
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              // the container holding the image
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: _image != null
                    ? Image.memory(_image)
                    : const Text('Banner Image'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                // Upload Image
                onPressed: () => pickImage(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 71, 98, 235)),
                child: const Text(
                  'Upload Image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            !_isLoading
                ? ElevatedButton(
                    // Save
                    onPressed: () async {
                      setState(() => _isLoading = true);
                      await _bannerController.uploadBanner(
                          pickedImage: _image, context: context);
                      setState(() => _isLoading = false);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 71, 98, 235)),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : const CircularProgressIndicator(color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(color: Colors.grey, thickness: 2);
  }
}
