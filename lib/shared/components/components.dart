import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_app/modules/advice_details/advice_details.dart';
import 'package:gym_app/modules/home/home_screen.dart';
import 'package:gym_app/modules/login/login.dart';
import 'package:gym_app/modules/myDrawer/myDrawer.dart';
import 'package:gym_app/modules/package_details/package_details_screen.dart';
import 'package:gym_app/network/endpoints.dart';
import 'package:gym_app/shared/appCubit/app_cubit.dart';
import 'package:gym_app/shared/colors.dart';
import 'package:gym_app/shared/const.dart';
import 'package:hexcolor/hexcolor.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

Widget defaultButton(
        {double width = double.infinity,
        required double height,
        Color color = buttonColor,
        required Function onPress,
        required String text,
        double radius = 0.0,
        bool isUpper = false,
        double fontSize = 25}) =>
    MaterialButton(
      color: primaryColor,
      minWidth: width,
      height: height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(27.0))),
      onPressed: () {
        onPress();
      },
      child: Text(
        isUpper ? text.toUpperCase() : text,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
Widget defaultButton2({
  required double width,
  required double height,
  required Color color,
  required Function onPress,
  required String text,
  double radius = 0.0,
  bool isUpper = false,
}) =>
    MaterialButton(
      color: color,
      minWidth: width,
      height: height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(27.0))),
      onPressed: () {
        onPress();
      },
      child: Text(
        isUpper ? text.toUpperCase() : text,
        style: const TextStyle(color: Colors.white, fontSize: 25),
      ),
    );

Widget defaultTextField({
  required String lable,
  required IconData prefix,
  bool isEnabled = true,
  Function? validate,
  required context,
  IconData? suffix,
  ImageIcon? imageIcon,
  Function? suffixPressed,
  bool isSecure = false,
  required TextInputType type,
  List<TextInputFormatter> formats = const [],
  required var controller,
  Function? ontap,
  // Function? onChange,
}) =>
    TextFormField(
      enabled: isEnabled,
      inputFormatters: formats,
      // style: Theme.of(context).textTheme.button,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
            icon: Icon(suffix),
            onPressed: () {
              suffixPressed!();
            }),
      ),
      keyboardType: type,
      obscureText: isSecure,
      validator: (String? s) {
        return validate!(s);
      },
      controller: controller,
      onTap: () {
        ontap!();
      },
      // onChanged: (String s){
      //     onChange!(s);
      // },
    );

Widget defaultTextFieldWithCustomIconImage({
  String? lable,
  String? hint,
  ImageIcon? prefix,
  required Function? validate,
  bool isEnabled = true,
  required context,
  IconData? suffix,
  ImageIcon? imageIcon,
  Function? suffixPressed,
  bool isSecure = false,
  required TextInputType type,
  var controller,
  int maxLines = 1,
  // Function? ontap,
  // Function? onChange,
}) =>
    TextFormField(
      enabled: isEnabled,

      // style: Theme.of(context).textTheme.button,
      decoration: InputDecoration(
        hintText: hint,
        disabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        labelText: lable,
        prefixIcon: prefix,
        prefixIconConstraints:
            BoxConstraints(maxHeight: 40, maxWidth: 50, minWidth: 50),
        suffixIcon: IconButton(
            icon: Icon(suffix),
            onPressed: () {
              suffixPressed!();
            }),
      ),
      maxLines: maxLines,
      keyboardType: type,
      obscureText: isSecure,
      validator: (String? s) {
        return validate!(s);
      },
      controller: controller,
      onTap: () {
        // ontap!();
      },
      // onChanged: (String s){
      //     onChange!(s);
      // },
    );

void showToast({@required String? text, @required ToastStates? state}) =>
    Fluttertoast.showToast(
        msg: text!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 7,
        backgroundColor: toastColor(state!),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, Warrnaing }

Color? color;
Color? toastColor(ToastStates state) {
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = HexColor('#F02525');
      ;
      break;
    case ToastStates.Warrnaing:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget defaultDrawer(context) => Container(
      padding: EdgeInsets.all(0),
      width: 250,
      child: Drawer(
        child: Column(
          children: [
            const MyDrawer(),
            const MyDrawer().myDrawerList(context),
          ],
        ),
      ),
    );

PreferredSizeWidget defaultAppBar(context, String title, isFirst) => AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppCubit.get(context).currentIndex != 4
            ? primaryColor
            : Colors.white,
        statusBarIconBrightness: AppCubit.get(context).currentIndex != 4
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: AppCubit.get(context).currentIndex != 4
            ? Brightness.dark
            : Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: AppCubit.get(context).currentIndex != 4
            ? Colors.white
            : Colors.black,
      ),
      centerTitle: false,
      backgroundColor:
          AppCubit.get(context).currentIndex != 4 ? primaryColor : Colors.white,
      titleTextStyle: GoogleFonts.elMessiri(
        textStyle: TextStyle(
            color: AppCubit.get(context).currentIndex != 4
                ? Colors.white
                : Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold),
      ),
      elevation: 0,
      title: Text(title),
      actions: [
        if (!isFirst)
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_forward))
      ],
    );

