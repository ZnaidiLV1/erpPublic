import 'package:flutter/cupertino.dart';

class Validators {
  /// Required field
  static String? requiredField(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est requis';
    }
    return null;
  }

  /// Email validation
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Adresse e-mail est requise';
    }

    final RegExp regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!regex.hasMatch(value.trim())) {
      return 'Adresse e-mail invalide';
    }
    return null;
  }

  /// Phone number validation
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Numéro de téléphone est requis';
    }

    final RegExp regex = RegExp(r'^[0-9]{8,15}$'); // 8–15 digits

    if (!regex.hasMatch(value.trim())) {
      return 'Numéro de téléphone invalide';
    }
    return null;
  }

  /// Password validation
  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mot de passe est requis';
    }

    if (value.length < 6) {
      return 'Mot de passe doit contenir au moins 6 caractères';
    }

    return null;
  }

  /// Confirm password validation
  static String? Function(String?) confirmPassword(
      TextEditingController passwordController) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'Confirmation du mot de passe est requise';
      }
      if (value != passwordController.text) {
        return 'Les mots de passe ne correspondent pas';
      }
      return null;
    };
  }
}
