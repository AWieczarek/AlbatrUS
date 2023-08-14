import 'package:albatrus/dashboard/asia_sandbox.dart';
import 'package:albatrus/dashboard/dashboard-tile.dart';
import 'package:albatrus/dashboard/post_list.dart';
import 'package:albatrus/login/login_code_page.dart';
import 'package:albatrus/login/login_username_page.dart';
import 'package:albatrus/my_home.dart';
import 'package:flutter/material.dart';

import 'api_routes.dart';
import 'login/login_page.dart';

var customRoutes = <String, WidgetBuilder>{
  AppRoutes.login: (_) => const LoginPage(),
  AppRoutes.loginCode: (_) => const LoginCodePage(),
  AppRoutes.loginUsername: (_) => const LoginUsernamePage(),
  AppRoutes.home: (_) => MyHome(),
  AppRoutes.postList: (_) => PostList(),
};