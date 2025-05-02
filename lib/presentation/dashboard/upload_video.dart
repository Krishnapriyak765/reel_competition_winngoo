import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:reels_application/core/constants/app_colors.dart';
import 'package:reels_application/main.dart';
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
    return Scaffold(
      backgroundColor: Appcolors.white,
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
                      child: Container(
                        child: Text(
                          "Competition Rules",
                          style: GoogleFonts.inter(color: Appcolors.white),
                        ),
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
                              ),
                        );
                      },
                      child: Container(
                        child: Text(
                          "Review",
                          style: GoogleFonts.inter(color: Appcolors.white),
                        ),
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
      body: _isUploaded == true ? _buildUploadedUI() : _buildVideoUploadUI(),
    );
  }

  Widget _buildVideoUploadUI() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Tap to pick video
            GestureDetector(
              onTap: pickVideo,
              child: Container(
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  color: Appcolors.background,
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
                          height: screenHeight * 0.3,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
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
                              SizedBox(height: screenHeight * 0.02),
                              DottedBorder(
                                color: Appcolors.primaryColor,
                                strokeWidth: 1,
                                dashPattern: [5, 3],
                                child: Container(
                                  height: screenHeight * 0.2,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Appcolors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/upload_placeholder.png",
                                          height: screenHeight * 0.1,
                                        ),
                                        SizedBox(height: screenHeight * 0.02),
                                        Text(
                                          "Click here to submit your video",
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          "Supports: 3GP, WEBM, MP4 or MOV",
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
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
                hintText: "Enter Type ",
                hintStyle: GoogleFonts.inter(),
                filled: true,
                fillColor: Appcolors.white,
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
                hintText: "Type here....",
                hintStyle: GoogleFonts.inter(),
                filled: true,
                fillColor: Appcolors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Appcolors.black, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Upload Button
            Center(
              child: Container(
                width: screenwidth * 0.5,
                child: ElevatedButton(
                  onPressed: () {
                    _selectedVideo != null &&
                            _typeController.text.trim().isNotEmpty &&
                            _descriptionController.text.trim().isNotEmpty
                        ? _uploadVideo
                        : _enterFieldError;
                    print("WORKING ALERT");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  child: Text(
                    "Upload",
                    style: GoogleFonts.inter(
                      color: Appcolors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _enterFieldError() {
    AlertDialog(
      title: const Text('Please Check'),
      content: const Text('Please check all the fields are filled to proceed.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget _buildUploadedUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          // Uploaded video box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Appcolors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  width: screenwidth * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child:
                        _isUploaded != null &&
                                _videoPlayerController != null &&
                                _videoPlayerController!.value.isInitialized
                            ? AspectRatio(
                              aspectRatio:
                                  _videoPlayerController!.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController!),
                            )
                            : Container(
                              height: screenHeight * 0.2,
                              width: screenwidth * 0.7,
                              color: Colors.black12,
                              child: Center(
                                child: Text("Video preview not available"),
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Already you sent reels video",
                  style: GoogleFonts.inter(fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.47,
            width: double.infinity,
            child: ReviewDialog(
              onClose: () => context.pushNamed('homewithnav'),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
        ],
      ),
    );
  }
  // bool _canUpload() {
  //   print(
  //     _selectedVideo != null &&
  //         _typeController.text.trim().isNotEmpty &&
  //         _descriptionController.text.trim().isNotEmpty,
  //   );
  //   return _selectedVideo != null &&
  //       _typeController.text.trim().isNotEmpty &&
  //       _descriptionController.text.trim().isNotEmpty;
  // }

  // Widget _buildUploadedUI() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       if (_showSuccessMessage)
  //         UploadSuccessMessage(
  //           onDismiss:
  //               _dismissSuccessMessage, // Dismiss success message on button press
  //         ),
  //       if (_videoPlayerController != null &&
  //           _videoPlayerController!.value.isInitialized)
  //         AspectRatio(
  //           aspectRatio: _videoPlayerController!.value.aspectRatio,
  //           child: VideoPlayer(_videoPlayerController!),
  //         )
  //       else
  //         const SizedBox.shrink(),
  //       const SizedBox(height: 20),
  //       // Add more post-upload info if needed
  //     ],
  //   );
  // }

  Future<void> _uploadVideo() async {
    // if (!_canUpload()) return;

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
          // _isUploading = false;
          _isUploaded = true;
        });
        print("✅ Upload successful");
      } else {
        print("❌Upload failed: ${response.statusCode}");
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
        print(_selectedVideo);
        print('_selectedVideo SUCESSFULLY');
        _selectedVideo = file;
        _videoPlayerController = controller;
      });
    }
  }
}
