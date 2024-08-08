import 'package:app_web/controllers/category_controller.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:app_web/views/side_bar_screens.dart/widgets/category_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  static const String id = "categoriesScreen";
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  final CategoryController _categoryController = CategoryController();

  late String _categoryName;

  bool _isloading = false;

  dynamic _categoryImage;
  pickCategoryImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        _categoryImage = result.files.first.bytes;
      });
    }
  }

  dynamic _bannerImage;
  pickBannerImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        _bannerImage = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            firstDivision(), // The "Categories" heading

            divider(),

            secondDivision(),

            // thirdDivision(),

            divider(),
            const CategoryWidget(),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Padding(
        padding: EdgeInsets.all(8.0), child: Divider(color: Colors.grey));
  }

  Widget firstDivision() {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text(
        'Categories',
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget secondDivision() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                    child: _categoryImage != null
                        ? Image.memory(_categoryImage)
                        : const Text('Category Image')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => pickCategoryImage(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 71, 98, 235)),
                  child: const Text(
                    'Pick Category Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          thirdDivision(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 300,
              child: TextFormField(
                // Category Name
                controller: _textEditingController,
                onChanged: (value) => _categoryName = value,
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return 'Please enter a category name';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Enter Category Name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                // Delete button
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _bannerImage = null;
                      _categoryImage = null;
                      _textEditingController.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 181, 185, 207)),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              ElevatedButton(
                // Save button
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      setState(() {
                        _isloading = true;
                      });
                      await _categoryController.uploadCategory(
                          pickedImage: _categoryImage,
                          pickedBanner: _bannerImage,
                          name: _categoryName,
                          context: context);

                      showSnackBar(context, "Images saved");
                      setState(() {
                        _bannerImage = null;
                        _categoryImage = null;
                        _textEditingController.clear();
                        _isloading = false;
                      });
                    } catch (e) {
                      showSnackBar(context, e.toString());
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 71, 98, 235)),

                child: !_isloading
                    ? const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      )
                    : const CircularProgressIndicator(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget thirdDivision() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: _bannerImage != null
                    ? Image.memory(_bannerImage)
                    : const Text('Banner Image')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => pickBannerImage(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 71, 98, 235)),
              child: const Text(
                'Pick Banner Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
