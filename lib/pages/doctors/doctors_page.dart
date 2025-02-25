import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  final List<BookmarkItem> items = [
    BookmarkItem(title: 'Врач 2', phone: '+7 952 934 91 24'),
    BookmarkItem(title: 'Врач 3', phone: '+7 952 934 91 24'),
    BookmarkItem(title: 'Врач 4', phone: '+7 952 934 91 24'),
    BookmarkItem(title: 'Врач 5', phone: '+7 952 934 91 24'),
    BookmarkItem(title: 'Врач 6', phone: '+7 952 934 91 24'),
  ];

  void _callNumber(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: getVerticalSize(48),
        leadingWidth: 43,
        leading: AppbarImage(
            height: getVerticalSize(16),
            width: getHorizontalSize(11),
            svgPath: ImageConstant.imgArrowleft,
            margin: getMargin(left: 15, top: 15, bottom: 15),
            onTap: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: AppbarTitle(
          text: "Врачи",
        ),
        styleType: Style.bgFillBlue60001,
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            color: Colors.white,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(height: 24),
              itemBuilder: (context, index) {
                final item = items[index];
                return  Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundImage: AssetImage('assets/images/profil.png'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '+7-952-943-43-88',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                           Padding(
                             padding: const EdgeInsets.only(right: 10),
                             child: SvgPicture.asset("assets/icons/heart.svg"),
                           ),
                        ],
                      ),
                  ],
                );
                
                 
                
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BookmarkItem {
  final String title;
  final String phone;

  BookmarkItem({required this.title, required this.phone});
}
