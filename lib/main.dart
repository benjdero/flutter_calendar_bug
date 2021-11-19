import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DateTime initialDate = DateTime.now();
  final DateTime minDate = DateTime(1990);

  final DateRangePickerController controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter calendar bug"),
      ),
      body: Center(
        child: SfDateRangePicker(
          key: const Key("week"),
          initialSelectedRange: PickerDateRange(
              getFirstWeekday(initialDate),
              getLastWeekday(initialDate)
          ),
          initialDisplayDate: initialDate,
          minDate: minDate,
          maxDate: getLastWeekday(initialDate),
          todayHighlightColor: Colors.transparent,
          showNavigationArrow: true,
          selectionMode: DateRangePickerSelectionMode.range,
          rangeSelectionColor: Colors.red.withAlpha(180),
          rangeTextStyle: const TextStyle(color: Colors.white),
          monthViewSettings: const DateRangePickerMonthViewSettings(
            firstDayOfWeek: 1,
            showTrailingAndLeadingDates: true,
          ),
          controller: controller,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs date) {
            DateTime? dateTime;
            if (date.value is DateTime) {
              dateTime = date.value as DateTime;
            } else if (date.value is PickerDateRange) {
              final PickerDateRange range = date.value as PickerDateRange;
              dateTime = range.startDate;
            }

            if (dateTime == null) {
              return;
            }

            controller.selectedRange = PickerDateRange(
              getFirstWeekday(dateTime),
              getLastWeekday(dateTime),
            );
          },
        ),
      ),
    );
  }

  static DateTime getFirstWeekday(DateTime dateTime) =>
      dateTime.subtract(
          Duration(
            days: dateTime.weekday - 1,
            hours: dateTime.hour,
            minutes: dateTime.minute,
            seconds: dateTime.second,
            milliseconds: dateTime.millisecond,
          )
      );

  static DateTime getLastWeekday(DateTime dateTime) =>
      dateTime.add(
          Duration(
            days: 7 - dateTime.weekday,
            hours: 23 - dateTime.hour,
            minutes: 59 - dateTime.minute,
            seconds: 59 - dateTime.second,
            milliseconds: 999 - dateTime.millisecond,
          )
      );
}
