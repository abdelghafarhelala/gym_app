import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_app/network/endpoints.dart';
import 'package:gym_app/shared/colors.dart';

class AdviceDetails extends StatelessWidget {
  final String? image;
  final String title;
  final String details;
  const AdviceDetails(
      {Key? key,
      required this.image,
      required this.title,
      required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'النصائح',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null)
              Container(
                height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage('$imageLink$image'),
                        fit: BoxFit.cover)),
              ),
            if (image == null)
              Container(
                height: 270,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/free-photo/athletic-man-woman-with-dumbbells_155003-11801.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'),
                        fit: BoxFit.cover)),
              ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: primaryColor),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              details,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
