import 'package:date_time_picker/date_time_picker.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:team_dart_knights_sih/features/TeacherConsole/leave_application/Widgets/AppBar.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/leave_application/Widgets/BouncingButton.dart';

import 'package:team_dart_knights_sih/features/TeacherConsole/leave_application/Widgets/LeaveApply/datepicker.dart';

import '../../../../../core/constants.dart';

class LeaveApply extends StatefulWidget {
  @override
  _LeaveApplyState createState() => _LeaveApplyState();
}

class _LeaveApplyState extends State<LeaveApply>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  final searchFieldController = TextEditingController();

  late TextEditingController _applyleavecontroller;
  String _applyleavevalueChanged = '';
  String _applyleavevalueToValidate = '';
  String _applyleavevalueSaved = '';

  late TextEditingController _fromcontroller;
  String _fromvalueChanged = '';
  String _fromvalueToValidate = '';
  String _fromvalueSaved = '';

  late TextEditingController _tocontroller;
  String _tovalueChanged = '';
  String _tovalueToValidate = '';
  String _tovalueSaved = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    _applyleavecontroller =
        TextEditingController(text: DateTime.now().toString());
    _fromcontroller = TextEditingController(text: DateTime.now().toString());
    _tocontroller = TextEditingController(text: DateTime.now().toString());

    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Color:
    Colors.red;
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final GlobalKey<ScaffoldState> _scaffoldKey =
            GlobalKey<ScaffoldState>();
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: whiteColor,
          appBar: const CommonAppBar(
            key: null,
            menuenabled: true,
            notificationenabled: false,
            title: "Leave Application",
          ),
          body: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        muchDelayedAnimation.value * width, 0, 0),
                    child: const Text("Select the date for leave",
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 13,
                    ),
                    child: Container(
                      // height: height * 0.06,
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0, 0),
                            child: SizedBox(
                              width: width * 0.75,
                              child: DateTimePicker(
                                type: DateTimePickerType.date,
                                dateMask: 'dd/MM/yyyy',
                                controller: _applyleavecontroller,
                                //initialValue: _initialValue,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                calendarTitle: "Leave Date",
                                confirmText: "Confirm",
                                enableSuggestions: true,
                                //locale: Locale('en', 'US'),
                                onChanged: (val) => setState(
                                    () => _applyleavevalueChanged = val),
                                validator: (val) {
                                  setState(
                                      () => _applyleavevalueToValidate = val!);
                                  return null;
                                },
                                onSaved: (val) => setState(
                                    () => _applyleavevalueSaved = val!),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Transform(
                            transform: Matrix4.translationValues(
                                delayedAnimation.value * width, 0, 0),
                            child: const Icon(
                              Icons.calendar_today,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        muchDelayedAnimation.value * width, 0, 0),
                    child: const Text("Choose the type of leave.",
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14)),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        delayedAnimation.value * width, 0, 0),
                    // child: DropdownSearch<String>(
                    //   validator: (v) => v == null ? "required field" : null,
                    //   hint: "Please Select Leave type",
                    //   mode: Mode.MENU,
                    //   showSelectedItem: true,
                    //   items: const [
                    //     "Medical",
                    //     "Family",
                    //     "Sick",
                    //     'Function',
                    //     'Others'
                    //   ],
                    //   showClearButton: true,
                    //   clearButton: const Icon(
                    //     Icons.close,
                    //     color: primaryColor,
                    //   ),
                    //   onChanged: print,
                    // ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        muchDelayedAnimation.value * width, 0, 0),
                    child: const Text("Leave date range",
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 13,
                    ),
                    child: Container(
                      // height: height * 0.06,
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: blendColor,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Transform(
                          //   transform: Matrix4.translationValues(
                          //       muchDelayedAnimation.value * width, 0, 0),
                          //   child: const Icon(
                          //     Icons.calendar_today,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                padding: const EdgeInsets.only(left: 4.0),
                                width: width * 0.28,
                                decoration: const BoxDecoration(
                                    color: whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                        color: blendColor,
                                      )
                                    ]),
                                child: CustomDatePicker(
                                  controller: _fromcontroller,
                                  title: "From",
                                  onchanged: (val) =>
                                      setState(() => _fromvalueChanged = val),
                                  validator: (val) {
                                    setState(() => _fromvalueToValidate = val);
                                    return null;
                                  },
                                  saved: (val) =>
                                      setState(() => _fromvalueSaved = val),
                                  key: null,
                                ),
                              ),
                            ),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                muchDelayedAnimation.value * width, 0, 0),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                          ),
                          Transform(
                            transform: Matrix4.translationValues(
                                delayedAnimation.value * width, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                padding: const EdgeInsets.only(left: 4.0),
                                width: width * 0.28,
                                decoration: const BoxDecoration(
                                  color: Colors.white38,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                      color: Colors.black26,
                                    )
                                  ],
                                ),
                                child: CustomDatePicker(
                                  controller: _tocontroller,
                                  title: "To",
                                  onchanged: (String val) => setState(() {
                                    _tovalueChanged = val;
                                    print(val);
                                  }),
                                  validator: (val) {
                                    setState(() => _tovalueToValidate = val);
                                    return null;
                                  },
                                  saved: (val) =>
                                      setState(() => _tovalueSaved = val),
                                  key: null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Transform(
                      transform: Matrix4.translationValues(
                          muchDelayedAnimation.value * width, 0, 0),
                      child: const Text("Message Body",
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14))),
                  Expanded(
                    child: Transform(
                      transform: Matrix4.translationValues(
                          delayedAnimation.value * width, 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 13,
                        ),
                        child: Container(
                          // height: height * 0.06,
                          // height: height * 0.25,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: navPanecolor,
                            border:
                                Border.all(color: navIconsColor, width: 0.75),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            //autofocus: true,
                            minLines: 1,
                            maxLines: 10,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              suffixIcon: searchFieldController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () => WidgetsBinding.instance
                                          .addPostFrameCallback((_) =>
                                              searchFieldController.clear()))
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(7),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    children: [
                      Transform(
                          transform: Matrix4.translationValues(
                              muchDelayedAnimation.value * width, 0, 0),
                          child: const Text("Attach Document",
                              style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 14))),
                      const Spacer(),
                      Transform(
                        transform: Matrix4.translationValues(
                            delayedAnimation.value * width, 0, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () async {},
                              child: const Text("Click Here",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Transform(
                    transform: Matrix4.translationValues(
                        delayedAnimation.value * width, 0, 0),
                    child: Bouncing(
                      onPress: () async {
                        // var leave = Leave(
                        //     studentID: '',
                        //     leaveDate: _applyleavevalueSaved,
                        //     leaveReason: leaveReason,
                        //     leaveDays: leaveDays,
                        //     teacherID: teacherID,
                        //     leaveStatus: LeaveStatus.Pending);
                      },
                      key: null,
                      child: Container(
                        //height: 20,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primaryColor,
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Request Leave",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
