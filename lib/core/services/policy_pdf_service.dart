import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:http/http.dart' as http;

Future<String?> fetchPdfUrl(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['pdf_url']; // Expecting format: { "pdf_url": "https://example.com/file.pdf" }
    }
  } catch (e) {
    print('Error fetching PDF URL: $e');
  }
  return null;
}

class PDFViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PDFViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF Viewer')),
      body: PDF().fromUrl(
        pdfUrl,
        // placeholder: (progress) => Center(child: Text('$progress %')),
        // errorWidget: (error) => Center(child: Text('Error loading PDF')),
      ),
    );
  }
}
