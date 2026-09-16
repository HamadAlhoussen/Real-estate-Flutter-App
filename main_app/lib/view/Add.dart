// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../widgets/GlassDropDown.dart';
// import '../widgets/GlassTextField.dart';
// import '../widgets/GlowingCircle.dart';
// import '../widgets/Background.dart';
// import '../widgets/DatePickerField.dart';
// import '../../controllers/flats_controllers/create_flat_controller.dart';

// class Add extends StatefulWidget {
//   const Add({super.key});

//   @override
//   State<Add> createState() => AddState();
// }

// class AddState extends State<Add> {
//   String? governorateValue,
//       cityValue,
//       addressValue,
//       priceValue,
//       spaceValue,
//       floorValue;

//   DateTime? selectedDate;
//   String? selectedRooms;
//   String? selectedSection;

//   bool hasElevator = false;
//   bool isFurnished = false;
//   bool sectionError = false;

//   final createController = Get.put(CreateFlatController());

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
//                 constraints: const BoxConstraints(maxHeight: 600),
//                 width: 330,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(25),
//                   border: Border.all(color: Colors.white.withOpacity(0.2)),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
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
//                           IconButton(
//                             icon: const Icon(Icons.add, color: Colors.white),
//                             iconSize: 22,
//                             onPressed: () async =>
//                                 await createController.pickImage(),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 15),
//                       GlassDropdownField(
//                         label: "18".tr,
//                         items: ["Damascus", "Lattakia", "Homs", "Swaidaa"],
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
//                         onChanged: (v) => addressValue = v,
//                       ),
//                       const SizedBox(height: 15),

//                       GlassTextField(
//                         hint: "19".tr,
//                         icon: Icons.price_change,
//                         onChanged: (v) => priceValue = v,
//                       ),
//                       const SizedBox(height: 15),

//                       GlassTextField(
//                         hint: "22".tr,
//                         icon: Icons.space_bar,
//                         onChanged: (v) => spaceValue = v,
//                       ),
//                       const SizedBox(height: 15),

//                       GlassTextField(
//                         hint: "25".tr,
//                         icon: Icons.numbers,
//                         onChanged: (v) => floorValue = v,
//                       ),
//                       const SizedBox(height: 15),

//                       DatePickerField(
//                         hintt: "39".tr,
//                         onDateSelected: (d) => selectedDate = d,
//                       ),
//                       const SizedBox(height: 15),

//                       GlassDropdownField(
//                         label: "21".tr,
//                         items: const ["1", "2", "3", "4", "5"],
//                         value: selectedRooms,
//                         onChanged: (v) => selectedRooms = v,
//                       ),
//                       const SizedBox(height: 15),

//                       GlassDropdownField(
//                         label: "68".tr,
//                         items: ["26".tr, "27".tr, "28".tr],
//                         value: selectedSection,
//                         hasError: sectionError,
//                         onChanged: (v) {
//                           setState(() {
//                             selectedSection = v;
//                             sectionError = false;
//                           });
//                         },
//                       ),
//                       SwitchListTile(
//                         title: Text(
//                           "23".tr,
//                           style: const TextStyle(color: Colors.white54),
//                         ),
//                         value: hasElevator,
//                         onChanged: (v) => setState(() => hasElevator = v),
//                       ),

//                       SwitchListTile(
//                         title: Text(
//                           "24".tr,
//                           style: const TextStyle(color: Colors.white54),
//                         ),
//                         value: isFurnished,
//                         onChanged: (v) => setState(() => isFurnished = v),
//                       ),

//                       const SizedBox(height: 25),

//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             if (selectedSection == null) {
//                               setState(() => sectionError = true);
//                               Get.snackbar("71".tr, "72".tr);
//                               return;
//                             }

