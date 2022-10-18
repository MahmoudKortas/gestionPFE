// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../helpers/api_service.dart';
import '../../utils.dart';

class TableEventsExample extends StatefulWidget {
  String fonction;
  TableEventsExample({
    Key? key,
    required this.fonction,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  Map<DateTime, List<Event>>? selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  var _listeSoutenance;
  TextEditingController _eventController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _heureController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents?[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    _idController.dispose();
    _heureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    selectedEvents = {
      DateTime.now(): [Event(3.toString(), "salle", "heureDeb")]
    };
    log(widget.fonction);
    log("selectedEvents::$selectedEvents");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calendrier des soutenances"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat format) {
                setState(() {
                  format = format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,

              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                log(focusedDay.toString());
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },

              eventLoader: _getEventsfromDay,

              //To style the Calendar
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ..._getEventsfromDay(selectedDay).map(
              (Event event) => ListTile(
                  title: Column(
                children: [
                  Text(
                    "idPFE:${event.idPfe}  Salle soutenance:${event.salle}  herure début:${event.heureDeb}",
                  ),
                ],
              )),
            ),
          ],
        ),
        floatingActionButton: widget.fonction.contains("admin")
            ? FloatingActionButton.extended(
                onPressed: () //=>
                    {
                   log("selectedEventsss::$selectedEvents");
                  showDialog(
                      context: context,
                      builder: (context) => ajoutSoutenance());
                },
                label: const Text("Ajouter soutenance"),
                icon: const Icon(Icons.add),
              )
            : Container());
  }

  Widget ajoutSoutenance() {
  log("selectedEventsss::$selectedEvents");
    log(_idController.text + _eventController.text + _heureController.text);
    return AlertDialog(
      title: const Text("Ajouter soutenance"),
      content: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir le id du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _idController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir le salle du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _eventController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Saisir heure début du PFE',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _heureController,
              ),
            ],
          ),
        )
      ])),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text("Ok"),
          onPressed: () {
            log("selectedEvents::$selectedEvents");
            if (_eventController.text.isEmpty) {
              log(_eventController.text.isEmpty.toString());
            } else {
              if (selectedEvents?[selectedDay] != null) {
                log("nulllll");
                /*selectedEvents?[selectedDay]?.add(
                  Event(_eventController.text),
                );
                selectedEvents?[selectedDay]?.add(
                  Event(_heureController.text),
                );
                selectedEvents?[selectedDay]?.add(
                  Event(_idController.text),
                );*/
              } else {
                // log(selectedEvents![selectedDay].toString());
                log("no");
                log("selectedDay::$selectedDay");
                selectedEvents?[selectedDay]?.add(
                  Event(_idController.text, _eventController.text,
                      _heureController.text),
                );
                selectedEvents?[selectedDay] = [
                  Event(_idController.text, _eventController.text,
                      _heureController.text)
                ];
                log("selectedEvents:::::$selectedEvents");
              }
            }
            Navigator.pop(context);
            _eventController.clear();
            _heureController.clear();
            _idController.clear();
            setState(() {});
            return;
          },
        ),
      ],
    );
  }

  void getData() async {
    selectedEvents?[DateTime(2022, 7, 21)] = [Event("1", "E1S2", "15h")];
    _listeSoutenance = await ApiService().getSoutenance();
    log("_listeSoutenance::$_listeSoutenance");
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }
}
