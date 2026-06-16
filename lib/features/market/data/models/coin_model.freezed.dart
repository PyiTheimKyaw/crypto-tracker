// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoinModel {

 String get id; String get symbol; String get name; String get image;@JsonKey(name: 'current_price') double get currentPrice;@JsonKey(name: 'market_cap') double get marketCap;@JsonKey(name: 'market_cap_rank') int get marketCapRank;@JsonKey(name: 'price_change_percentage_24h') double get priceChangePercentage24h;@JsonKey(name: 'total_volume') double get totalVolume;
/// Create a copy of CoinModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinModelCopyWith<CoinModel> get copyWith => _$CoinModelCopyWithImpl<CoinModel>(this as CoinModel, _$identity);

  /// Serializes this CoinModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinModel&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.marketCapRank, marketCapRank) || other.marketCapRank == marketCapRank)&&(identical(other.priceChangePercentage24h, priceChangePercentage24h) || other.priceChangePercentage24h == priceChangePercentage24h)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,symbol,name,image,currentPrice,marketCap,marketCapRank,priceChangePercentage24h,totalVolume);

@override
String toString() {
  return 'CoinModel(id: $id, symbol: $symbol, name: $name, image: $image, currentPrice: $currentPrice, marketCap: $marketCap, marketCapRank: $marketCapRank, priceChangePercentage24h: $priceChangePercentage24h, totalVolume: $totalVolume)';
}


}

