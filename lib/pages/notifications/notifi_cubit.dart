import 'dart:developer';

import 'package:careme24/api/api.dart';
import 'package:careme24/pages/notifications/notfi_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class NotificationsCubit extends Cubit<NotificationsState> {


  NotificationsCubit() : super(NotificationsInitial());

 double lat = 0.0;
  double lon = 0.0;

   



  Future<void> fetchNotifications({ required List<String> lastActiveIcons}) async {

    Position location = await Geolocator.getCurrentPosition();
        log('${location.latitude} ${location.longitude}');
        lat = location.latitude;
        lon = location.longitude;
    emit(NotificationsLoading());
    try {
       final queryParams = {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'last_active_icons': lastActiveIcons.join(','), // Join the list of strings
      };
       final response = await Api.getNotficationIcons(queryParams);
      emit(NotificationsLoaded(response));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }
}