Widget buildTrainItem(
        context, trainD, String? image, bool isPackages, bool isTrain,
        {train, rate, price, model, sessionNum}) =>
    InkWell(
      onTap: () {
        navigateTo(
            context,
            PackageDetailsScreen(
              packageModel: model,
            ));
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: SizedBox(
                height: 130,
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (image == null)
                          Container(
                            width: 130,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://img.freepik.com/free-photo/sports-fitness-energy-active-healthy-lifestyle-determined-afro-american-male-wearing-stylish-training-outfit-while-working-out-gym-doing-abdominal-endurance-exercise-sit-ups-curl-ups_343059-448.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357'),
                                    fit: BoxFit.cover)),
                          ),
                        if (image != null)
                          Container(
                            width: 130,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('$imageLink$image'),
                                    fit: BoxFit.cover)),
                          ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trainD ?? 'لا يوجد اسم',
                              style: const TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            if (isPackages == false)
                              Text(
                                '${train?.startDate ?? ''}',
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            const SizedBox(
                              height: 3,
                            ),
                            if (isPackages == false)
                              Text(
                                'منذ ${DateTime.now().difference(DateTime.parse(train!.startDate ?? DateTime.now().toString())).inDays} يوم',
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            if (isPackages == true)
                              Text(
                                'السعر : ${price ?? 0} جنيه',
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            if (isPackages == true && isTrain == false)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    itemSize: 18,
                                    initialRating: rate ?? 1,
                                    ignoreGestures: true,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      // color: primaryColor,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                      'عدد التقييمات  :  ${model?.ratesCount ?? 0}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
                                ],
                              ),
                            if (isPackages == true && isTrain == true)
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${sessionNum ?? '0'} حصص',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          if (isPackages == true && isTrain == false && token != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    AppCubit.get(context)
                        .makeFavorite(type: 'package', id: model!.id!);
                  },
                  icon: Icon(
                    Icons.favorite,
                    size: 30,
                    color: (AppCubit.get(context).favorites[model?.id]) == true
                        ? primaryColor
                        : Colors.grey[300],
                  )),
            )
        ],
      ),
    );

Widget buildNoItem() => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/no.jpg'),
                  fit: BoxFit.fill,
                  opacity: .8)),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'لا توجد بيانات هنا',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        )
      ],
    );

Widget buildPlanItem(
        {required context,
        required String name,
        required String details,
        required String? image}) =>
    Container(
      height: 130,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            if (image == null)
              Image.network(
                'https://img.freepik.com/free-photo/athletic-man-woman-with-dumbbells_155003-11801.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
                width: 120,
                height: 130,
                fit: BoxFit.cover,
              ),
            if (image != null)
              Image.network(
                '$imageLink${image}',
                width: 120,
                height: 130,
                fit: BoxFit.cover,
              ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      details,
                      style: Theme.of(context).textTheme.caption,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget buildSliderItem(double hight, double padding) => Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CarouselSlider(
          items: imgList
              .map(
                (e) => Image(
                  image: NetworkImage(e),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: hight,
            initialPage: 0,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            reverse: false,
          ),
        ),
      ),
    );

Widget buildAdviceItem(String? image, String text, context, String details,
        bool isStack, bool isRequest, String appBarTitle) =>
    InkWell(
      onTap: () {
        navigateTo(
            context,
            AdviceDetails(
              image: image,
              title: text,
              details: details,
              isRequest: isRequest,
              appBarTitle: appBarTitle,
            ));
      },
      child: SizedBox(
        width: 280,
        child: Card(
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  if (image == null)
                    Container(
                      height: 160,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                'https://img.freepik.com/free-photo/athletic-man-woman-with-dumbbells_155003-11801.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
                              ),
                              fit: BoxFit.cover)),
                    ),
                  if (image != null)
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7),
                            topRight: Radius.circular(7),
                          ),
                          image: DecorationImage(
                              image: NetworkImage(
                                '$imageLink$image',
                              ),
                              fit: BoxFit.cover)),
                    ),
                  if (isStack)
                    Container(
                      padding: EdgeInsets.all(10),
                      width: 220,
                      child: Text(
                        text,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
              if (isStack == false)
                const SizedBox(
                  height: 10,
                ),
              if (isStack == false)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (isStack == false)
                const SizedBox(
                  height: 5,
                ),
            ],
          ),
        ),
      ),
    );

Widget buildOfferItem(
        String? image, String name, context, int sessionNum, int price) =>
    SizedBox(
      width: 280,
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Stack(
              alignment: Alignment(-3.3, -.2),
              children: [
                if (image == null)
                  Container(
                    height: 160,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(7),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://img.freepik.com/premium-photo/young-ripped-man-bodybuilder-with-perfect-abs-shoulders-biceps-triceps-chest-posing-with-dumbbell_136403-1032.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
                            ),
                            fit: BoxFit.cover)),
                  ),
                if (image != null)
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(7),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                              '$imageLink$image',
                            ),
                            fit: BoxFit.cover)),
                  ),
                RotationTransition(
                  turns: new AlwaysStoppedAnimation(320 / 360),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                        // color: primaryColor.withOpacity(.7),
                        color: Colors.green.withOpacity(.7),
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        '$sessionNum حصص بسعر $price جنيه فقط',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );

Widget buildLoginItem(context) => Column(
      children: [
        Image.network(
          'https://img.freepik.com/free-vector/welcome-concept-illustration_23-2148277019.jpg?size=626&ext=jpg&uid=R76996913&ga=GA1.2.1634405249.1648830357',
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'لم تسجل دخول بعد لنعرض هذه البيانات سجل معنا الآن لتري مزايا التطبيق ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              defaultButton(height: 50, onPress: () {}, text: 'تسجيل الدخول'),
        )
      ],
    );
