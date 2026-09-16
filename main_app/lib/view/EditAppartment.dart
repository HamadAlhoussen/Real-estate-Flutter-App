// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../widgets/GlassTextField.dart';
// import '../widgets/GlassDropdown.dart';
// import '../widgets/GlowingCircle.dart';
// import '../widgets/Background.dart';
// import '../widgets/DatePickerField.dart';
// import '../../controllers/flats_controllers/update_flat_controller.dart';
// import '../../models/flat_model.dart';

// class EditApartment extends StatefulWidget {
//   final FlatModel flat;
//   const EditApartment({super.key, required this.flat});

//   @override
//   State<EditApartment> createState() => _EditApartmentState();
// }

// class _EditApartmentState extends State<EditApartment> {
//   late String? governorateValue;
//   late String? cityValue;
//   late String? addressValue;
//   late String? priceValue;
//   late String? spaceValue;
//   late String? floorValue;
//   late DateTime? selectedDate;
//   late String? selectedRooms;
//   late String? selectedStatus;
//   late String? selectedSection;
//   late bool hasElevator;
//   late bool isFurnished;

//   final updateController = Get.put(UpdateFlatController());

//   final List<String> sectionOptions = ["26".tr, "27".tr, "28".tr];
//   final List<String> roomsOptions = ["1", "2", "3", "4", "5 or more"];
//   final List<String> statusOptions = ["available", "unavailable"];

//   @override
//   void initState() {
//     super.initState();

//     governorateValue = widget.flat.governorate;
//     cityValue = widget.flat.city;
//     addressValue = widget.flat.address;
//     priceValue = widget.flat.price.toString();
//     spaceValue = widget.flat.space.toString();
//     floorValue = widget.flat.floor.toString();
//     if (widget.flat.availableDate != null &&
//         widget.flat.availableDate!.isNotEmpty) {
//       try {
//         selectedDate = DateTime.parse(widget.flat.availableDate!);
//       } catch (_) {
//         selectedDate = null;
//       }
//     }

//     selectedRooms = roomsOptions.contains(widget.flat.rooms.toString())
//         ? widget.flat.rooms.toString()
//         : null;

//     selectedStatus = statusOptions.contains(widget.flat.status)
//         ? widget.flat.status
//         : "available";

//     selectedSection = sectionOptions.contains(widget.flat.section)
//         ? widget.flat.section
//         : null;

//     hasElevator = widget.flat.hasElevator;
//     isFurnished = widget.flat.isFurnished;

