import 'package:fedya_shashlik/ui/theme/color.dart';
import 'package:fedya_shashlik/ui/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({Key? key}) : super(key: key);

  static const route = '/address';

  @override
  State<StatefulWidget> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  String googleApikey = "AIzaSyALGzOg8Am6QsJQ9NX1-Q7sYIYbvBbKkpM";
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(39.660066, 66.974539);
  final double _initFabHeight = 100.0;
  double _fabHeight = 0.0;
  double _panelHeightOpen = 0.0;
  final double _panelHeightClosed = 0.0;
  final _panelController = PanelController();
  final addressController = TextEditingController();
  final flatController = TextEditingController();
  final floorController = TextEditingController();
  final entranceController = TextEditingController();
  final landmarkController = TextEditingController();
  String location = '';
  String address = '';
  String landmark = '';
  String entrance = '';
  String floor = '';
  String flat = '';

  @override
  void initState() {
    Geolocator.requestPermission();
    _fabHeight = _initFabHeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _panelHeightOpen = mediaQuery.size.height * .5;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          buildSlidingUpPanel(mediaQuery, context),
          buildPositioned(context),
          // the Fab
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              onPressed: () async {
                var latLang = await Geolocator.getCurrentPosition();
                mapController!.animateCamera(CameraUpdate.newLatLng(LatLng(latLang.latitude, latLang.longitude)));
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.gps_fixed,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPositioned(BuildContext context) => Positioned(
        top: 50.0,
        left: 10.0,
        child: Material(
          color: Colors.white,
          shape: const CircleBorder(),
          child: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      );

  Widget buildSlidingUpPanel(MediaQueryData mediaQuery, BuildContext context) => SlidingUpPanel(
        controller: _panelController,
        maxHeight: _panelHeightOpen,
        minHeight: _panelHeightClosed,
        parallaxEnabled: true,
        parallaxOffset: .3,
        body: _body(mediaQuery),
        panelBuilder: (ScrollController scrollController) => Material(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              controller: scrollController,
              children: <Widget>[
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Адрес доставки',
                      style: AppTextStyles.title1,
                    ),
                  ],
                ),
                const SizedBox(height: 18.0),
                Container(
                  height: 60.0,
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: addressController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    onChanged: (value) => address = value,
                    decoration: InputDecoration(
                      labelText: 'Текущий адрес',
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
                Container(
                  constraints: BoxConstraints.tight(const Size(300.0, 50.0)),
                  height: 60.0,
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 55.0,
                        width: 75.0,
                        child: TextField(
                          controller: entranceController,
                          onChanged: (value) => entrance = value,
                          decoration: const InputDecoration(labelText: 'Подъезд'),
                        ),
                      ),
                      // const SizedBox(width: 24.0),
                      SizedBox(
                        height: 55.0,
                        width: 75.0,
                        child: TextField(
                          onChanged: (value) => floor = value,
                          controller: floorController,
                          decoration: const InputDecoration(labelText: 'Этаж'),
                        ),
                      ),
                      // const SizedBox(width: 24.0),
                      SizedBox(
                        height: 55.0,
                        width: 75.0,
                        child: TextField(
                          onChanged: (value) => flat = value,
                          controller: flatController,
                          decoration: const InputDecoration(labelText: 'Квартира'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18.0),
                Container(
                  height: 60.0,
                  width: 300.0,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    controller: landmarkController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    onChanged: (value) => landmark = value,
                    decoration: InputDecoration(
                      labelText: 'Ориентир',
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    height: mediaQuery.size.height * .07,
                    minWidth: mediaQuery.size.width,
                    color: AppColors.yellow,
                    disabledColor: AppColors.grey,
                    onPressed: () {
                      Navigator.pop(context, [location, address, landmark, entrance, floor, flat]);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.confirm,
                      style: AppTextStyles.title0.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
        onPanelSlide: (double pos) => setState(() => _fabHeight = pos * (_panelHeightOpen - 60.0) + _initFabHeight),
      );

  Widget _body(MediaQueryData mediaQuery) => Stack(children: [
        GoogleMap(
          scrollGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: startLocation,
            zoom: 14.0,
          ),
          onMapCreated: (controller) => setState(() => mapController = controller),
          rotateGesturesEnabled: true,
          mapToolbarEnabled: true,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomGesturesEnabled: true,
          mapType: MapType.normal,
          onCameraMoveStarted: () => _panelController.close(),
          onCameraMove: (CameraPosition cameraPositionX) => cameraPosition = cameraPositionX,
          onCameraIdle: () async {
            if (cameraPosition != null) {
              List<Placemark> placeMark = await placemarkFromCoordinates(
                cameraPosition!.target.latitude,
                cameraPosition!.target.longitude,
                localeIdentifier: 'ru_RU',
              );
              // print(placeMark);
              setState(() {
                location = placeMark.first.toString();
                address = getAddress(placeMark);
                // print(address);
              });
            }
          },
        ),
        Positioned(
          top: 75,
          left: 50,
          right: 50,
          child: Text(
            address,
            style: AppTextStyles.headline.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Image.asset(
              'assets/picker.png',
              height: 64.0,
              width: 64.0,
            ),
          ),
        ),
        Positioned(
          left: 12,
          bottom: 12,
          right: 12,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              height: mediaQuery.size.height * .07,
              minWidth: mediaQuery.size.width,
              color: AppColors.yellow,
              disabledColor: AppColors.grey,
              onPressed: location != ''
                  ? () {
                      addressController.text = address;
                      landmarkController.text = landmark;
                      entranceController.text = entrance;
                      floorController.text = floor;
                      flatController.text = flat;
                      _panelController.open();
                    }
                  : null,
              child: Text(
                AppLocalizations.of(context)!.confirm,
                style: AppTextStyles.title0.copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
      ]);

  String getAddress(List<Placemark> placeMark) {
    final String region = placeMark[1].subAdministrativeArea != null ? (placeMark[1].subAdministrativeArea!.isNotEmpty ? placeMark[1].subAdministrativeArea! : '') : '';
    final String street = placeMark[1].thoroughfare != null ? (placeMark[1].thoroughfare!.isNotEmpty ? placeMark[1].thoroughfare! : '') : '';
    final String home = placeMark[1].subThoroughfare != null ? (placeMark[1].subThoroughfare!.isNotEmpty ? placeMark[1].subThoroughfare! : '') : '';
    return region + (street != '' ? (region != '' ? ', $street' : street) : '') + (home != '' ? (street != '' ? ', $home' : home) : '');
  }
}
