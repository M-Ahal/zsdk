import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zsdk/zsdk.dart' as printer;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

const btnPrintPdfFileOverTCPIP = 'btnPrintPdfFileOverTCPIP';
const btnPrintZplFileOverTCPIP = 'btnPrintZplFileOverTCPIP';
const btnPrintZplDataOverTCPIP = 'btnPrintZplDataOverTCPIP';
const btnCheckPrinterStatus = 'btnCheckPrinterStatus';
const btnGetPrinterSettings = 'btnGetPrinterSettings';
const btnSetPrinterSettings = 'btnSetPrinterSettings';
const btnResetPrinterSettings = 'btnResetPrinterSettings';
const btnDoManualCalibration = 'btnDoManualCalibration';
const btnPrintConfigurationLabel = 'btnPrintConfigurationLabel';
const btnRebootPrinter = 'btnRebootPrinter';

class MyApp extends StatefulWidget {
  final zsdk = printer.ZSDK();

  MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

enum OperationStatus {
  sending,
  receiving,
  success,
  error,
  none,
}

class _MyAppState extends State<MyApp> {
  final addressIpController = TextEditingController(text: '10.0.0.11');
  final addressPortController = TextEditingController();
  final pathController = TextEditingController();
  final zplDataController =
      TextEditingController(text: '^XA^FO17,16^GB379,371,8^FS^FT65,255^A0N,135,134^FDTEST^FS^XZ');
  final widthController = TextEditingController();
  final heightController = TextEditingController();
  final dpiController = TextEditingController();

  final darknessController = TextEditingController();
  final printSpeedController = TextEditingController();
  final tearOffController = TextEditingController();
  final printWidthController = TextEditingController();
  final labelLengthController = TextEditingController();
  final labelLengthMaxController = TextEditingController();
  final labelTopController = TextEditingController();
  final leftPositionController = TextEditingController();
  printer.MediaType? selectedMediaType;
  printer.PrintMethod? selectedPrintMethod;
  printer.ZPLMode? selectedZPLMode;
  printer.PowerUpAction? selectedPowerUpAction;
  printer.HeadCloseAction? selectedHeadCloseAction;
  printer.PrintMode? selectedPrintMode;
  printer.ReprintMode? selectedReprintMode;
  printer.VirtualDevice? selectedVirtualDevice;

  printer.PrinterSettings? settings;

  printer.Orientation printerOrientation = printer.Orientation.landscape;
  String? message;
  String? statusMessage;
  String? settingsMessage;
  String? calibrationMessage;
  OperationStatus printStatus = OperationStatus.none;
  OperationStatus checkingStatus = OperationStatus.none;
  OperationStatus settingsStatus = OperationStatus.none;
  OperationStatus calibrationStatus = OperationStatus.none;
  OperationStatus rebootingStatus = OperationStatus.none;
  String? filePath;
  String? zplData;

  @override
  void initState() {
    super.initState();
  }

  String getName<T>(T value) {
    var name = 'Unknown';
    if (value is printer.HeadCloseAction) name = value.name;
    if (value is printer.MediaType) name = value.name;
    if (value is printer.PowerUpAction) name = value.name;
    if (value is printer.PrintMethod) name = value.name;
    if (value is printer.PrintMode) name = value.name;
    if (value is printer.ReprintMode) name = value.name;
    if (value is printer.VirtualDevice) name = value.name;
    if (value is printer.ZPLMode) name = value.name;
    return name;
  }

