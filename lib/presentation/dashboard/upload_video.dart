import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:reels_application/core/constants/app_colors.dart';
import 'package:reels_application/widgets/logout_dialog.dart';
import 'package:reels_application/widgets/review_dialog.dart';
import 'package:reels_application/widgets/upload_sucessMessage.dart';
import 'package:video_player/video_player.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  File? _selectedVideo;
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isUploading = false;
  VideoPlayerController? _videoPlayerController;
  bool _isUploaded = false;
  bool _showSuccessMessage =
      true; // Track if the success message should be shown

  void _dismissSuccessMessage() {
    setState(() {
      _showSuccessMessage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var screenWidth = MediaQuery.of(context).size.width;
    // var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Video",
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Appcolors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              showMenu(
                color: Appcolors.primaryColor,
                context: context,
                position: RelativeRect.fromLTRB(1000, 80, 10, 100),
                items: [
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        context.pushNamed('competionRule');
                      },
                      child: Text(
                        "Competition Rules",
                        style: GoogleFonts.inter(color: Appcolors.white),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => ReviewDialog(
                                onClose: () => Navigator.pop(context),
                                token:
                                    "4|CAQ9z1WD9vyFSp1Nt9VeN3FfQIoIRODAWz3InEUO178ecac2",
                              ),
                        );
                      },
                      child: Text(
                        "Review",
                        style: GoogleFonts.inter(color: Appcolors.white),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        showLogoutDialog(context);
                      },
                      child: Text(
                        "Logout",
                        style: GoogleFonts.inter(color: Appcolors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: _isUploaded ? _buildUploadedUI() : _buildVideoUploadUI(),
    );
  }

  Widget _buildVideoUploadUI() {
    var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          // Tap to pick video
          GestureDetector(
            onTap: pickVideo,
            child: Container(
              height: screenHeight * 0.27,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  _selectedVideo != null && _videoPlayerController != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio:
                              _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        ),
                      )
                      : Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Upload Video",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Appcolors.primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/upload_placeholder.png",
                                      height: 60,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Drop your video here",
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Supported: .MP4, .MOV",
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Type', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          // Type Field
          TextField(
            controller: _typeController,
            decoration: InputDecoration(
              hintText: "Type here",
              hintStyle: GoogleFonts.inter(),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Appcolors.black, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Description',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Description Field
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Description",
              hintStyle: GoogleFonts.inter(),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Appcolors.black, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Upload Button
          ElevatedButton(
            onPressed: _canUpload() ? _uploadVideo : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            child:
                _isUploading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                      "Upload",
                      style: GoogleFonts.inter(
                        color: Appcolors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  bool _canUpload() {
    return _selectedVideo != null &&
        _typeController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty;
  }

  Widget _buildUploadedUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_showSuccessMessage)
          UploadSuccessMessage(
            onDismiss:
                _dismissSuccessMessage, // Dismiss success message on button press
          ),
        if (_videoPlayerController != null &&
            _videoPlayerController!.value.isInitialized)
          AspectRatio(
            aspectRatio: _videoPlayerController!.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController!),
          )
        else
          const SizedBox.shrink(),
        const SizedBox(height: 20),
        // Add more post-upload info if needed
      ],
    );
  }

  Future<void> _uploadVideo() async {
    if (!_canUpload()) return;

    setState(() => _isUploading = true);

    try {
      var uri = Uri.parse(
        "https://winngooreels.wimbgo.com/api/user/upload-video",
      );

      var request = http.MultipartRequest("POST", uri);
      request.headers['Authorization'] =
          'Bearer 3|B9LLG7y7ISsYcaDmBWEQR6iKbVv4jsmiiaNQJAeA5dc141af';

      request.files.add(
        await http.MultipartFile.fromPath('video', _selectedVideo!.path),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          _isUploading = false;
          _isUploaded = true;
        });
        print("✅ Upload successful");
      } else {
        print("❌ Upload failed: ${response.statusCode}");
        setState(() => _isUploading = false);
      }
    } catch (e) {
      print("❌ Error during upload: $e");
      setState(() => _isUploading = false);
    }
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final controller = VideoPlayerController.file(file);
      await controller.initialize();

      final duration = controller.value.duration;
      if (duration.inSeconds < 20 || duration.inSeconds > 60) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Video must be 20 to 60 seconds long")),
        );
        return;
      }

      setState(() {
        _selectedVideo = file;
        _videoPlayerController = controller;
      });
    }
  }

  Future<bool> logoutUser(String token) async {
    final url = Uri.parse("https://winngooreels.wimbgo.com/api/user/logout");

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Logout failed: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during logout: $e');
      return false;
    }
  }
}
