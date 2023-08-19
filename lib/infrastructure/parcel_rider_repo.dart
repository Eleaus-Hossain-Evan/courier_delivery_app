import 'package:velocity_x/velocity_x.dart';

import '../domain/parcel/model/top_level_rider_parcel_model.dart';
import '../domain/parcel/parcel_pickup_list_response.dart';
import '../utils/utils.dart';

class ParcelRiderRepo {
  final api = NetworkHandler.instance;

  Future<Either<CleanFailure, ParcelRiderListResponse>> getRiderParcelList(
      {required ParcelRiderType type,
      required int page,
      required int limit,
      required bool isComplete}) async {
    // final data = await api.post(
    //   body: {"status": type.name, "isComplete": isComplete},
    //   fromData: (json) => ParcelRiderListResponse.fromMap(json),
    //   endPoint: "${EndPointRider.PARCEL_PICKUPMAN}page=$page&limit=$limit",
    //   withToken: true,
    // );

  await  Future.delayed(2.seconds);

    final Either<CleanFailure, ParcelRiderListResponse> data =
        right(ParcelRiderListResponse.fromJson("""
{
    "metaData": {
        "totalData": 3,
        "page": 1,
        "limit": 10,
        "totalPage": 1
    },
    "data": [
        {
            "_id": "64cf8d9d4c3acf503704ccbf",
            "status": "received",
            "statusHistory": [
                {
                    "time": "2023-08-06T12:10:05.959Z",
                    "_id": "64cf8d9d4c3acf503704ccc0",
                    "statusBy": "undefined(undefined)",
                    "status": "assign"
                },
                {
                    "time": "2023-08-16T10:15:05.522Z",
                    "_id": "64dca1a9051aa95df1ee0d88",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T09:50:01.157Z",
                    "_id": "64dded49ae5362651389c680",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T10:39:06.729Z",
                    "_id": "64ddf8caae5362651389c6a4",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-17T10:39:13.744Z",
                    "_id": "64ddf8d1ae5362651389c6aa",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T11:32:06.905Z",
                    "_id": "64de0536ae5362651389c700",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-17T12:03:09.576Z",
                    "_id": "64de0c7dae5362651389c740",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T12:05:02.062Z",
                    "_id": "64de0ceeae5362651389c744",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-17T12:05:05.473Z",
                    "_id": "64de0cf1ae5362651389c746",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T07:10:45.234Z",
                    "_id": "64e06af5ae5362651389c7b9",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T07:10:46.923Z",
                    "_id": "64e06af6ae5362651389c7bb",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T07:10:54.107Z",
                    "_id": "64e06afeae5362651389c7bf",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T07:11:01.681Z",
                    "_id": "64e06b05ae5362651389c7c3",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T07:11:06.937Z",
                    "_id": "64e06b0aae5362651389c7c5",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T09:49:23.158Z",
                    "_id": "64e09023ae5362651389c813",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T09:49:41.262Z",
                    "_id": "64e09035ae5362651389c817",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T09:49:52.472Z",
                    "_id": "64e09040ae5362651389c81b",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                }
            ],
            "createdAt": "2023-08-06T12:10:05.968Z",
            "updatedAt": "2023-08-19T09:49:52.473Z",
            "__v": 0,
            "isComplete": false,
            "parcel": {
                "_id": "64c9eaddef28222534435999",
                "merchantInfo": {
                    "name": "forhad",
                    "phone": "01521334958",
                    "address": "nikunjua",
                    "shopName": "gentx",
                    "shopAddress": "nikunja 1"
                },
                "regularParcelInfo": {
                    "invoiceId": "12312",
                    "weight": "2 kg",
                    "productPrice": 1200,
                    "materialType": "fragile",
                    "category": "1 kg ",
                    "details": "dfdf"
                },
                "pickupStatus": "assign",
                "serialId": "JWCNP85BUDW2NDA7"
            }
        },
        {
            "_id": "64c9ebf3ef282225344359ac",
            "status": "cancel",
            "statusHistory": [
                {
                    "time": "2023-08-03T06:31:06.655Z",
                    "_id": "64cb49aae849802cc0c262dd",
                    "statusBy": "rahim(01521334958)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T10:51:45.110Z",
                    "_id": "64ddfbc1ae5362651389c6c0",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-17T10:53:00.078Z",
                    "_id": "64ddfc0cae5362651389c6c8",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T11:17:26.259Z",
                    "_id": "64de01c6ae5362651389c6f0",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-17T11:28:27.110Z",
                    "_id": "64de045bae5362651389c6f6",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T12:07:40.650Z",
                    "_id": "64de0d8cae5362651389c74e",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T07:08:18.812Z",
                    "_id": "64e06a62ae5362651389c78b",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T07:08:58.947Z",
                    "_id": "64e06a8aae5362651389c793",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T07:09:04.068Z",
                    "_id": "64e06a90ae5362651389c797",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T07:09:10.882Z",
                    "_id": "64e06a96ae5362651389c79d",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T07:09:18.233Z",
                    "_id": "64e06a9eae5362651389c7a5",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T07:09:24.989Z",
                    "_id": "64e06aa4ae5362651389c7ab",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T07:13:02.341Z",
                    "_id": "64e06b7eae5362651389c7cf",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T07:13:39.611Z",
                    "_id": "64e06ba3ae5362651389c7d9",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                }
            ],
            "createdAt": "2023-08-02T05:38:59.994Z",
            "updatedAt": "2023-08-19T07:13:39.611Z",
            "__v": 0,
            "isComplete": false,
            "parcel": {
                "_id": "64c9eb74ef282225344359a5",
                "merchantInfo": {
                    "address": "nikunjua",
                    "shopAddress": "nikunja 1",
                    "name": "forhad",
                    "phone": "01521334958",
                    "shopName": "gentx"
                },
                "regularParcelInfo": {
                    "invoiceId": "12312",
                    "weight": "4kg",
                    "productPrice": 1200,
                    "materialType": "fragile",
                    "category": "book",
                    "details": ""
                },
                "pickupStatus": "assign",
                "serialId": "E8F2S7WI6HWS2RUV"
            }
        },
        {
            "_id": "64d215e33ba76a418361e8f6",
            "status": "received",
            "statusHistory": [
                {
                    "time": "2023-08-08T10:16:03.309Z",
                    "_id": "64d215e33ba76a418361e8f7",
                    "statusBy": "rahim(01521334958)",
                    "status": "assign"
                },
                {
                    "time": "2023-08-17T10:47:43.116Z",
                    "_id": "64ddfacfae5362651389c6b4",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-17T10:56:25.598Z",
                    "_id": "64ddfcd9ae5362651389c6d2",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T10:59:08.667Z",
                    "_id": "64ddfd7cae5362651389c6d8",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-17T11:01:38.555Z",
                    "_id": "64ddfe12ae5362651389c6e2",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T11:01:41.121Z",
                    "_id": "64ddfe15ae5362651389c6e4",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T11:16:44.060Z",
                    "_id": "64de019cae5362651389c6ea",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-17T11:37:28.847Z",
                    "_id": "64de0678ae5362651389c714",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-17T12:07:44.781Z",
                    "_id": "64de0d90ae5362651389c750",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-17T12:07:47.395Z",
                    "_id": "64de0d93ae5362651389c752",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T07:10:27.965Z",
                    "_id": "64e06ae3ae5362651389c7ad",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T07:10:33.782Z",
                    "_id": "64e06ae9ae5362651389c7b1",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T07:10:37.120Z",
                    "_id": "64e06aedae5362651389c7b3",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T09:48:27.151Z",
                    "_id": "64e08febae5362651389c805",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                },
                {
                    "time": "2023-08-19T09:48:29.151Z",
                    "_id": "64e08fedae5362651389c807",
                    "statusBy": "undefined(01521334558)",
                    "status": "cancel"
                },
                {
                    "time": "2023-08-19T09:48:35.679Z",
                    "_id": "64e08ff3ae5362651389c80b",
                    "statusBy": "undefined(01521334558)",
                    "status": "received"
                }
            ],
            "createdAt": "2023-08-08T10:16:03.320Z",
            "updatedAt": "2023-08-19T09:48:35.679Z",
            "__v": 0,
            "isComplete": false,
            "parcel": {
                "_id": "64c9f0c8cb3e0d7d4777617d",
                "merchantInfo": {
                    "address": "99",
                    "shopAddress": "Hosue 33, road 6, sector 12 Uttara",
                    "name": "Kh Nishad....",
                    "phone": "01728897264",
                    "shopName": "Kh Nishad"
                },
                "regularParcelInfo": {
                    "invoiceId": "878778",
                    "weight": "2 kg",
                    "productPrice": 1520,
                    "materialType": "fragile",
                    "category": "2 kg",
                    "details": "des"
                },
                "pickupStatus": "assign",
                "serialId": "SS8K1GVP2DPNE3TM"
            }
        }
    ],
    "message": "fetch data successfully!",
    "success": true
}
"""));
    // Logger.d(data);

    return data;
  }
}