/// @nodoc
abstract mixin class $CoinModelCopyWith<$Res>  {
  factory $CoinModelCopyWith(CoinModel value, $Res Function(CoinModel) _then) = _$CoinModelCopyWithImpl;
@useResult
$Res call({
 String id, String symbol, String name, String image,@JsonKey(name: 'current_price') double currentPrice,@JsonKey(name: 'market_cap') double marketCap,@JsonKey(name: 'market_cap_rank') int marketCapRank,@JsonKey(name: 'price_change_percentage_24h') double priceChangePercentage24h,@JsonKey(name: 'total_volume') double totalVolume
});




}
/// @nodoc
class _$CoinModelCopyWithImpl<$Res>
    implements $CoinModelCopyWith<$Res> {
  _$CoinModelCopyWithImpl(this._self, this._then);

  final CoinModel _self;
  final $Res Function(CoinModel) _then;

/// Create a copy of CoinModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? symbol = null,Object? name = null,Object? image = null,Object? currentPrice = null,Object? marketCap = null,Object? marketCapRank = null,Object? priceChangePercentage24h = null,Object? totalVolume = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as double,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double,marketCapRank: null == marketCapRank ? _self.marketCapRank : marketCapRank // ignore: cast_nullable_to_non_nullable
as int,priceChangePercentage24h: null == priceChangePercentage24h ? _self.priceChangePercentage24h : priceChangePercentage24h // ignore: cast_nullable_to_non_nullable
as double,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CoinModel].
extension CoinModelPatterns on CoinModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoinModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoinModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoinModel value)  $default,){
final _that = this;
switch (_that) {
case _CoinModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoinModel value)?  $default,){
final _that = this;
switch (_that) {
case _CoinModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String symbol,  String name,  String image, @JsonKey(name: 'current_price')  double currentPrice, @JsonKey(name: 'market_cap')  double marketCap, @JsonKey(name: 'market_cap_rank')  int marketCapRank, @JsonKey(name: 'price_change_percentage_24h')  double priceChangePercentage24h, @JsonKey(name: 'total_volume')  double totalVolume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoinModel() when $default != null:
return $default(_that.id,_that.symbol,_that.name,_that.image,_that.currentPrice,_that.marketCap,_that.marketCapRank,_that.priceChangePercentage24h,_that.totalVolume);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String symbol,  String name,  String image, @JsonKey(name: 'current_price')  double currentPrice, @JsonKey(name: 'market_cap')  double marketCap, @JsonKey(name: 'market_cap_rank')  int marketCapRank, @JsonKey(name: 'price_change_percentage_24h')  double priceChangePercentage24h, @JsonKey(name: 'total_volume')  double totalVolume)  $default,) {final _that = this;
switch (_that) {
case _CoinModel():
return $default(_that.id,_that.symbol,_that.name,_that.image,_that.currentPrice,_that.marketCap,_that.marketCapRank,_that.priceChangePercentage24h,_that.totalVolume);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String symbol,  String name,  String image, @JsonKey(name: 'current_price')  double currentPrice, @JsonKey(name: 'market_cap')  double marketCap, @JsonKey(name: 'market_cap_rank')  int marketCapRank, @JsonKey(name: 'price_change_percentage_24h')  double priceChangePercentage24h, @JsonKey(name: 'total_volume')  double totalVolume)?  $default,) {final _that = this;
switch (_that) {
case _CoinModel() when $default != null:
return $default(_that.id,_that.symbol,_that.name,_that.image,_that.currentPrice,_that.marketCap,_that.marketCapRank,_that.priceChangePercentage24h,_that.totalVolume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoinModel implements CoinModel {
  const _CoinModel({required this.id, required this.symbol, required this.name, this.image = '', @JsonKey(name: 'current_price') this.currentPrice = 0.0, @JsonKey(name: 'market_cap') this.marketCap = 0.0, @JsonKey(name: 'market_cap_rank') this.marketCapRank = 0, @JsonKey(name: 'price_change_percentage_24h') this.priceChangePercentage24h = 0.0, @JsonKey(name: 'total_volume') this.totalVolume = 0.0});
  factory _CoinModel.fromJson(Map<String, dynamic> json) => _$CoinModelFromJson(json);

@override final  String id;
@override final  String symbol;
@override final  String name;
@override@JsonKey() final  String image;
@override@JsonKey(name: 'current_price') final  double currentPrice;
@override@JsonKey(name: 'market_cap') final  double marketCap;
@override@JsonKey(name: 'market_cap_rank') final  int marketCapRank;
@override@JsonKey(name: 'price_change_percentage_24h') final  double priceChangePercentage24h;
@override@JsonKey(name: 'total_volume') final  double totalVolume;

/// Create a copy of CoinModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoinModelCopyWith<_CoinModel> get copyWith => __$CoinModelCopyWithImpl<_CoinModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoinModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoinModel&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.currentPrice, currentPrice) || other.currentPrice == currentPrice)&&(identical(other.marketCap, marketCap) || other.marketCap == marketCap)&&(identical(other.marketCapRank, marketCapRank) || other.marketCapRank == marketCapRank)&&(identical(other.priceChangePercentage24h, priceChangePercentage24h) || other.priceChangePercentage24h == priceChangePercentage24h)&&(identical(other.totalVolume, totalVolume) || other.totalVolume == totalVolume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,symbol,name,image,currentPrice,marketCap,marketCapRank,priceChangePercentage24h,totalVolume);

@override
String toString() {
  return 'CoinModel(id: $id, symbol: $symbol, name: $name, image: $image, currentPrice: $currentPrice, marketCap: $marketCap, marketCapRank: $marketCapRank, priceChangePercentage24h: $priceChangePercentage24h, totalVolume: $totalVolume)';
}


}

/// @nodoc
abstract mixin class _$CoinModelCopyWith<$Res> implements $CoinModelCopyWith<$Res> {
  factory _$CoinModelCopyWith(_CoinModel value, $Res Function(_CoinModel) _then) = __$CoinModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String symbol, String name, String image,@JsonKey(name: 'current_price') double currentPrice,@JsonKey(name: 'market_cap') double marketCap,@JsonKey(name: 'market_cap_rank') int marketCapRank,@JsonKey(name: 'price_change_percentage_24h') double priceChangePercentage24h,@JsonKey(name: 'total_volume') double totalVolume
});




}
/// @nodoc
class __$CoinModelCopyWithImpl<$Res>
    implements _$CoinModelCopyWith<$Res> {
  __$CoinModelCopyWithImpl(this._self, this._then);

  final _CoinModel _self;
  final $Res Function(_CoinModel) _then;

/// Create a copy of CoinModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? symbol = null,Object? name = null,Object? image = null,Object? currentPrice = null,Object? marketCap = null,Object? marketCapRank = null,Object? priceChangePercentage24h = null,Object? totalVolume = null,}) {
  return _then(_CoinModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as double,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as double,marketCapRank: null == marketCapRank ? _self.marketCapRank : marketCapRank // ignore: cast_nullable_to_non_nullable
as int,priceChangePercentage24h: null == priceChangePercentage24h ? _self.priceChangePercentage24h : priceChangePercentage24h // ignore: cast_nullable_to_non_nullable
as double,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
