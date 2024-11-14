import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proventi/global/style.dart';
import 'package:proventi/state_manager/communication_state_manager.dart';
import 'package:provider/provider.dart';

import '../../../../api/restaurant_client/lib/api.dart';

class BookingEdit extends StatefulWidget {
  final BookingDTO bookingDTO;

  BookingEdit({required this.bookingDTO});

  @override
  _BookingEditState createState() => _BookingEditState();
}

class _BookingEditState extends State<BookingEdit> {
  late TextEditingController _timeSlotController;
  late TextEditingController _dateController;
  late TextEditingController _numGuestsController;
  late TextEditingController _specialRequestsController;

  @override
  void initState() {
    super.initState();

    _timeSlotController = TextEditingController(text: widget.bookingDTO.timeSlot.toString());
    _numGuestsController = TextEditingController(text: widget.bookingDTO.numGuests?.toString());
    _specialRequestsController = TextEditingController(text: widget.bookingDTO.specialRequests);
    _dateController = TextEditingController(text: italianDateFormat.format(widget.bookingDTO.bookingDate!));
  }

  @override
  void dispose() {
    // Dispose the controllers
    _timeSlotController.dispose();
    _numGuestsController.dispose();
    _specialRequestsController.dispose();
    super.dispose();
  }

  void _saveBooking() {
    widget.bookingDTO.numGuests = int.tryParse(_numGuestsController.text) ?? 0;
    widget.bookingDTO.specialRequests = _specialRequestsController.text;

    // Optionally, add logic for saving the booking, such as sending data to an API.
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Edit Booking", style: TextStyle(fontWeight: FontWeight.normal)),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Text('Aggiorna prenotazione', style: TextStyle(fontWeight: FontWeight.normal)),
            onPressed: _saveBooking,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Display Customer Information in a non-editable mode using CustomFormRow
              CupertinoFormSection(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Informazioni cliente', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Consumer<CommunicationStateManager>(
                      builder: (BuildContext context, CommunicationStateManager communicationStateManager, Widget? child) {
                        return FutureBuilder<String?>(
                          future: communicationStateManager.whatsAppConfigurationControllerApi.retrieveUserPhoto(widget.bookingDTO.branchCode!, widget.bookingDTO.customer!.prefix! + widget.bookingDTO.customer!.phone!),  // The API call
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              // Show a loading spinner while waiting
                              return const SizedBox(height: 0,);
                            } else if (snapshot.hasError) {
                              return const Icon(Icons.error, color: Colors.red);
                            } else if (snapshot.hasData) {
                              // Display the image in an avatar
                              String imageUrl = snapshot.data!;
                              return CircleAvatar(
                                radius: 30, // Size of the circle
                                backgroundImage: NetworkImage(imageUrl), // Load the image from the URL
                                backgroundColor: Colors.transparent, // Optional: Make the background transparent
                              );
                            } else {
                              // Handle the case where no data is returned
                              return const Icon(Icons.error, color: Colors.red);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
                children: [
                  CustomFormRow(
                    label: 'Nome',
                    value: widget.bookingDTO.customer?.firstName,
                    isEditable: false,
                  ),
                  CustomFormRow(
                    label: 'Cognome',
                    value: widget.bookingDTO.customer?.lastName,
                    isEditable: false,
                  ),
                  CustomFormRow(
                    label: 'Email',
                    value: widget.bookingDTO.customer?.email ?? '',
                    isEditable: false,
                  ),
                  CustomFormRow(
                    label: 'Cellulare',
                    value: '(${widget.bookingDTO.customer!.prefix}) ${widget.bookingDTO.customer?.phone}',
                    isEditable: false,
                  ),
                  CustomFormRow(
                    label: 'Cap',
                    value: '${widget.bookingDTO.customer?.postalCode}',
                    isEditable: false,
                  ),
                ],
              ),
              // Form to edit BookingDTO fields using CustomFormRow
              CupertinoFormSection(
                header: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Info prenotazione', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('Codice prenotazione: ' + widget.bookingDTO.bookingCode!, style: TextStyle(fontSize: 9)),
                  ],
                ),
                children: [

                  CustomFormRow(
                    label: 'Codice ristorante',
                    value: widget.bookingDTO.branchCode,
                    isEditable: false,
                  ),
                  CustomFormRow(
                    label: 'Nome ristorante',
                    value: widget.bookingDTO.branchName,
                    isEditable: false,
                  ),
                  CustomFormRow(
                    label: 'Data prenotazione',
                    controller: _dateController,
                    placeholder: 'Enter booking date',
                  ),
                  CustomFormRow(
                    label: 'Ora arrivo',
                    controller: _timeSlotController,
                    placeholder: 'Enter time slot',
                  ),
                  CustomFormRow(
                    label: 'Prenotati',
                    controller: _numGuestsController,
                    placeholder: 'Enter number of guests',
                    keyboardType: TextInputType.number,
                  ),
                  CustomFormRow(
                    label: 'Note',
                    controller: _specialRequestsController,
                    placeholder: 'Enter special requests or notes',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CustomFormRow extends StatelessWidget {
  final String label;
  final String? value;
  final TextEditingController? controller;
  final bool isEditable;
  final TextInputType? keyboardType;
  final String? placeholder;

  CustomFormRow({
    required this.label,
    this.value,
    this.controller,
    this.isEditable = true,
    this.keyboardType,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoFormRow(
      prefix: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      ),
      child: isEditable
          ? CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        keyboardType: keyboardType,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
      )
          : Text(
        value ?? '',
        style: const TextStyle(color: CupertinoColors.inactiveGray, fontWeight: FontWeight.w300, fontSize: 14),
      ),
    );
  }
}