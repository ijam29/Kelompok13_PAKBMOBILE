import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionProvider with ChangeNotifier {
  String inputText = ''; // Menyimpan input teks
  String? predictionMessage; // Menyimpan hasil prediksi

  final TextEditingController textController = TextEditingController();

  // Fungsi untuk mengupdate input text
  void updateInputText(String value) {
    inputText = value;
    notifyListeners();
  }

  // Fungsi untuk mengirim data ke API dan mendapatkan respons
  Future<void> predict() async {
    inputText = textController.text.trim(); // Menghapus spasi di awal/akhir
    if (inputText.isEmpty) {
      predictionMessage = 'Input text cannot be empty.';
      notifyListeners();
      return;
    }

    final url = Uri.parse('https://48a2-35-245-65-21.ngrok-free.app/predict');
    final body = jsonEncode({'text': inputText});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        predictionMessage =
            data['predicted_language'] ?? 'No prediction available';
      } else {
        predictionMessage = 'Failed to get prediction: ${response.statusCode}';
      }
    } catch (e) {
      predictionMessage = 'Error: $e';
    }

    clearInputText();
    notifyListeners();
  }

  // Fungsi untuk menghapus input teks setelah prediksi
  void clearInputText() {
    inputText = '';
    notifyListeners();
  }

  @override
  void dispose() {
    // Jangan lupa dispose controller ketika provider tidak lagi digunakan
    textController.dispose();
    super.dispose();
  }
}
