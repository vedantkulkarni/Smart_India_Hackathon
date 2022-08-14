import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

class StudentDetailScreenPartAdmin extends StatefulWidget {
  const StudentDetailScreenPartAdmin({Key? key}) : super(key: key);

  @override
  State<StudentDetailScreenPartAdmin> createState() =>
      _StudentDetailScreenPart();
}

class _StudentDetailScreenPart extends State<StudentDetailScreenPartAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
        title: const Text(
          'Student Profile',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: blackColor),
        ),
      ),
      body: Row(children: [
        const Expanded(child: StudentDetailWidget()),
        Expanded(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(child: Col1Widget()),
              const SizedBox(
                height: 20,
              ),
              const Expanded(child: Col2Widget()),
            ],
          ),
        )
      ]),
    );
  }

  Container Col1Widget() {
    return Container(
      height: 250,
      width: 400,
      decoration: const BoxDecoration(
        // border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10),
        ],
        color: backgroundColor,
      ),
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Attendance log',
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 15, color: blackColor),
          ),
        ),
        Expanded(
          child: DataTable2(
              empty: Container(
                  child: const Center(
                child: Text('No Students added yet'),
              )),
              dataTextStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                  color: blackColor),
              headingTextStyle: const TextStyle(
                  fontSize: 16,
                  color: blackColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
              columns: const [
                DataColumn2(
                  label: Text(
                    'Sr No',
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text(
                    'Date',
                  ),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text(
                    'Present/Absent',
                  ),
                  size: ColumnSize.L,
                ),
              ],
              rows: const []),
        )
      ]),
    );
  }
}

class Col2Widget extends StatelessWidget {
  const Col2Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 400,
      decoration: const BoxDecoration(
        //border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10),
        ],
        color: backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Id card',
                  style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 15, color: blackColor),
                ),
              ),
              Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                'CSV ',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 20,
                          )
                        ]),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Assign to \n new class',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class StudentDetailWidget extends StatelessWidget {
  const StudentDetailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        height: 500,
        width: 400,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10),
          ],
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const CircleAvatar(
            radius: 45,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 43,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(""),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          RowWidget('Name', 'Harsh'),
          RowWidget('Email', 'atl@gmail.com'),
          RowWidget('Phone No.', '+91 9922889487'),
          RowWidget('Class', 'TE-01'),
          RowWidget('Teacher', 'DK'),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  Padding RowWidget(String title, String field) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            '$title : - ',
            style: const TextStyle(
                fontFamily: 'Poppins', fontSize: 17, color: blackColor),
          ),
          Text(
            field,
            style: const TextStyle(
                fontFamily: 'Poppins', fontSize: 17, color: blackColor),
          ),
        ],
      ),
    );
  }
}
