import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nepal_express/app/models/booking.dart';
import 'package:nepal_express/app/utils/constants.dart';
import 'package:nepal_express/app/utils/memory.dart';
import 'package:get/get.dart';
import 'package:nepal_express/app/routes/app_pages.dart';
import 'package:printing/printing.dart';
import '../controllers/bookings_controller.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BookingsView extends GetView<BookingsController> {
  const BookingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(BookingsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingsView'),
        centerTitle: true,
      ),
      body: GetBuilder<BookingsController>(
        builder: (controller) {
          if (controller.bookingResponse == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: controller.bookingResponse?.bookings?.length ?? 0,
            itemBuilder: (context, index) {
              Booking booking = controller.bookingResponse!.bookings![index];
              var formattedDate =
                  DateFormat("yyyy-MM-dd hh:MM aa").format(booking.date!);
              return InkWell(
                onTap: () {
                  // Navigate to booking details page with the selected booking
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingDetailsPage(booking: booking),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: ListTile(
                    leading: Image.network(
                      getImageUrl(booking.avatar),
                      height: 200,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    isThreeLine: true,
                    title: Text(booking.name ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formattedDate),
                        Text('Rs.${booking.amount}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                    trailing: Text(
                      booking.status?.toUpperCase() ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: booking.status == 'paid'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BookingDetailsPage extends StatelessWidget {
  final Booking booking;

  const BookingDetailsPage({Key? key, required this.booking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formattedDate = DateFormat("yyyy-MM-dd hh:MM aa").format(booking.date!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 158, 158, 158)
                          .withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Booking ID:   ${booking.bookingId}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Increased font size by 10 pixels
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Date:   $formattedDate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Increased font size by 10 pixels
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Bus ID:   ${booking.busId ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Increased font size by 10 pixels
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'User ID:   ${booking.userId ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Increased font size by 10 pixels
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Trip Title:   ${booking.tripTitle ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'From:   ${booking.cityFrom ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'To:   ${booking.cityTo ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Status:   ${booking.status?.toUpperCase()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Increased font size by 10 pixels
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Seat ID:   ${booking.seatId ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Name:   ${booking.name ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Increased font size by 10 pixels
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Fair:   ${booking.fair ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Increased font size by 10 pixels
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Amount:   ${booking.amount ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20, // Increased font size by 10 pixels
                      ),
                    ),
                    SizedBox(height: 10),
                    Image.network(
                      getImageUrl(
                        booking.avatar ?? '',
                      ),
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _createBookingDetailsPdf,
                child: Text('Generate PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createBookingDetailsPdf() async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Booking Details',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Booking ID: ${booking.bookingId}'),
              pw.Text(
                  'Date: ${DateFormat("yyyy-MM-dd hh:MM aa").format(booking.date!)}'),
              pw.Text('Bus ID: ${booking.busId ?? ''}'),
              pw.Text('User ID: ${booking.userId ?? ''}'),
              pw.Text('Trip Title: ${booking.tripTitle ?? ''}'),
              pw.Text('From: ${booking.cityFrom ?? ''}'),
              pw.Text('To: ${booking.cityTo ?? ''}'),
              pw.Text('Status: ${booking.status?.toUpperCase() ?? ''}'),
              pw.Text('Seat ID: ${booking.seatId ?? ''}'),
              pw.Text('Name: ${booking.name ?? ''}'),
              pw.Text('Fair: ${booking.fair ?? ''}'),
              pw.Text('Total Amount: ${booking.amount ?? ''}'),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/booking_details.pdf');
    await file.writeAsBytes(await doc.save());
  }
}

class PreviewScreen extends StatelessWidget {
  final pw.Document doc;

  const PreviewScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text("Preview"),
      ),
      body: PdfPreview(
        build: (format) => doc.save(),
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "mydoc.pdf",
      ),
    );
  }
}
