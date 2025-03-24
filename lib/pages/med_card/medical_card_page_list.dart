  import 'dart:developer';
  import 'package:careme24/blocs/app_bloc.dart';
  import 'package:careme24/blocs/medcard/medcard_cubit.dart';
  import 'package:careme24/blocs/medcard/medcard_state.dart';
import 'package:careme24/models/user_model.dart';
  import 'package:careme24/pages/med_card/medical_card_page.dart';
  import 'package:careme24/theme/theme.dart';
import 'package:careme24/utils/image_constant.dart';
import 'package:careme24/utils/size_utils.dart';
import 'package:careme24/widgets/med_card_request.dart';
  import 'package:careme24/widgets/med_card_widget/medical_card_widget.dart';
import 'package:careme24/widgets/search.dart';
  import 'package:careme24/widgets/widgets.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import '../../widgets/med_card_widget/add_button.dart';

  class MedicalCardListPage extends StatefulWidget {
    const MedicalCardListPage({super.key});

    @override
    State<MedicalCardListPage> createState() => _MedicalCardListPageState();
  }

  class _MedicalCardListPageState extends State<MedicalCardListPage> {

    @override
    void initState() {
      AppBloc.medCardCubit.fetchData();
      super.initState();
    }

    bool showSearch = false;
    UserModel? selectedUser; 

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: CustomAppBar(
          actions: [
            GestureDetector(
              onTap: () {
              },
              child: Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.transparent,
                  height: 20,
                  child: Image.asset(
                    'assets/images/icon-plus.png',
                  )),
            )
          ],
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
            text: "Мед.карты",
            margin: getMargin(
              left: 15,
            ),
          ),
          styleType: Style.bgFillBlue60001,
        ),
        body: BlocBuilder<MedCardCubit, MedCardState>(
          builder: (context, state){
            if (state is MedCardLoaded) {
              return Container(
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                height: double.maxFinite,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'МОЯ КАРТА',
                            style: AppStyle.txtInterExtraBold12.copyWith(
                                color: const Color(
                                  0xff2C3E4F,
                                ).withOpacity(0.8),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          state.myCard.haveCard
                            ?
                              MediacalCardWidget(
                                displayName: state.myCard.personalInfo.full_name,
                                phoneNumber: '${state.myCard.personalInfo.phone}',
                                imagePath: state.myCard.personalInfo.avatar,
                                onTap: (){
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => MedicalCardPage(medcardModel: state.myCard,)));
                                }
                              )
                            : AddButton(
                                buttonText: 'Добавить карту для меня',
                                onTap: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => MedicalCardPage(
                                      medcardModel: state.myCard, 
                                      createMode: true,
                                      myCard: true,
                                    )));
                                },            
                              ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'МЕД. КАРТЫ В УПРАВЛЕНИИ',
                            style: AppStyle.txtInterExtraBold12.copyWith(
                                color: const Color(
                                  0xff2C3E4F,
                                ).withOpacity(0.8),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                            
                          ),
                          if(state.otherCards.isNotEmpty)
                          SizedBox(
                            height: 100,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(state.otherCards.length, (index) {
                                    return SizedBox(  
                                      width: size.width - 50,  
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: MediacalCardWidget(
                                          displayName: state.otherCards[index].personalInfo.full_name,
                                          phoneNumber: '${state.otherCards[index].personalInfo.phone}',
                                          imagePath: state.otherCards[index].personalInfo.avatar,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => MedicalCardPage(
                                                medcardModel: state.otherCards[index],
                                                myCard: false,
                                              )),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                          AddButton(
                            buttonText: 'Добавить карту',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MedicalCardPage(
                                  medcardModel: state.myCard,
                                  createMode: true,
                                  myCard: false,
                                )),
                              );
                            },
                          ),
                          if(state.unverifiedCards.isNotEmpty)
                          Text(
                            'ПЕРЕДАЧИ ПРОФИЛЯ',
                            style: AppStyle.txtInterExtraBold12.copyWith(
                                color: const Color(
                                  0xff2C3E4F,
                                ).withOpacity(0.8),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          state.unverifiedCards.isNotEmpty 
                          ? Column(
                            children: [
                              ...List.generate(state.unverifiedCards.length, (index){
                                return MedCardRequest(medcard: state.unverifiedCards[index]);
                              })
                            ],
                          )
                          : SizedBox.shrink(),
                          SizedBox(height: 5,),
                          Text(
                            'ЗАПРОСЫ',
                            style: AppStyle.txtInterExtraBold12.copyWith(
                                color: const Color(
                                  0xff2C3E4F,
                                ).withOpacity(0.8),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          state.toMeRequests.isNotEmpty 
                          ? Column(
                            children: [
                              ...List.generate(state.toMeRequests.length, (index){
                                return MedCardRequest(
                                  shareMode: false,
                                  medcard: state.toMeRequests[index]
                                );
                              })
                            ],
                          )
                          : SizedBox.shrink(),
                          AddButton(
                            buttonText: 'Добавить запрос',
                            onTap: () {
                              setState(() {
                                showSearch = true;
                              });
                            },
                          ),
                          Container(
                            child: Text(
                              'ДОПОЛНИТЕЛЬНО',
                              style: AppStyle.txtInterExtraBold12.copyWith(
                                  color: const Color(
                                    0xff2C3E4F,
                                  ).withOpacity(0.8),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          AddButton(
                            buttonText: 'Добавить',
                            onTap: () {},
                          ),
                        ],
                      ),
                      if(showSearch)
                      Search(
                        shareProfile: false,
                        onCloseTap: (){
                          setState(() {
                            showSearch = false;
                          });
                        }, 
                        onUserSelect: (user){
                          setState(() {
                            selectedUser = user;
                            if (selectedUser!.medCardID != '') {
                              log(selectedUser!.medCardID);
                              AppBloc.medCardCubit.sendRequest(selectedUser!.id);
                            }
                            showSearch = false;
                          });
                      })
                    ],
                  )
                ),
              );
            }else{
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          }
        )
      );
    }
  }
