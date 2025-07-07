import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:libris/core/variables/global_variables.dart' show navigatorKey;
import 'package:libris/modules/about_us/about_us.dart';
import 'package:libris/modules/bottom_navigation/bottom_navigation.dart' show BottomNavigationPage;
import 'package:libris/modules/category_details/category_details.dart';
import 'package:libris/modules/category_list/category_list.dart';
import 'package:libris/modules/error/error.dart' show ErrorPage;
import 'package:libris/modules/onboard/onboard.dart' show OnboardPage;
import 'package:libris/modules/pdf_read/pdf_read.dart';
import 'package:libris/modules/pdf_theme/pdf_theme.dart';
import 'package:libris/modules/private_folder/private_folder.dart';
import 'package:libris/modules/private_folder_pin/private_folder_pin.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart'
    show NavigationHistoryObserver;

part 'app_router.dart';
part 'routes.dart';
