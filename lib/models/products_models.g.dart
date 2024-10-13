// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String,
      vendor: fields[1] as String,
      name: fields[2] as String,
      photo: (fields[3] as List).cast<dynamic>(),
      productDetails: fields[4] as String,
      category: fields[5] as String,
      price: fields[6] as double,
      createdAt: fields[9] as DateTime,
      updatedAt: fields[10] as DateTime,
      averageRating: (fields[11] as Map).cast<String, dynamic>(),
      units: fields[7] as int,
      discountPercentage: fields[8] as double,
      discountedPrice: fields[12] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vendor)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.photo)
      ..writeByte(4)
      ..write(obj.productDetails)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.units)
      ..writeByte(8)
      ..write(obj.discountPercentage)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.averageRating)
      ..writeByte(12)
      ..write(obj.discountedPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
