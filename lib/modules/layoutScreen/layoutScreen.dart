import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/appCubit/app_states.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/components/components.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    var controller = PageController(initialPage: cubit.currentIndex);

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          drawer: defaultDrawer(context),
          appBar:
              defaultAppBar(context, cubit.titles[cubit.currentIndex], true),
          body: ConditionalBuilder(
              condition: true,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => PageView(
                    controller: controller,
                    onPageChanged: (newIndex) {
                      cubit.changeAppNav(newIndex);
                    },
                    children: cubit.appScreens,
                  )),
          bottomNavigationBar: CurvedNavigationBar(
            color: Colors.grey[100]!,
            backgroundColor: primaryColor,
            height: 60,
            items: cubit.buttonWidget(cubit.currentIndex),
            onTap: (index) {
              if (index == 1) {}
              controller.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            },
            index: cubit.currentIndex,
          ),
        );
      },
    );
  }
}
