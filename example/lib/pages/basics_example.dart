// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<String, String> maps = Map();

  HashMap<DateTime, List<Event>> hashMaps = HashMap();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Basics'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleTextStyle: TextStyle(
                  color: Color(0xff272727),
                  fontSize: 14,
                  fontFamily: "Figtree",
                  fontWeight: FontWeight.w700,
                ),
                leftChevronIcon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Color(0xffe9e9e9),
                      width: 0.50,
                    ),
                  ),
                  child: Icon(Icons.chevron_left, color: Color(0xff151a21)),
                ),
                rightChevronIcon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Color(0xffe9e9e9),
                      width: 0.50,
                    ),
                  ),
                  child: Icon(Icons.chevron_right, color: Color(0xff151a21)),
                )),
            daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: Color(0xff151a21),
                  fontSize: 12,
                ),
                weekendStyle: TextStyle(
                  color: Color(0xff151a21),
                  fontSize: 12,
                )),
            calendarStyle: CalendarStyle(),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              // Use `selectedDayPredicate` to determine which day is currently selected.
              // If this returns true, then `day` will be marked as selected.

              // Using `isSameDay` is recommended to disregard
              // the time-part of compared DateTime objects.
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                // Call `setState()` when updating the selected day
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
              final kEvents = LinkedHashMap<DateTime, List<Event>>(
                equals: isSameDay,
                hashCode: getHashCode,
              )..addAll(hashMaps);
              print('xxx${kEvents[selectedDay]}');
            },
            onDisabledDayTapped: (day) {},
            enabledDayPredicate: (day) {
              if (maps['${day.day}-5-2023'] != null) {
                return false;
              }
              return true;
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            eventLoader: (day) {
              final kEvents = LinkedHashMap<DateTime, List<Event>>(
                equals: isSameDay,
                hashCode: getHashCode,
              )..addAll(hashMaps);

              return kEvents[day] ?? [];
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Text(
                  "Today",
                  style: TextStyle(
                    color: Color(0xff252356),
                    fontSize: 18,
                    fontFamily: "Figtree",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 16,horizontal: 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9.0),
                        child: IntrinsicWidth(
                          child: Column(children: [
                            Text(
                              "10:00am",
                              style: TextStyle(
                                color: Color(0xcc151a21),
                                fontSize: 14,
                              ),
                            ),
                            Container(height: 1,margin: EdgeInsets.symmetric(vertical: 15),width: double.infinity,color: Colors.blue,),
                            Text(
                              "11:00am",
                              style: TextStyle(
                                color: Color(0xcc151a21),
                                fontSize: 14,
                              ),
                            )
                          ],),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 9),
                          child: IntrinsicHeight(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                            Container(
                              width: 2,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [Color(0xff962e84), Color(0xffd83578), Color(0xffd83578)], ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Container(
                              width: 47,
                              height: 46,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: FlutterLogo(size: 46),
                            )
                            ,    SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                              Text(
                                "Kerry Ritter",
                                style: TextStyle(
                                  color: Color(0xff272727),
                                  fontSize: 18,
                                  fontFamily: "Figtree",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 4,),
                              Text(
                                "Entrepreneur, Founder & \nMentor at Previously - Cleanly",
                                style: TextStyle(
                                  color: Color(0xff878787),
                                  fontSize: 12,
                                ),
                              ),
                                SizedBox(height: 22,),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: Color(0xff252356),
                                  ),
                                  child: Text(
                                    "Join Call",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "Figtree",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 28,vertical: 11),
                                ),
                                SizedBox(height: 15,),
                            ],)
                        ]),
                          ),  decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffeae9ef),
                        ),),
                      )
                    ],),
                  )
            ]),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    hashMaps[DateTime.now()] = [Event('1111'), Event('1111'), Event('1111')];
    maps['11-5-2023'] = '11-5-2023';
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }
}
