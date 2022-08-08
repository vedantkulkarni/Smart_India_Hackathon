import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_face_api/face_api.dart' as Regula;
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';

class FaceVerifyWithProfileImage extends StatefulWidget {
  // Image capturedImage;
  const FaceVerifyWithProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  State<FaceVerifyWithProfileImage> createState() =>
      _FaceVerifyWithProfileImageState();
}

class _FaceVerifyWithProfileImageState
    extends State<FaceVerifyWithProfileImage> {
  var image1 = Regula.MatchFacesImage();
  var image2 = Regula.MatchFacesImage();
  var img1 =
      Image.network('https://avatars.githubusercontent.com/u/24658039?v=4');

  var img2 = Image.network(
      'https://media-exp1.licdn.com/dms/image/C4E03AQEAjY7zppPysw/profile-displayphoto-shrink_400_400/0/1649335610989?e=1665619200&v=beta&t=FP9PZ_7SSbW-EbWxi4bRKuG1zaxXox4qu1nmENzUTSw');

  var _similarity = '';

  Future<Uint8List> getBytesOfNetworkImage(String imageUrl) async {
    Uint8List bytes =
        (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
            .buffer
            .asUint8List();
    return bytes;
  }

  // showAlertDialog(BuildContext context, bool first) => showDialog(
  //   context: context,
  //   builder: (BuildContext context) =>
  //       // AlertDialog(title: const Text("Select option"), actions: [
  //   // ignore: deprecated_member_use
  //   FlatButton(
  //       child: const Text("Use gallery"),
  //       onPressed: () {
  //       //   ImagePicker().getImage(source: ImageSource.gallery).then(
  //       //       (value) => setImage(
  //       //           first,
  //       //           io.File(value!.path).readAsBytesSync(),
  //       //           Regula.ImageType.PRINTED));
  //       //   Navigator.pop(context);
  //       // }),
  //   // ignore: deprecated_member_use
  //   FlatButton(
  //       child: const Text("Use camera"),
  //       onPressed: () {
  //         Regula.FaceSDK.presentFaceCaptureActivity().then((result) =>
  //             setImage(
  //                 first,
  //                 base64Decode(Regula.FaceCaptureResponse.fromJson(
  //                         json.decode(result))!
  //                     .image!
  //                     .bitmap!
  //                     .replaceAll("\n", "")),
  //                 Regula.ImageType.LIVE));
  //         Navigator.pop(context);
  //       })
  // ]));
  setImage(bool first, List<int> imageFile, int type) {
    if (imageFile == null) return;
    setState(() => _similarity = "nil");
    if (first) {
      image1.bitmap = base64Encode(imageFile);
      image1.imageType = type;
      setState(() {
        img1 = Image.memory(Uint8List.fromList(imageFile));
      });
    } else {
      image2.bitmap = base64Encode(imageFile);
      image2.imageType = type;
      setState(() => img2 = Image.memory(Uint8List.fromList(imageFile)));
    }
  }

  matchFaces() {
    print(image1.bitmap);
    if (image1.bitmap == null ||
        image1.bitmap == "" ||
        image2.bitmap == null ||
        image2.bitmap == "") return;
    setState(() => _similarity = "Processing...");
    var request = Regula.MatchFacesRequest();
    request.images = [image1, image2];
    Regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
      var response = Regula.MatchFacesResponse.fromJson(json.decode(value));
      Regula.FaceSDK.matchFacesSimilarityThresholdSplit(
              jsonEncode(response!.results), 0.75)
          .then((str) {
        var split = Regula.MatchFacesSimilarityThresholdSplit.fromJson(
            json.decode(str));
        setState(() => _similarity = split!.matchedFaces.isNotEmpty
            ? ((split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2) +
                "%")
            : "error");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Face Verify'),
          Row(
            children: [
              Expanded(
                child: Image.network(
                    'https://avatars.githubusercontent.com/u/24658039?v=4'),
              ),
              Expanded(
                child: Image.network(
                    'https://media-exp1.licdn.com/dms/image/C4E03AQEAjY7zppPysw/profile-displayphoto-shrink_400_400/0/1649335610989?e=1665619200&v=beta&t=FP9PZ_7SSbW-EbWxi4bRKuG1zaxXox4qu1nmENzUTSw'),
              ),
            ],
          ),
          CustomTextButton(
              onPressed: () {
                matchFaces();
              },
              text: 'Verify'),
          CustomTextButton(
              onPressed: () async {
                var firstImageasBytes = await getBytesOfNetworkImage(
                    'https://avatars.githubusercontent.com/u/24658039?v=4');
                setImage(true, firstImageasBytes, Regula.ImageType.PRINTED);
                var secon = await getBytesOfNetworkImage(
                    'https://media-exp1.licdn.com/dms/image/C4E03AQEAjY7zppPysw/profile-displayphoto-shrink_400_400/0/1649335610989?e=1665619200&v=beta&t=FP9PZ_7SSbW-EbWxi4bRKuG1zaxXox4qu1nmENzUTSw');
                setImage(false, secon, Regula.ImageType.PRINTED);
              },
              text: 'Set Both images'),
          Text(_similarity)
        ],
      )),
    );
  }
}
