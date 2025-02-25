import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:careme24/widgets/avatar_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

class FilesZone extends StatefulWidget {
  const FilesZone({
    super.key,
    required this.files,
    required this.onChange,
  });

  final Function(List<File>) onChange;
  final List<String> files;

  @override
  State<FilesZone> createState() => _FilesZoneState();
}

class _FilesZoneState extends State<FilesZone> {
  final ImagePicker _imagePicker = ImagePicker();
  List<String> _files = [];
  final List<File> _filelist = [];
  bool i = true;

  @override
  void initState() {
    _files = widget.files;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...List.generate(_files.length, (index) {
              return fileZone(context, _files[index], index);
            }),
            GestureDetector(
              onTap: () {
                _pickFromSource(context);
              },
              child: Container(
                height: size.width * 0.25,
                width: size.width * 0.32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(242, 243, 245, 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Color.fromRGBO(129, 140, 153, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _pickFromSource(BuildContext context) {
    showBarModalBottomSheet(
      expand: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const PickUploadSource(file: true),
    ).then((value) {
      if (value is ImageSource) {
        _uploadImage(value);
      } else if (value == 'file') {
        _pickFile();
      }
    });
  }

    void _uploadImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile == null) return;

      setState(() {
        
        if (i) {
          _files.clear();
          _filelist.clear();
          i = false;
        }

        _files.add(pickedFile.path);
        _filelist.add(File(pickedFile.path));
      });
      widget.onChange(_filelist);
    } catch (e) {
      log('$e');
    }
  }

  void _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        setState(() {

        if (i) {
          _files.clear();
          _filelist.clear();
          i = false;
        }

          _files.add(result.files.single.path!);
          _filelist.add(File(result.files.single.path!));
        });
        widget.onChange(_filelist);
      }
    } catch (e) {
      log('$e');
    }
  }

  Widget fileZone(BuildContext context, String filePath, int fileIndex) {
    Size size = MediaQuery.sizeOf(context);
    bool isImage = filePath.endsWith('.png') || filePath.endsWith('.jpg') || filePath.endsWith('.jpeg');
    bool isPdf = filePath.endsWith('.pdf');
    bool isUrl = Uri.tryParse(filePath)?.hasScheme == true;

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (isImage) {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: isUrl
                      ?  CachedNetworkImage(
                          imageUrl: filePath,
                          width: size.width,
                          fit: BoxFit.cover,
                      )
                      : Image.file(
                          File(filePath),
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                ),
              );
            } else if (isPdf || isUrl) {
              _launchURL(filePath);
            } else {
              OpenFile.open(filePath);
            }
          },
          child: Container(
            height: size.width * 0.25,
            width: size.width * 0.32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(242, 243, 245, 1),
            ),
            child: isImage
                ? isUrl
                    ? CachedNetworkImage(imageUrl: filePath, fit: BoxFit.cover,)
                    : Image.file(File(filePath), fit: BoxFit.cover)
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.insert_drive_file, size: 50, color: Colors.grey),
                        Text('Файл', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
          ),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _files.removeAt(fileIndex);
                _filelist.removeAt(fileIndex);
                widget.onChange(_filelist);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.red,
                size: 15.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