  List<DropdownMenuItem<T>> generateDropdownItems<T>(List<T> values) {
    final items = <DropdownMenuItem<T>>[];
    for (final value in values) {
      items.add(DropdownMenuItem<T>(
        value: value,
        child: Text(getName(value)),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          title: const Text('Zebra SDK Plugin example app'),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Scrollbar(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Print file over TCP/IP',
                  style: TextStyle(fontSize: 18),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'File to print',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextField(
                          controller: pathController,
                          decoration: const InputDecoration(labelText: 'File path'),
                        ),
                        const Divider(
                          color: Colors.transparent,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () async {
                                  try {
                                    final result = await FilePicker.platform.pickFiles();
                                    if (result != null) {
                                      filePath = result.files.single.path;
                                      if (filePath != null) {
                                        setState(() {
                                          pathController.text = filePath ?? '';
                                        });
                                      }
                                    }
                                  } on Exception catch (e) {
                                    showSnackBar(e.toString());
                                  }
                                },
                                child: Text(
                                  'Pick .zpl file'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: Colors.transparent,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightGreen,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () async {
                                  try {
                                    final result = await FilePicker.platform.pickFiles();
                                    if (result != null) {
                                      filePath = result.files.single.path;
                                      if (filePath != null) {
                                        setState(() {
                                          pathController.text = filePath ?? '';
                                        });
                                      }
                                    }
                                  } on Exception catch (e) {
                                    showSnackBar(e.toString());
                                  }
                                },
                                child: Text(
                                  'Pick .pdf file'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'ZPL data to print',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextField(
                          controller: zplDataController,
                          decoration: const InputDecoration(labelText: 'ZPL data'),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Printer address',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextField(
                          controller: addressIpController,
                          decoration: const InputDecoration(labelText: 'Printer IP address'),
                        ),
                        TextField(
                          controller: addressPortController,
                          decoration:
                              const InputDecoration(labelText: 'Printer port (defaults to 9100)'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Visibility(
                          visible: checkingStatus != OperationStatus.none ||
                              rebootingStatus != OperationStatus.none,
                          child: Column(
                            children: <Widget>[
                              Text(
                                '$statusMessage',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: getOperationStatusColor(
                                        checkingStatus != OperationStatus.none
                                            ? checkingStatus
                                            : rebootingStatus)),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: checkingStatus == OperationStatus.receiving
                                    ? null
                                    : () => onClick(btnCheckPrinterStatus),
                                child: Text(
                                  'Check printer status'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: checkingStatus == OperationStatus.sending
                                    ? null
                                    : () => onClick(btnRebootPrinter),
                                child: Text(
                                  'Reboot Printer'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Center(
                          child: Text(
                            'Printer settings',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
                              children: [
                                const TextSpan(
                                    text: 'Brand and model: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: settings?.printerModelName ?? 'Unknown'),
                              ]),
                        ),
                        const Divider(
                          color: Colors.transparent,
                          height: 4,
                        ),
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
                              children: [
                                const TextSpan(
                                    text: 'Device friendly name: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: settings?.deviceFriendlyName ?? 'Unknown'),
                              ]),
                        ),
                        const Divider(
                          color: Colors.transparent,
                          height: 4,
                        ),
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
                              children: [
                                const TextSpan(
                                    text: 'Firmware: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: settings?.firmware ?? 'Unknown'),
                              ]),
                        ),
                        const Divider(
                          color: Colors.transparent,
                          height: 4,
                        ),
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
                              children: [
                                const TextSpan(
                                    text: 'Link-OS Version: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: settings?.linkOSVersion ?? 'Unknown'),
                              ]),
                        ),
                        const Divider(
                          color: Colors.transparent,
                          height: 4,
                        ),
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
                              children: [
                                const TextSpan(
                                    text: 'Printer DPI: ',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(text: settings?.printerDpi ?? 'Unknown'),
                              ]),
                        ),
                        RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
                              children: [
                                const TextSpan(
                                    text: 'Resolution in dots per millimeter (dpmm): ',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: settings?.devicePrintHeadResolution != null
                                        ? "${double.tryParse(settings?.devicePrintHeadResolution ?? '')?.truncate()}dpmm"
                                        : 'Unknown'),
                              ]),
                        ),
                        TextField(
                          controller: darknessController,
                          keyboardType:
                              const TextInputType.numberWithOptions(signed: true, decimal: true),
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: 'Darkness'),
                        ),
                        TextField(
                          controller: printSpeedController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: 'Print speed'),
                        ),
                        TextField(
                          controller: tearOffController,
                          keyboardType: const TextInputType.numberWithOptions(signed: true),
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: 'Tear off'),
                        ),
                        DropdownButtonFormField<printer.MediaType>(
                          items: generateDropdownItems(printer.MediaType.values),
                          initialValue: selectedMediaType,
                          onChanged: (value) => setState(() => selectedMediaType = value),
                          decoration: const InputDecoration(labelText: 'Media type'),
                        ),
                        DropdownButtonFormField<printer.PrintMethod>(
                          items: generateDropdownItems(printer.PrintMethod.values),
                          initialValue: selectedPrintMethod,
                          onChanged: (value) => setState(() => selectedPrintMethod = value),
                          decoration: const InputDecoration(labelText: 'Print method'),
                        ),
                        TextField(
                          controller: printWidthController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: 'Print width'),
                        ),
                        TextField(
                          controller: labelLengthController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: 'Label length'),
                        ),
                        TextField(
                          controller: labelLengthMaxController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: 'Label length max'),
                        ),
                        DropdownButtonFormField<printer.ZPLMode>(
                          items: generateDropdownItems(printer.ZPLMode.values),
                          initialValue: selectedZPLMode,
                          onChanged: (value) => setState(() => selectedZPLMode = value),
                          decoration: const InputDecoration(labelText: 'ZPL mode'),
                        ),
                        DropdownButtonFormField<printer.PowerUpAction>(
                          items: generateDropdownItems(printer.PowerUpAction.values),
                          initialValue: selectedPowerUpAction,
                          onChanged: (value) => setState(() => selectedPowerUpAction = value),
                          decoration: const InputDecoration(labelText: 'Power up action'),
                        ),
                        DropdownButtonFormField<printer.HeadCloseAction>(
                          items: generateDropdownItems(printer.HeadCloseAction.values),
                          initialValue: selectedHeadCloseAction,
                          onChanged: (value) => setState(() => selectedHeadCloseAction = value),
                          decoration: const InputDecoration(labelText: 'Head close action'),
                        ),
                        TextField(
                          controller: labelTopController,
                          keyboardType: const TextInputType.numberWithOptions(signed: true),
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: 'Label top'),
                        ),
                        TextField(
                          controller: leftPositionController,
                          keyboardType: const TextInputType.numberWithOptions(signed: true),
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(labelText: 'Left position'),
                        ),
                        DropdownButtonFormField<printer.PrintMode>(
                          items: generateDropdownItems(printer.PrintMode.values),
                          initialValue: selectedPrintMode,
                          onChanged: (value) => setState(() => selectedPrintMode = value),
                          decoration: const InputDecoration(labelText: 'Print mode'),
                        ),
                        DropdownButtonFormField<printer.ReprintMode>(
                          items: generateDropdownItems(printer.ReprintMode.values),
                          initialValue: selectedReprintMode,
                          onChanged: (value) => setState(() => selectedReprintMode = value),
                          decoration: const InputDecoration(labelText: 'Reprint mode'),
                        ),
                        DropdownButtonFormField<printer.VirtualDevice>(
                          items: generateDropdownItems(printer.VirtualDevice.values),
                          initialValue: selectedVirtualDevice,
                          onChanged: (value) => setState(() => selectedVirtualDevice = value),
                          decoration: const InputDecoration(labelText: 'Virtual device'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Visibility(
                          visible: settingsStatus != OperationStatus.none,
                          child: Column(
                            children: <Widget>[
                              Text(
                                '$settingsMessage',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: getOperationStatusColor(settingsStatus)),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: settingsStatus == OperationStatus.sending ||
                                        settingsStatus == OperationStatus.receiving
                                    ? null
                                    : () => onClick(btnSetPrinterSettings),
                                child: Text(
                                  'Set settings'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const VerticalDivider(
                              color: Colors.transparent,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: settingsStatus == OperationStatus.sending ||
                                        settingsStatus == OperationStatus.receiving
                                    ? null
                                    : () => onClick(btnGetPrinterSettings),
                                child: Text(
                                  'Get settings'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: settingsStatus == OperationStatus.sending ||
                                        settingsStatus == OperationStatus.receiving
                                    ? null
                                    : () => onClick(btnResetPrinterSettings),
                                child: Text(
                                  'Reset settings'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Printer calibration',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Visibility(
                          visible: calibrationStatus != OperationStatus.none,
                          child: Column(
                            children: <Widget>[
                              Text(
                                '$calibrationMessage',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: getOperationStatusColor(calibrationStatus)),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: calibrationStatus == OperationStatus.sending
                                    ? null
                                    : () => onClick(btnDoManualCalibration),
                                child: Text(
                                  'DO MANUAL CALIBRATION'.toUpperCase(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'PDF print configurations',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextField(
                          controller: widthController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                              labelText: 'Paper width in cm (defaults to 15.20 cm)'),
                        ),
                        TextField(
                          controller: heightController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                              labelText: 'Paper height in cm (defaults to 7.00 cm)'),
                        ),
                        TextField(
                          controller: dpiController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                              labelText: 'Printer density per inch (defaults to 203 dpi)'),
                        ),
                        DropdownButtonFormField<printer.Orientation>(
                          items: const [
                            DropdownMenuItem(
                              value: printer.Orientation.portrait,
                              child: Text('Portrait'),
                            ),
                            DropdownMenuItem(
                              value: printer.Orientation.landscape,
                              child: Text('Landscape'),
                            )
                          ],
                          initialValue: printerOrientation,
                          onChanged: (value) => setState(
                              () => printerOrientation = value ?? printer.Orientation.landscape),
                          decoration: const InputDecoration(labelText: 'Print orientation'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: printStatus != OperationStatus.none,
                  child: Column(
                    children: <Widget>[
                      Text(
                        '$message',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: getOperationStatusColor(printStatus)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: printStatus == OperationStatus.sending
                      ? null
                      : () => onClick(btnPrintConfigurationLabel),
                  child: Text(
                    'Test Print'.toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: printStatus == OperationStatus.sending
                            ? null
                            : () => onClick(btnPrintZplFileOverTCPIP),
                        child: Text(
                          'Print zpl from file'.toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: printStatus == OperationStatus.sending
                            ? null
                            : () => onClick(btnPrintPdfFileOverTCPIP),
                        child: Text(
                          'Print pdf from file'.toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: printStatus == OperationStatus.sending
                      ? null
                      : () => onClick(btnPrintZplDataOverTCPIP),
                  child: Text(
                    'Print zpl data'.toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          )),
        ),
      );

  Color getOperationStatusColor(OperationStatus status) {
    switch (status) {
      case OperationStatus.receiving:
      case OperationStatus.sending:
        return Colors.blue;
      case OperationStatus.success:
        return Colors.green;
      case OperationStatus.error:
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  void updateSettings(printer.PrinterSettings? newSettings) {
    settings = newSettings;

    darknessController.text = "${settings?.darkness ?? ""}";
    printSpeedController.text = "${settings?.printSpeed ?? ""}";
    tearOffController.text = "${settings?.tearOff ?? ""}";
    printWidthController.text = "${settings?.printWidth ?? ""}";
    labelLengthController.text = "${settings?.labelLength ?? ""}";
    labelLengthMaxController.text = "${settings?.labelLengthMax ?? ""}";
    labelTopController.text = "${settings?.labelTop ?? ""}";
    leftPositionController.text = "${settings?.leftPosition ?? ""}";
    selectedMediaType = settings?.mediaType;
    selectedPrintMethod = settings?.printMethod;
    selectedZPLMode = settings?.zplMode;
    selectedPowerUpAction = settings?.powerUpAction;
    selectedHeadCloseAction = settings?.headCloseAction;
    selectedPrintMode = settings?.printMode;
    selectedReprintMode = settings?.reprintMode;
    selectedVirtualDevice = settings?.virtualDevice;
  }

  Future<void> onClick(String id) async {
    try {
      switch (id) {
        case btnDoManualCalibration:
          setState(() {
            calibrationMessage = 'Starting manual callibration...';
            calibrationStatus = OperationStatus.sending;
          });
          unawaited(widget.zsdk
              .doManualCalibrationOverTCPIP(
            address: addressIpController.text,
            port: int.tryParse(addressPortController.text),
          )
              .then((value) {
            setState(() {
              calibrationStatus = OperationStatus.success;
              calibrationMessage = '$value';
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                calibrationMessage =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause} \n'
                    '${printerResponse.settings}';
              } on Exception catch (e) {
                print(e);
                calibrationMessage = e.toString();
              }
            } on MissingPluginException catch (e) {
              calibrationMessage = '${e.message}';
            } on Exception catch (e) {
              calibrationMessage = e.toString();
            }
            setState(() {
              calibrationStatus = OperationStatus.error;
            });
          }));
        case btnGetPrinterSettings:
          setState(() {
            settingsMessage = 'Getting printer settings...';
            settingsStatus = OperationStatus.receiving;
          });
          unawaited(widget.zsdk
              .getPrinterSettingsOverTCPIP(
            address: addressIpController.text,
            port: int.tryParse(addressPortController.text),
          )
              .then((value) {
            setState(() {
              settingsStatus = OperationStatus.success;
              settingsMessage = '$value';
              updateSettings(printer.PrinterResponse.fromJson(value!).settings);
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                settingsMessage =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause} \n'
                    '${printerResponse.settings}';
              } on Exception catch (e) {
                print(e);
                settingsMessage = e.toString();
              }
            } on MissingPluginException catch (e) {
              settingsMessage = '${e.message}';
            } on Exception catch (e) {
              settingsMessage = e.toString();
            }
            setState(() {
              settingsStatus = OperationStatus.error;
            });
          }));
        case btnSetPrinterSettings:
          setState(() {
            settingsMessage = 'Setting printer settings...';
            settingsStatus = OperationStatus.sending;
          });
          unawaited(widget.zsdk
              .setPrinterSettingsOverTCPIP(
                  address: addressIpController.text,
                  port: int.tryParse(addressPortController.text),
                  settings: printer.PrinterSettings(
                    darkness: double.tryParse(darknessController.text),
                    printSpeed: double.tryParse(printSpeedController.text),
                    tearOff: int.tryParse(tearOffController.text),
                    mediaType: selectedMediaType,
                    printMethod: selectedPrintMethod,
                    printWidth: int.tryParse(printWidthController.text),
                    labelLength: int.tryParse(labelLengthController.text),
                    labelLengthMax: double.tryParse(labelLengthMaxController.text),
                    zplMode: selectedZPLMode,
                    powerUpAction: selectedPowerUpAction,
                    headCloseAction: selectedHeadCloseAction,
                    labelTop: int.tryParse(labelTopController.text),
                    leftPosition: int.tryParse(leftPositionController.text),
                    printMode: selectedPrintMode,
                    reprintMode: selectedReprintMode,
                    virtualDevice: selectedVirtualDevice,
                  )
//            settings: Printer.PrinterSettings(
//              darkness: 10, //10
//              printSpeed: 6, //6
//              tearOff: 0,//0
//              mediaType: Printer.MediaType.MARK, //MARK
//              printMethod: Printer.PrintMethod.DIRECT_THERMAL, //DIRECT_THERMAL
//              printWidth: 568,//600
//              labelLength: 1202,//1202
//              labelLengthMax: 39,//39
//              zplMode: Printer.ZPLMode.ZPL_II,//ZPL II
//              powerUpAction: Printer.PowerUpAction.NO_MOTION,//NO MOTION
//              headCloseAction: Printer.HeadCloseAction.FEED,//FEED
//              labelTop: 0,//0
//              leftPosition: 0,//0
//              printMode: Printer.PrintMode.TEAR_OFF,//TEAR_OFF
//              reprintMode: Printer.ReprintMode.OFF,//OFF
//              virtualDevice: selectedVirtualDevice,
//            )
//            settings: Printer.PrinterSettings(
//              darkness: 30, //10
//              printSpeed: 3, //6
//              tearOff: 100,//0
//              mediaType: Printer.MediaType.CONTINUOUS, //MARK
//              printMethod: Printer.PrintMethod.THERMAL_TRANS, //DIRECT_THERMAL
//              printWidth: 568,//600
//              labelLength: 1000,//1202
//              labelLengthMax: 30,//39
//              zplMode: Printer.ZPLMode.ZPL,//ZPL II
//              powerUpAction: Printer.PowerUpAction.FEED,//NO MOTION
//              headCloseAction: Printer.HeadCloseAction.NO_MOTION,//FEED
//              labelTop: 50,//0
//              leftPosition: 100,//0
//              printMode: Printer.PrintMode.CUTTER,//TEAR_OFF
//              reprintMode: Printer.ReprintMode.ON,//OFF
//              virtualDevice: selectedVirtualDevice,
//            )
                  )
              .then((value) {
            setState(() {
              settingsStatus = OperationStatus.success;
              settingsMessage = '$value';
              updateSettings(printer.PrinterResponse.fromJson(value!).settings);
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                settingsMessage =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause} \n'
                    '${printerResponse.settings}';
              } on Exception catch (e) {
                print(e);
                settingsMessage = e.toString();
              }
            } on MissingPluginException catch (e) {
              settingsMessage = '${e.message}';
            } on Exception catch (e) {
              settingsMessage = e.toString();
            }
            setState(() {
              settingsStatus = OperationStatus.error;
            });
          }));
        case btnResetPrinterSettings:
          setState(() {
            settingsMessage = 'Setting default settings...';
            settingsStatus = OperationStatus.sending;
          });
          unawaited(widget.zsdk
              .setPrinterSettingsOverTCPIP(
                  address: addressIpController.text,
                  port: int.tryParse(addressPortController.text),
                  settings: printer.PrinterSettings.defaultSettings())
              .then((value) {
            setState(() {
              settingsStatus = OperationStatus.success;
              settingsMessage = '$value';
              updateSettings(printer.PrinterResponse.fromJson(value!).settings);
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                settingsMessage =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause} \n'
                    '${printerResponse.settings}';
              } on Exception catch (e) {
                print(e);
                settingsMessage = e.toString();
              }
            } on MissingPluginException catch (e) {
              settingsMessage = '${e.message}';
            } on Exception catch (e) {
              settingsMessage = e.toString();
            }
            setState(() {
              settingsStatus = OperationStatus.error;
            });
          }));
        case btnCheckPrinterStatus:
          setState(() {
            statusMessage = 'Checking printer status...';
            checkingStatus = OperationStatus.receiving;
          });
          unawaited(widget.zsdk
              .checkPrinterStatusOverTCPIP(
            address: addressIpController.text,
            port: int.tryParse(addressPortController.text),
          )
              .then((value) {
            setState(() {
              checkingStatus = OperationStatus.success;
              printer.PrinterResponse? printerResponse;
              if (value != null) {
                printerResponse = printer.PrinterResponse.fromJson(value);
              }
              statusMessage = '${printerResponse != null ? printerResponse.toMap() : value}';
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                statusMessage =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}';
              } on Exception catch (e) {
                print(e);
                statusMessage = e.toString();
              }
            } on MissingPluginException catch (e) {
              statusMessage = '${e.message}';
            } on Exception catch (e) {
              statusMessage = e.toString();
            }
            setState(() {
              checkingStatus = OperationStatus.error;
            });
          }));
        case btnRebootPrinter:
          setState(() {
            statusMessage = 'Rebooting printer...';
            rebootingStatus = OperationStatus.sending;
          });
          unawaited(widget.zsdk
              .rebootPrinterOverTCPIP(
            address: addressIpController.text,
            port: int.tryParse(addressPortController.text),
          )
              .then((value) {
            setState(() {
              rebootingStatus = OperationStatus.success;
              printer.PrinterResponse? printerResponse;
              if (value != null) {
                printerResponse = printer.PrinterResponse.fromJson(value);
              }
              statusMessage = '${printerResponse != null ? printerResponse.toMap() : value}';
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                statusMessage =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}';
              } on Exception catch (e) {
                print(e);
                statusMessage = e.toString();
              }
            } on MissingPluginException catch (e) {
              statusMessage = '${e.message}';
            } on Exception catch (e) {
              statusMessage = e.toString();
            }
            setState(() {
              rebootingStatus = OperationStatus.error;
            });
          }));
        case btnPrintConfigurationLabel:
          setState(() {
            message = 'Print job started...';
            printStatus = OperationStatus.sending;
          });
          unawaited(widget.zsdk
              .printConfigurationLabelOverTCPIP(
            address: addressIpController.text,
            port: int.tryParse(addressPortController.text),
          )
              .then((value) {
            setState(() {
              printStatus = OperationStatus.success;
              message = '$value';
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                message =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}';
              } on Exception catch (e) {
                print(e);
                message = e.toString();
              }
            } on MissingPluginException catch (e) {
              message = '${e.message}';
            } on Exception catch (e) {
              message = e.toString();
            }
            setState(() {
              printStatus = OperationStatus.error;
            });
          }));
        case btnPrintPdfFileOverTCPIP:
          if (!pathController.text.endsWith('.pdf')) {
            throw Exception('Make sure you properly write the path or selected a proper pdf file');
          }
          setState(() {
            message = 'Print job started...';
            printStatus = OperationStatus.sending;
          });
          unawaited(widget.zsdk
              .printPdfFileOverTCPIP(
                  filePath: pathController.text,
                  address: addressIpController.text,
                  port: int.tryParse(addressPortController.text),
                  printerConf: printer.PrinterConf(
                    cmWidth: double.tryParse(widthController.text),
                    cmHeight: double.tryParse(heightController.text),
                    dpi: double.tryParse(dpiController.text),
                    orientation: printerOrientation,
                  ))
              .then((value) {
            setState(() {
              printStatus = OperationStatus.success;
              message = '$value';
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                message =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}';
              } on Exception catch (e) {
                print(e);
                message = e.toString();
              }
            } on MissingPluginException catch (e) {
              message = '${e.message}';
            } on Exception catch (e) {
              message = e.toString();
            }
            setState(() {
              printStatus = OperationStatus.error;
            });
          }));
        case btnPrintZplFileOverTCPIP:
          if (filePath == null && !pathController.text.endsWith('.zpl')) {
            throw Exception('Make sure you properly write the path or selected a proper zpl file');
          }
          final zplFile = File(filePath!);
          if (zplFile.existsSync()) {
            zplData = await zplFile.readAsString();
          }
          if (zplData == null || zplData!.isEmpty) {
            throw Exception('Make sure you properly write the path or selected a proper zpl file');
          }
          setState(() {
            message = 'Print job started...';
            printStatus = OperationStatus.sending;
          });
          unawaited(widget.zsdk
              .printZplDataOverTCPIP(
                  data: zplData!,
                  address: addressIpController.text,
                  port: int.tryParse(addressPortController.text),
                  printerConf: printer.PrinterConf(
                    cmWidth: double.tryParse(widthController.text),
                    cmHeight: double.tryParse(heightController.text),
                    dpi: double.tryParse(dpiController.text),
                    orientation: printerOrientation,
                  ))
              .then((value) {
            setState(() {
              printStatus = OperationStatus.success;
              message = '$value';
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                message =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}';
              } on Exception catch (e) {
                print(e);
                message = e.toString();
              }
            } on MissingPluginException catch (e) {
              message = '${e.message}';
            } on Exception catch (e) {
              message = e.toString();
            }
            setState(() {
              printStatus = OperationStatus.error;
            });
          }));
        case btnPrintZplDataOverTCPIP:
          zplData = zplDataController.text;
          if (zplData == null || zplData!.isEmpty) {
            throw Exception("ZPL data can't be empty");
          }
          setState(() {
            message = 'Print job started...';
            printStatus = OperationStatus.sending;
          });
          unawaited(widget.zsdk
              .printZplDataOverTCPIP(
                  data: zplData!,
                  address: addressIpController.text,
                  port: int.tryParse(addressPortController.text),
                  printerConf: printer.PrinterConf(
                    cmWidth: double.tryParse(widthController.text),
                    cmHeight: double.tryParse(heightController.text),
                    dpi: double.tryParse(dpiController.text),
                    orientation: printerOrientation,
                  ))
              .then((value) {
            setState(() {
              printStatus = OperationStatus.success;
              message = '$value';
            });
          }, onError: (error, stacktrace) {
            try {
              throw error;
            } on PlatformException catch (e) {
              printer.PrinterResponse printerResponse;
              try {
                printerResponse =
                    printer.PrinterResponse.fromJson(e.details as Map<String, dynamic>);
                message =
                    '${printerResponse.message} ${printerResponse.errorCode} ${printerResponse.statusInfo.status} ${printerResponse.statusInfo.cause}';
              } on Exception catch (e) {
                print(e);
                message = e.toString();
              }
            } on MissingPluginException catch (e) {
              message = '${e.message}';
            } on Exception catch (e) {
              message = e.toString();
            }
            setState(() {
              printStatus = OperationStatus.error;
            });
          }));
      }
    } on Exception catch (e) {
      print(e);
      showSnackBar(e.toString());
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
