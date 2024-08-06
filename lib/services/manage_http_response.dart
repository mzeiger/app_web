import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(duration: const Duration(seconds: 7),
      content: Text(title),
    ),
  );
}

void manageHttpResponse(
    {required http.Response response,
    required BuildContext context, // needed to show Snackbar
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400: // indicates bad request
      showSnackBar(context, json.decode(response.body)['msg']);
      // Note that ['msg'] must be same key as in auth.js in backendAPI
      break;
    case 500: // indicates server error
      showSnackBar(context, json.decode(response.body)['error']);
      // Note that ['msg'] must be same key as in auth.js in backendAPI
      break;
    case 201: // indicates a source was created successfullu
      onSuccess();
      break;
  }
}
