import 'dart:convert';
import 'package:app_web/global_variable.dart';
import 'package:app_web/models/banner.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class BannerController {
  uploadBanner({required dynamic pickedImage, required context}) async {
    try {
      final couldinary = CloudinaryPublic('dj7vfoipq', 'a9ns11nw');

      CloudinaryResponse imageResponse = await couldinary.uploadFile(
          CloudinaryFile.fromBytesData(pickedImage,
              identifier: "pickedImage", folder: "banners"));
      String image = imageResponse.secureUrl;

      BannerModel bannerModel = BannerModel(id: '', image: image);

      http.Response response = await http.post(
        Uri.parse("$uri/api/banners"),
        body: bannerModel.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () => showSnackBar(context, "Uploaded Banner"));
    } catch (e) {
      showSnackBar(context, "Error: $e");
    }
  }

  // fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banners'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        throw Exception('Failed to load banners');
      }
    } catch (e) {
      throw Exception('Error from "Catch" loading banners: $e');
    }
  }
}