//                             await createController.createFlat(
//                               governorate: governorateValue ?? "",
//                               city: cityValue ?? "",
//                               address: addressValue ?? "",
//                               price: double.tryParse(priceValue ?? "0") ?? 0,
//                               rooms: int.tryParse(selectedRooms ?? "0") ?? 0,
//                               space: int.tryParse(spaceValue ?? "0") ?? 0,
//                               floor: int.tryParse(floorValue ?? "0") ?? 0,
//                               hasElevator: hasElevator,
//                               isFurnished: isFurnished,
//                               availableDate: selectedDate ?? DateTime.now(),
//                               section: selectedSection!,
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white.withOpacity(0.85),
//                             foregroundColor: Colors.black87,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18),
//                             ),
//                           ),
//                           child: Text(
//                             "41".tr,
//                             style: const TextStyle(fontSize: 17),
//                           ),
//                         ),
//                       ),
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
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/GlassDropDown.dart';
import '../widgets/GlassTextField.dart';
import '../widgets/GlowingCircle.dart';
import '../widgets/Background.dart';
import '../widgets/DatePickerField.dart';
import '../../controllers/flats_controllers/create_flat_controller.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => AddState();
}

class AddState extends State<Add> {
  String? governorateValue,
      cityValue,
      addressValue,
      priceValue,
      spaceValue,
      floorValue;

  DateTime? selectedDate;
  String? selectedRooms;
  String? selectedSection;

  bool hasElevator = false;
  bool isFurnished = false;
  bool sectionError = false;

  final createController = Get.put(CreateFlatController());

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
                constraints: const BoxConstraints(maxHeight: 600),
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: SingleChildScrollView(
                  child: Column(
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
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            iconSize: 22,
                            onPressed: () async =>
                                await createController.pickImage(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
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
                        onChanged: (v) => addressValue = v,
                      ),
                      const SizedBox(height: 15),
                      GlassTextField(
                        hint: "19".tr,
                        icon: Icons.price_change,
                        onChanged: (v) => priceValue = v,
                      ),
                      const SizedBox(height: 15),
                      GlassTextField(
                        hint: "22".tr,
                        icon: Icons.space_bar,
                        onChanged: (v) => spaceValue = v,
                      ),
                      const SizedBox(height: 15),

                      GlassTextField(
                        hint: "25".tr,
                        icon: Icons.numbers,
                        onChanged: (v) => floorValue = v,
                      ),
                      const SizedBox(height: 15),

                      DatePickerField(
                        hintt: "39".tr,
                        onDateSelected: (d) => selectedDate = d,
                      ),
                      const SizedBox(height: 15),

                      GlassDropdownField(
                        label: "21".tr,
                        items: const ["1", "2", "3", "4", "5"],
                        value: selectedRooms,
                        onChanged: (v) => selectedRooms = v,
                      ),
                      const SizedBox(height: 15),

                      GlassDropdownField(
                        label: "68".tr,
                        items: ["26".tr, "27".tr, "28".tr],
                        value: selectedSection,
                        hasError: sectionError,
                        onChanged: (v) {
                          setState(() {
                            selectedSection = v;
                            sectionError = false;
                          });
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

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (selectedSection == null) {
                              setState(() => sectionError = true);
                              Get.snackbar("71".tr, "72".tr);
                              return;
                            }

                            await createController.createFlat(
                              governorate:
                                  governorateMap[governorateValue] ?? "",
                              city: cityMap[cityValue] ?? "",
                              address: addressValue ?? "",
                              price: double.tryParse(priceValue ?? "0") ?? 0,
                              rooms: int.tryParse(selectedRooms ?? "0") ?? 0,
                              space: int.tryParse(spaceValue ?? "0") ?? 0,
                              floor: int.tryParse(floorValue ?? "0") ?? 0,
                              hasElevator: hasElevator,
                              isFurnished: isFurnished,
                              availableDate: selectedDate ?? DateTime.now(),
                              section: sectionMap[selectedSection] ?? "",
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.85),
                            foregroundColor: Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Text(
                            "41".tr,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
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
