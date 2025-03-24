import 'package:careme24/pages/medical_bag/create_aid_kit.dart';
import 'package:careme24/pages/medical_bag/cubit/aid_kit_cubit.dart';
import 'package:careme24/pages/medical_bag/cubit/aid_kit_state.dart';
import 'package:careme24/pages/medical_bag/medicina_list_scree.dart';
import 'package:careme24/pages/medical_bag/update_aid_kit.dart';
import 'package:careme24/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/app_bar/appbar_image.dart';
import 'package:careme24/widgets/app_bar/appbar_title.dart';
import 'package:careme24/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicalBagPage extends StatefulWidget {
  const MedicalBagPage({super.key});

  @override
  State<MedicalBagPage> createState() => _MedicalBagPageState();
}

class _MedicalBagPageState extends State<MedicalBagPage> {


  @override
  void initState() {
    super.initState();
    // Fetch the aid kits when the page is loaded
    context.read<AidKitCubit>().getAidKit();
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
          text: "Домашняя аптечка",
        ),
        styleType: Style.bgFillBlue60001,
        actions: [
          GestureDetector(
            onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedicineBagAddScreen()),
          );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(
                  'assets/images/add_image.png',
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AidKitCubit, AidKitState>(
          builder: (context, state) {
            if (state is AidKitLoading) {
              return const Center(child: CircularProgressIndicator());
            } else
             if (state is AidKitError) {
              return Center(child: Text(state.message));
            } else if (state is AidKitLoaded) {
              final aidKitList = state.aidKits;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'МОЯ АПТЕЧКА'),
                const SizedBox(height: 8),
                Expanded(
                    child: ListView.builder(
                      itemCount: aidKitList.length,
                      itemBuilder: (context, index) {
                        final aidKit = aidKitList[index];
                        return MedicineBoxCard(
                          icon: aidKit.photo,
                          title: aidKit.title,
                          id: aidKit.id,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicineListScreen(
                                      title: aidKit.title,
                                      id: aidKit.id,
                                      photo: aidKit.photo)),
                            );
                          },
                        );
                      },
                    ),
                  ),
              //   MedicineBoxCard(
              //     icon: Icons.medical_services,
              //     title: 'Аптечка №1',
              //     onTap: () {
              //       Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MedicineListScreen(title: "Аптечка №1")),
              // );
                   
              //     },
              //   ),
              //   const SizedBox(height: 8),
              //   MedicineBoxCard(
              //     icon: Icons.inventory,
              //     title: 'Аптечка №2',
              //     onTap: () {
              //       Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MedicineListScreen(title: "Аптечка №2")),
              // );
                   
              //     },
              //   ),
              //   const SizedBox(height: 24),
                
              ],
            );}else {
              return const Center(child: Text('Нет доступных данных'));
            }
            
          }
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    );
  }
}

class MedicineBoxCard extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final String id;

  const MedicineBoxCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.id,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        _showOptions(context);
      },
      child: Card(
        color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            height: 72,
            child: Row(
              children: [
                CustomImageView(
                  url: icon,
                  height: 40,
                  width: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(title,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 20, color: Colors.grey,),
              ],
            ),
          )),
    );
  }




  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text('Изменить'),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineBagUpdateScreen(
                        id: id,
                        title: title,
                        image: icon,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: Text('Удалить'),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet
                  context.read<AidKitCubit>().deletAidKit(id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}


 


class AddButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AddButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// const SectionTitle(title: 'ЗАПРОСЫ'),
            // const SizedBox(height: 8),
            // AddButton(
            //   title: 'Добавить запрос',
            //   onTap: () {
          //       Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => MedicineListScreen(title: "")),
          // );
                // Handle "Добавить запрос" button
            //   },
            // ),
            // const SizedBox(height: 24),
            // const SectionTitle(title: 'ДОПОЛНИТЕЛЬНО'),
            // const SizedBox(height: 8),
            // AddButton(
            //   title: 'Добавить',
            //   onTap: () {
          //       Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => MedicineListScreen(title: "title")),
          // );
                // Handle "Добавить" button
            //   },
            // ),