//     updateController.selectedSection.value = selectedSection;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           const Background(),
//           Positioned(
//             top: -100,
//             left: -80,
//             child: GlowingCircle(
//               diameter: 300,
//               color: const Color(0xFF6A4CFF).withOpacity(0.70),
//             ),
//           ),
//           Positioned(
//             bottom: -120,
//             right: -100,
//             child: GlowingCircle(
//               diameter: 350,
//               color: const Color(0xFF00D1FF).withOpacity(0.65),
//             ),
//           ),
//           Center(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(25),
//               child: Container(
//                 padding: const EdgeInsets.all(25),
//                 width: 330,
//                 constraints: const BoxConstraints(maxHeight: 600),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(25),
//                   border: Border.all(color: Colors.white.withOpacity(0.2)),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       if (Get.locale?.languageCode == 'en') ...[
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: IconButton(
//                             icon: const Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                             ),
//                             onPressed: () => Navigator.pop(context),
//                           ),
//                         ),
//                       ] else ...[
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: IconButton(
//                             icon: const Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                             ),
//                             onPressed: () => Navigator.pop(context),
//                           ),
//                         ),
//                       ],
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Container(
//                             width: 200,
//                             height: 110,
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.10),
//                               borderRadius: BorderRadius.circular(25),
//                               border: Border.all(
//                                 color: Colors.white.withOpacity(0.3),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: 50,
//                             height: 38,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               color: Colors.white.withOpacity(0.20),
//                             ),
//                             child: Center(
//                               child: IconButton(
//                                 icon: const Icon(Icons.add),
//                                 color: Colors.white,
//                                 iconSize: 22,
//                                 onPressed: () async {
//                                   await updateController.pickImage();
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 10),

//                       GlassDropdownField(
//                         label: "18".tr,
//                         items: ["64".tr, "65".tr, "66".tr, "67".tr],
//                         onChanged: (v) => governorateValue = v,
//                       ),
//                       const SizedBox(height: 15),
//                       GlassDropdownField(
//                         label: "59".tr,
//                         items: ["61".tr, "62".tr, "63".tr],
//                         onChanged: (v) => cityValue = v,
//                       ),
//                       const SizedBox(height: 15),
//                       GlassTextField(
//                         hint: "40".tr,
//                         icon: Icons.place,
//                         initialValue: addressValue,
//                         onChanged: (v) => addressValue = v,
//                       ),
//                       const SizedBox(height: 15),
//                       GlassTextField(
//                         hint: "19".tr,
//                         icon: Icons.price_change,
//                         initialValue: priceValue,
//                         onChanged: (v) => priceValue = v,
//                       ),
//                       const SizedBox(height: 15),
//                       GlassTextField(
//                         hint: "22".tr,
//                         icon: Icons.space_bar,
//                         initialValue: spaceValue,
//                         onChanged: (v) => spaceValue = v,
//                       ),
//                       const SizedBox(height: 15),
//                       GlassTextField(
//                         hint: "25".tr,
//                         icon: Icons.numbers_rounded,
//                         initialValue: floorValue,
//                         onChanged: (v) => floorValue = v,
//                       ),
//                       const SizedBox(height: 15),
//                       DatePickerField(
//                         hintt: "39".tr,
//                         initialDate: selectedDate,
//                         onDateSelected: (date) => selectedDate = date,
//                       ),
//                       const SizedBox(height: 15),
//                       GlassDropdownField(
//                         label: "21".tr,
//                         items: roomsOptions,
//                         value: selectedRooms,
//                         onChanged: (v) => setState(() => selectedRooms = v),
//                       ),
//                       const SizedBox(height: 15),
//                       GlassDropdownField(
//                         label: "35".tr,
//                         items: statusOptions,
//                         value: selectedStatus,
//                         onChanged: (v) => setState(() => selectedStatus = v),
//                       ),
//                       const SizedBox(height: 15),
//                       GlassDropdownField(
//                         label: "68".tr,
//                         items: sectionOptions,
//                         value: selectedSection,
//                         onChanged: (v) {
//                           setState(() => selectedSection = v);
//                           updateController.selectedSection.value = v;
//                         },
//                       ),
//                       SwitchListTile(
//                         title: Text(
//                           "23".tr,
//                           style: TextStyle(color: Colors.white54),
//                         ),
//                         value: hasElevator,
//                         onChanged: (v) => setState(() => hasElevator = v),
//                       ),
//                       SwitchListTile(
//                         title: Text(
//                           "24".tr,
//                           style: TextStyle(color: Colors.white54),
//                         ),
//                         value: isFurnished,
//                         onChanged: (v) => setState(() => isFurnished = v),
//                       ),
//                       const SizedBox(height: 15),
//                       Obx(() {
//                         return Column(
//                           children: [
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: updateController.isLoading.value
//                                     ? null
//                                     : () async {
//                                         final confirm = await showDialog<bool>(
//                                           context: context,
//                                           builder: (ctx) => AlertDialog(
//                                             title: Text("77".tr),
//                                             content: Text("78".tr),
//                                             actions: [
//                                               TextButton(
//                                                 onPressed: () => Navigator.of(
//                                                   ctx,
//                                                 ).pop(false),
//                                                 child: Text("30".tr),
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: () =>
//                                                     Navigator.of(ctx).pop(true),
//                                                 child: Text("48".tr),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                         if (confirm == true) {
//                                           await updateController.updateFlat(
//                                             id: widget.flat.id,
//                                             governorate: governorateValue,
//                                             city: cityValue,
//                                             address: addressValue,
//                                             price: double.tryParse(
//                                               priceValue ?? "",
//                                             ),
//                                             rooms: int.tryParse(
//                                               selectedRooms ?? "",
//                                             ),
//                                             space: int.tryParse(
//                                               spaceValue ?? "",
//                                             ),
//                                             floor: int.tryParse(
//                                               floorValue ?? "",
//                                             ),
//                                             hasElevator: hasElevator,
//                                             isFurnished: isFurnished,
//                                             status: selectedStatus,
//                                             availableDate: selectedDate,
//                                             flatImagePath:
//                                                 updateController
//                                                     .pickedImagePath
//                                                     .value
//                                                     .isNotEmpty
//                                                 ? updateController
//                                                       .pickedImagePath
//                                                       .value
//                                                 : null,
//                                             section: selectedSection,
//                                           );
//                                           Navigator.pop(context);
//                                         }
//                                       },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.white.withOpacity(
//                                     0.85,
//                                   ),
//                                   foregroundColor: Colors.black87,
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 14,
//                                   ),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(18),
//                                   ),
//                                 ),
//                                 child: updateController.isLoading.value
//                                     ? const CircularProgressIndicator()
//                                     : Text(
//                                         "41".tr,
//                                         style: const TextStyle(fontSize: 17),
//                                       ),
//                               ),
//                             ),
//                             if (updateController.errorMessage.isNotEmpty)
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10),
//                                 child: Text(
//                                   updateController.errorMessage.value,
//                                   style: const TextStyle(
//                                     color: Colors.redAccent,
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         );
//                       }),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/GlassTextField.dart';
import '../widgets/GlassDropdown.dart';
import '../widgets/GlowingCircle.dart';
import '../widgets/Background.dart';
import '../widgets/DatePickerField.dart';
import '../../controllers/flats_controllers/update_flat_controller.dart';
import '../../models/flat_model.dart';

