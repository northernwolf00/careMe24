import 'dart:io';
import 'package:careme24/api/api.dart';
import 'package:careme24/blocs/service/model_chat.dart';
import 'package:careme24/blocs/service/service_cubit.dart';
import 'package:careme24/blocs/service/service_state.dart';
import 'package:careme24/theme/theme.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/custom_text_form_field.dart';
import 'package:careme24/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatClosedScreen extends StatefulWidget {
  final List<Message> message;
 final int index;
  final String id;
  final String photo;
  final String name;
  final int lastMessage;
  final String specialization;

  const ChatClosedScreen({
    super.key,
    required this.id,
    required this.photo,
    required this.name,
    required this.lastMessage,
    required this.specialization,
    required this.message,
    required this.index,
  });

  @override
  State<ChatClosedScreen> createState() => _ChatClosedScreenState();
}

class _ChatClosedScreenState extends State<ChatClosedScreen> {
  final TextEditingController messageController = TextEditingController();
  final Dio dio = Dio();

  Future<void> _sendMessage({File? file}) async {
    String message = messageController.text.trim();
    if (message.isEmpty && file == null) return;

    context.read<ServiceCubit>().sendMessage(widget.id, message, file?.path);
    messageController.clear();
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      _sendMessage(file: file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            height: getVerticalSize(69),
            leadingWidth: 39,
            leading: AppbarImage(
                height: getVerticalSize(18),
                width: getHorizontalSize(11),
                svgPath: ImageConstant.imgArrowleft,
                margin: getMargin(left: 20, top: 23, bottom: 27),
                onTap: () {
                  Navigator.pop(context);
                }),
            title: Padding(
                padding: getPadding(left: 27),
                child: Row(children: [
                  Container(
                    height: 200,
                    width: 170,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)
                            //more than 50% of width makes circle
                            ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CircleAvatar(
                        child: CustomImageView(
                          fit: BoxFit.cover,
                          url: widget.photo,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: getPadding(left: 10, top: 3, bottom: 1),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppbarSubtitle2(
                                text: widget.specialization,
                                margin: getMargin(right: 30)),
                            AppbarSubtitle2(
                              text: widget.name,
                            ),
                            Padding(
                                padding: getPadding(top: 1, right: 67),
                                child: Row(children: [
                                  const AppbarSubtitle2(text: ""),
                                  Container(
                                      height: getSize(8),
                                      width: getSize(8),
                                      margin:
                                          getMargin(left: 5, top: 3, bottom: 3),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              getHorizontalSize(4)),
                                          border: Border.all(
                                              color: ColorConstant.whiteA700,
                                              width: getHorizontalSize(1))))
                                ]))
                          ]))
                ])),
            styleType: Style.bgFillBlue60001),
        body: Container(
            width: double.maxFinite,
            padding: getPadding(top: 12, bottom: 12),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
             BlocBuilder<ServiceCubit, ServiceState>(
  builder: (context, state) {
    if (state is ServiceChatGet) {
      final messages = state.chatMessage; // Get updated messages
      final message = messages[widget.index].messages;

      return ListView.builder(
        shrinkWrap: true,
        itemCount: message.length,
        itemBuilder: (context, index) {
          final message2 = message[index];

          DateTime dateTime = DateTime.parse(message2.createdAt.toString());
          String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
          String formattedTime = DateFormat('hh:mm a').format(dateTime);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                // leading: Icon(
                //   message2.from == "user" ? Icons.person : Icons.support_agent,
                //   color: Colors.blue,
                // ),
                title: Text(
                  message2.text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "$formattedDate • $formattedTime",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                trailing: message2.readByService
                    ? Icon(Icons.done_all, color: Colors.blue)
                    : Icon(Icons.done, color: Colors.grey),
              ),
            ),
          );
        },
      );
    }

    return Center(child: CircularProgressIndicator());
  },
),

            ])),
        bottomNavigationBar: Padding(
          padding: getMargin(left: 23, right: 23, bottom: 16),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.attach_file, color: Colors.blue),
                onPressed: _selectFile,
              ),
              Expanded(
                child: CustomTextFormField(
                  controller: messageController,
                  hintText: "Сообщение",
                  textInputAction: TextInputAction.done,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.blue),
                onPressed: () => _sendMessage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
