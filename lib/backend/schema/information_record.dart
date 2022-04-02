import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'information_record.g.dart';

abstract class InformationRecord
    implements Built<InformationRecord, InformationRecordBuilder> {
  static Serializer<InformationRecord> get serializer =>
      _$informationRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'N_ID')
  String get nId;

  @nullable
  @BuiltValueField(wireName: 'E_ID')
  String get eId;

  @nullable
  @BuiltValueField(wireName: 'DOB')
  DateTime get dob;

  @nullable
  String get names;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  String get village;

  @nullable
  String get party;

  @nullable
  String get constit;

  @nullable
  String get gender;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(InformationRecordBuilder builder) => builder
    ..nId = ''
    ..eId = ''
    ..names = ''
    ..phoneNumber = ''
    ..village = ''
    ..party = ''
    ..constit = ''
    ..gender = ''
    ..photoUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('information');

  static Stream<InformationRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<InformationRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  InformationRecord._();
  factory InformationRecord([void Function(InformationRecordBuilder) updates]) =
      _$InformationRecord;

  static InformationRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createInformationRecordData({
  String nId,
  String eId,
  DateTime dob,
  String names,
  String phoneNumber,
  String village,
  String party,
  String constit,
  String gender,
  String photoUrl,
}) =>
    serializers.toFirestore(
        InformationRecord.serializer,
        InformationRecord((i) => i
          ..nId = nId
          ..eId = eId
          ..dob = dob
          ..names = names
          ..phoneNumber = phoneNumber
          ..village = village
          ..party = party
          ..constit = constit
          ..gender = gender
          ..photoUrl = photoUrl));