class EditApartment extends StatefulWidget {
  final FlatModel flat;
  const EditApartment({super.key, required this.flat});

  @override
  State<EditApartment> createState() => _EditApartmentState();
}

class _EditApartmentState extends State<EditApartment> {
  late String? governorateValue;
  late String? cityValue;
  late String? addressValue;
  late String? priceValue;
  late String? spaceValue;
  late String? floorValue;
  late DateTime? selectedDate;
  late String? selectedRooms;
  late String? selectedStatus;
  late String? selectedSection;
  late bool hasElevator;
  late bool isFurnished;
  final updateController = Get.put(UpdateFlatController());

  final List<String> sectionOptions = ["26".tr, "27".tr, "28".tr];
  final List<String> roomsOptions = ["1", "2", "3", "4", "5"];
  final List<String> statusOptions = ["available", "unavailable"];

  // ⭐ Mapping tables
  final Map<String, String> governorateMap = {
    "64".tr: "Damascus",
    "65".tr: "Aleppo",
    "66".tr: "Lattakia",
    "67".tr: "Homs",
  };

  final Map<String, String> cityMap = {
    "61".tr: "Urban",
    "62".tr: "Suburban",
    "63".tr: "Rural",
  };

  final Map<String, String> sectionMap = {
    "26".tr: "Luxury Apartments",
    "27".tr: "Standard Apartments",
    "28".tr: "Bed Spaces",
  };

  final Map<String, String> statusMap = {
    "available": "available",
    "unavailable": "unavailable",
  };

  final Map<String, int> roomsMap = {"1": 1, "2": 2, "3": 3, "4": 4, "5": 5};

