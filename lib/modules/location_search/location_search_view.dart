import 'package:flutter/material.dart';
import 'package:furniture_app/modules/location_search/location_search_controller.dart';
import 'package:get/get.dart';

import '../../app/models/location_model.dart';

// class LocationSearchView extends GetView<LocationSearchController> {
//   const LocationSearchView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//
//             // ── App Bar ──
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: controller.goBack,
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                             color: const Color(0xFFEEEEEE), width: 1.5),
//                       ),
//                       child: const Icon(Icons.arrow_back_ios_new_rounded,
//                           size: 16, color: Colors.black87),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Text(
//                     'Enter Your Location',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // ── Search Bar ──
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF3F2F2),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(left: 16, right: 8),
//                       child: Icon(Icons.search_rounded,
//                           color: Colors.grey, size: 22),
//                     ),
//                     Expanded(
//                       child: TextField(
//                         controller: controller.searchController.value,
//                         focusNode: controller.searchFocus,
//                         onChanged: controller.onSearchChanged,
//                         decoration: const InputDecoration(
//                           hintText: 'Golden Avenue',
//                           hintStyle:
//                           TextStyle(color: Colors.grey, fontSize: 14),
//                           border: InputBorder.none,
//                           isDense: true,
//                           contentPadding:
//                           EdgeInsets.symmetric(vertical: 14),
//                         ),
//                         style: const TextStyle(
//                             fontSize: 14, color: Colors.black87),
//                       ),
//                     ),
//                     // Clear / X button
//                       Obx(() => controller.searchController.value.text.isNotEmpty
//                         ? GestureDetector(
//                       onTap: controller.clearSearch,
//                       child: Container(
//                         margin: const EdgeInsets.only(right: 12),
//                         width: 22,
//                         height: 22,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                               color: Colors.grey.shade400, width: 1.5),
//                         ),
//                         child: Icon(Icons.close,
//                             size: 13,
//                             color: Colors.grey.shade500),
//                       ),
//                     )
//                         : const SizedBox(width: 16)),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // ── Use Current Location ──
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: GestureDetector(
//                 onTap: controller.useCurrentLocation,
//                 child: Obx(
//                       () => Row(
//                     children: [
//                       controller.isLoadingCurrentLocation.value
//                           ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           color: Color(0xFF3B6B5E),
//                         ),
//                       )
//                           : const Icon(Icons.navigation_rounded,
//                           color: Color(0xFF3B6B5E), size: 22),
//                       const SizedBox(width: 12),
//                       const Text(
//                         'Use my current location',
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//             const Divider(color: Color(0xFFEEEEEE), height: 1),
//             const SizedBox(height: 16),
//
//             // ── Search Results ──
//             Expanded(
//               child: Obx(() {
//                 if (controller.isSearching.value) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: Color(0xFF3B6B5E),
//                       strokeWidth: 2.5,
//                     ),
//                   );
//                 }
//
//                 if (controller.searchResults.isEmpty &&
//                     controller.searchController.value.text.isNotEmpty) {
//                   return const Center(
//                     child: Text(
//                       'No results found',
//                       style: TextStyle(color: Colors.grey, fontSize: 14),
//                     ),
//                   );
//                 }
//
//                 if (controller.searchResults.isEmpty) {
//                   return const SizedBox();
//                 }
//
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: Text(
//                         'SEARCH RESULT',
//                         style: TextStyle(
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey,
//                           letterSpacing: 0.8,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     ...controller.searchResults.map(
//                           (result) => LocationResultTile(
//                         result: result,
//                         onTap: () => controller.onLocationSelected(result),
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─── Location Result Tile ─────────────────────────────────────────────────────
//
// class LocationResultTile extends StatelessWidget {
//   final LocationResult result;
//   final VoidCallback onTap;
//
//   const LocationResultTile({required this.result, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(top: 2),
//               child: Icon(Icons.navigation_rounded,
//                   color: Color(0xFF3B6B5E), size: 18),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     result.title,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   if (result.subtitle.isNotEmpty) ...[
//                     const SizedBox(height: 2),
//                     Text(
//                       result.subtitle,
//                       style:
//                       const TextStyle(fontSize: 12, color: Colors.grey),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LocationSearchView extends GetView<LocationSearchController> {
  const LocationSearchView({super.key});

  // ── Root ──────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16,),
            buildAppBar(),
            SizedBox(height: 20,),
            buildSearchBar(),
            SizedBox(height: 16,),
            buildCurrentLocationRow(),
            SizedBox(height: 16,),
            Divider(color: Color(0xFFEEEEEE),height: 1,),
            SizedBox(height: 16,),
            Expanded(child: buildSearchResults())

          ],
        ),
      ),
    );
  }

  // ── App bar ───────────────────────────────────────────
  Widget buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.goBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFEEEEEE),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Enter Your Location',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // ── Search bar ────────────────────────────────────────
  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3F2F2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 8),
              child: Icon(Icons.search_rounded, color: Colors.grey, size: 22),
            ),
            Expanded(
              child: TextField(
                controller: controller.searchController.value,
                focusNode: controller.searchFocus,
                onChanged: controller.onSearchChanged,
                decoration: const InputDecoration(
                  hintText: 'Golden Avenue',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            _buildClearButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Obx(
          () => controller.searchController.value.text.isNotEmpty
          ? GestureDetector(
        onTap: controller.clearSearch,
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1.5,
            ),
          ),
          child: Icon(
            Icons.close,
            size: 13,
            color: Colors.grey.shade500,
          ),
        ),
      )
          : const SizedBox(width: 16),
    );
  }

  // ── Use current location row ──────────────────────────
  Widget buildCurrentLocationRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: controller.useCurrentLocation,
        child: Obx(
              () => Row(
            children: [
              controller.isLoadingCurrentLocation.value
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF3B6B5E),
                ),
              )
                  : const Icon(
                Icons.navigation_rounded,
                color: Color(0xFF3B6B5E),
                size: 22,
              ),
              const SizedBox(width: 12),
              const Text(
                'Use my current location',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Search results ────────────────────────────────────
  Widget buildSearchResults() {
    return Obx(() {
      if (controller.isSearching.value) return _buildLoadingState();

      if (controller.searchResults.isEmpty &&
          controller.searchController.value.text.isNotEmpty) {
        return _buildEmptyState();
      }

      if (controller.searchResults.isEmpty) return const SizedBox();

      return _buildResultsList();
    });
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF3B6B5E),
        strokeWidth: 2.5,
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No results found',
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  Widget _buildResultsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'SEARCH RESULT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ...controller.searchResults.map(
              (result) => LocationResultTile(
            result: result,
            onTap: () => controller.onLocationSelected(result),
          ),
        ),
      ],
    );
  }
}

// ─── Location Result Tile ─────────────────────────────────────────────────────

class LocationResultTile extends StatelessWidget {
  final LocationResult result;
  final VoidCallback onTap;

  const LocationResultTile({required this.result, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(
                Icons.navigation_rounded,
                color: Color(0xFF3B6B5E),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: buildTileContent()),
          ],
        ),
      ),
    );
  }

  // ── Tile title + subtitle ─────────────────────────────
  Widget buildTileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          result.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        if (result.subtitle.isNotEmpty) ...[
          const SizedBox(height: 2),
          Text(
            result.subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}