  @override
  void initState() {
    super.initState();

    governorateValue = widget.flat.governorate;
    cityValue = widget.flat.city;
    addressValue = widget.flat.address;
    priceValue = widget.flat.price.toString();
    spaceValue = widget.flat.space.toString();
    floorValue = widget.flat.floor.toString();

    if (widget.flat.availableDate != null &&
        widget.flat.availableDate!.isNotEmpty) {
      try {
        selectedDate = DateTime.parse(widget.flat.availableDate!);
      } catch (_) {
        selectedDate = null;
      }
    }

    selectedRooms = roomsOptions.contains(widget.flat.rooms.toString())
        ? widget.flat.rooms.toString()
        : null;

    selectedStatus = statusOptions.contains(widget.flat.status)
        ? widget.flat.status
        : "available";

    selectedSection = null;
    for (var entry in sectionMap.entries) {
      if (entry.value == widget.flat.section) {
        selectedSection = entry.key; // translated label like "26".tr
        break;
      }
    }

    hasElevator = widget.flat.hasElevator;
    isFurnished = widget.flat.isFurnished;

    updateController.selectedSection.value = selectedSection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Positioned(
            top: -100,
            left: -80,
            child: GlowingCircle(
              diameter: 300,
              color: const Color(0xFF6A4CFF).withOpacity(0.70),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -100,
            child: GlowingCircle(
              diameter: 350,
              color: const Color(0xFF00D1FF).withOpacity(0.65),
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                padding: const EdgeInsets.all(25),
                width: 330,
                constraints: const BoxConstraints(maxHeight: 600),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (Get.locale?.languageCode == 'en') ...[
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ] else ...[
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 38,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white.withOpacity(0.20),
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.white,
                                iconSize: 22,
                                onPressed: () async {
                                  await updateController.pickImage();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Form fields continued
                      GlassDropdownField(
                        label: "18".tr,
                        items: ["64".tr, "65".tr, "66".tr, "67".tr],
                        onChanged: (v) => governorateValue = v,
                      ),
                      const SizedBox(height: 15),
                      GlassDropdownField(
                        label: "59".tr,
                        items: ["61".tr, "62".tr, "63".tr],
                        onChanged: (v) => cityValue = v,
                      ),
                      const SizedBox(height: 15),
                      GlassTextField(
                        hint: "40".tr,
                        icon: Icons.place,
                        initialValue: addressValue,
                        onChanged: (v) => addressValue = v,
                      ),
                      const SizedBox(height: 15),
                      GlassTextField(
                        hint: "19".tr,
                        icon: Icons.price_change,
                        initialValue: priceValue,
                        onChanged: (v) => priceValue = v,
                      ),
                      const SizedBox(height: 15),
                      GlassTextField(
                        hint: "22".tr,
                        icon: Icons.space_bar,
                        initialValue: spaceValue,
                        onChanged: (v) => spaceValue = v,
                      ),
                      const SizedBox(height: 15),
                      GlassTextField(
                        hint: "25".tr,
                        icon: Icons.numbers_rounded,
                        initialValue: floorValue,
                        onChanged: (v) => floorValue = v,
                      ),
                      const SizedBox(height: 15),
                      DatePickerField(
                        hintt: "39".tr,
                        initialDate: selectedDate,
                        onDateSelected: (date) => selectedDate = date,
                      ),
                      const SizedBox(height: 15),
                      GlassDropdownField(
                        label: "21".tr,
                        items: roomsOptions,
                        value: selectedRooms,
                        onChanged: (v) => setState(() => selectedRooms = v),
                      ),
                      const SizedBox(height: 15),
                      GlassDropdownField(
                        label: "35".tr,
                        items: statusOptions,
                        value: selectedStatus,
                        onChanged: (v) => setState(() => selectedStatus = v),
                      ),
                      const SizedBox(height: 15),
                      GlassDropdownField(
                        label: "68".tr,
                        items: sectionOptions,
                        value: selectedSection,
                        onChanged: (v) {
                          setState(() => selectedSection = v);
                          updateController.selectedSection.value = v;
                        },
                      ),
                      SwitchListTile(
                        title: Text(
                          "23".tr,
                          style: const TextStyle(color: Colors.white54),
                        ),
                        value: hasElevator,
                        onChanged: (v) => setState(() => hasElevator = v),
                      ),
                      SwitchListTile(
                        title: Text(
                          "24".tr,
                          style: const TextStyle(color: Colors.white54),
                        ),
                        value: isFurnished,
                        onChanged: (v) => setState(() => isFurnished = v),
                      ),
                      const SizedBox(height: 15),

                      Obx(() {
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: updateController.isLoading.value
                                    ? null
                                    : () async {
                                        final confirm = await showDialog<bool>(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: Text("77".tr),
                                            content: Text("78".tr),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(
                                                  ctx,
                                                ).pop(false),
                                                child: Text("30".tr),
                                              ),
                                              ElevatedButton(
                                                onPressed: () =>
                                                    Navigator.of(ctx).pop(true),
                                                child: Text("48".tr),
                                              ),
                                            ],
                                          ),
                                        );
                                        if (confirm == true) {
                                          await updateController.updateFlat(
                                            id: widget.flat.id,
                                            governorate:
                                                governorateMap[governorateValue] ??
                                                "",
                                            city: cityMap[cityValue] ?? "",
                                            address: addressValue,
                                            price: double.tryParse(
                                              priceValue ?? "",
                                            ),
                                            rooms: roomsMap[selectedRooms] ?? 0,
                                            space: int.tryParse(
                                              spaceValue ?? "",
                                            ),
                                            floor: int.tryParse(
                                              floorValue ?? "",
                                            ),
                                            hasElevator: hasElevator,
                                            isFurnished: isFurnished,
                                            status:
                                                statusMap[selectedStatus] ??
                                                "available",
                                            availableDate: selectedDate,
                                            flatImagePath:
                                                updateController
                                                    .pickedImagePath
                                                    .value
                                                    .isNotEmpty
                                                ? updateController
                                                      .pickedImagePath
                                                      .value
                                                : null,
                                            section:
                                                sectionMap[selectedSection] ??
                                                "",
                                          );
                                          Navigator.pop(context);
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(
                                    0.85,
                                  ),
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: updateController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "41".tr,
                                        style: const TextStyle(fontSize: 17),
                                      ),
                              ),
                            ),
                            if (updateController.errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  updateController.errorMessage.value,
                                  style: const TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
