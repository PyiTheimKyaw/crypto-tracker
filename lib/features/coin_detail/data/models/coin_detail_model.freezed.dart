// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coin_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoinDetailImageModel {

 String get thumb; String get small; String get large;
/// Create a copy of CoinDetailImageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinDetailImageModelCopyWith<CoinDetailImageModel> get copyWith => _$CoinDetailImageModelCopyWithImpl<CoinDetailImageModel>(this as CoinDetailImageModel, _$identity);

  /// Serializes this CoinDetailImageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinDetailImageModel&&(identical(other.thumb, thumb) || other.thumb == thumb)&&(identical(other.small, small) || other.small == small)&&(identical(other.large, large) || other.large == large));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,thumb,small,large);

@override
String toString() {
  return 'CoinDetailImageModel(thumb: $thumb, small: $small, large: $large)';
}


}

/// @nodoc
abstract mixin class $CoinDetailImageModelCopyWith<$Res>  {
  factory $CoinDetailImageModelCopyWith(CoinDetailImageModel value, $Res Function(CoinDetailImageModel) _then) = _$CoinDetailImageModelCopyWithImpl;
@useResult
$Res call({
 String thumb, String small, String large
});




}
/// @nodoc
class _$CoinDetailImageModelCopyWithImpl<$Res>
    implements $CoinDetailImageModelCopyWith<$Res> {
  _$CoinDetailImageModelCopyWithImpl(this._self, this._then);

  final CoinDetailImageModel _self;
  final $Res Function(CoinDetailImageModel) _then;

/// Create a copy of CoinDetailImageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? thumb = null,Object? small = null,Object? large = null,}) {
  return _then(_self.copyWith(
thumb: null == thumb ? _self.thumb : thumb // ignore: cast_nullable_to_non_nullable
as String,small: null == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String,large: null == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CoinDetailImageModel].
extension CoinDetailImageModelPatterns on CoinDetailImageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoinDetailImageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoinDetailImageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoinDetailImageModel value)  $default,){
final _that = this;
switch (_that) {
case _CoinDetailImageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoinDetailImageModel value)?  $default,){
final _that = this;
switch (_that) {
case _CoinDetailImageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String thumb,  String small,  String large)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoinDetailImageModel() when $default != null:
return $default(_that.thumb,_that.small,_that.large);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String thumb,  String small,  String large)  $default,) {final _that = this;
switch (_that) {
case _CoinDetailImageModel():
return $default(_that.thumb,_that.small,_that.large);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String thumb,  String small,  String large)?  $default,) {final _that = this;
switch (_that) {
case _CoinDetailImageModel() when $default != null:
return $default(_that.thumb,_that.small,_that.large);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoinDetailImageModel implements CoinDetailImageModel {
  const _CoinDetailImageModel({this.thumb = '', this.small = '', this.large = ''});
  factory _CoinDetailImageModel.fromJson(Map<String, dynamic> json) => _$CoinDetailImageModelFromJson(json);

@override@JsonKey() final  String thumb;
@override@JsonKey() final  String small;
@override@JsonKey() final  String large;

/// Create a copy of CoinDetailImageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoinDetailImageModelCopyWith<_CoinDetailImageModel> get copyWith => __$CoinDetailImageModelCopyWithImpl<_CoinDetailImageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoinDetailImageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoinDetailImageModel&&(identical(other.thumb, thumb) || other.thumb == thumb)&&(identical(other.small, small) || other.small == small)&&(identical(other.large, large) || other.large == large));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,thumb,small,large);

@override
String toString() {
  return 'CoinDetailImageModel(thumb: $thumb, small: $small, large: $large)';
}


}

/// @nodoc
abstract mixin class _$CoinDetailImageModelCopyWith<$Res> implements $CoinDetailImageModelCopyWith<$Res> {
  factory _$CoinDetailImageModelCopyWith(_CoinDetailImageModel value, $Res Function(_CoinDetailImageModel) _then) = __$CoinDetailImageModelCopyWithImpl;
@override @useResult
$Res call({
 String thumb, String small, String large
});




}
/// @nodoc
class __$CoinDetailImageModelCopyWithImpl<$Res>
    implements _$CoinDetailImageModelCopyWith<$Res> {
  __$CoinDetailImageModelCopyWithImpl(this._self, this._then);

  final _CoinDetailImageModel _self;
  final $Res Function(_CoinDetailImageModel) _then;

/// Create a copy of CoinDetailImageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? thumb = null,Object? small = null,Object? large = null,}) {
  return _then(_CoinDetailImageModel(
thumb: null == thumb ? _self.thumb : thumb // ignore: cast_nullable_to_non_nullable
as String,small: null == small ? _self.small : small // ignore: cast_nullable_to_non_nullable
as String,large: null == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CoinDetailDescriptionModel {

 String get en;
/// Create a copy of CoinDetailDescriptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinDetailDescriptionModelCopyWith<CoinDetailDescriptionModel> get copyWith => _$CoinDetailDescriptionModelCopyWithImpl<CoinDetailDescriptionModel>(this as CoinDetailDescriptionModel, _$identity);

  /// Serializes this CoinDetailDescriptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinDetailDescriptionModel&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,en);

@override
String toString() {
  return 'CoinDetailDescriptionModel(en: $en)';
}


}

/// @nodoc
abstract mixin class $CoinDetailDescriptionModelCopyWith<$Res>  {
  factory $CoinDetailDescriptionModelCopyWith(CoinDetailDescriptionModel value, $Res Function(CoinDetailDescriptionModel) _then) = _$CoinDetailDescriptionModelCopyWithImpl;
@useResult
$Res call({
 String en
});




}
/// @nodoc
class _$CoinDetailDescriptionModelCopyWithImpl<$Res>
    implements $CoinDetailDescriptionModelCopyWith<$Res> {
  _$CoinDetailDescriptionModelCopyWithImpl(this._self, this._then);

  final CoinDetailDescriptionModel _self;
  final $Res Function(CoinDetailDescriptionModel) _then;

/// Create a copy of CoinDetailDescriptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? en = null,}) {
  return _then(_self.copyWith(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CoinDetailDescriptionModel].
extension CoinDetailDescriptionModelPatterns on CoinDetailDescriptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoinDetailDescriptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoinDetailDescriptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoinDetailDescriptionModel value)  $default,){
final _that = this;
switch (_that) {
case _CoinDetailDescriptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoinDetailDescriptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _CoinDetailDescriptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String en)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoinDetailDescriptionModel() when $default != null:
return $default(_that.en);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String en)  $default,) {final _that = this;
switch (_that) {
case _CoinDetailDescriptionModel():
return $default(_that.en);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String en)?  $default,) {final _that = this;
switch (_that) {
case _CoinDetailDescriptionModel() when $default != null:
return $default(_that.en);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoinDetailDescriptionModel implements CoinDetailDescriptionModel {
  const _CoinDetailDescriptionModel({this.en = ''});
  factory _CoinDetailDescriptionModel.fromJson(Map<String, dynamic> json) => _$CoinDetailDescriptionModelFromJson(json);

@override@JsonKey() final  String en;

/// Create a copy of CoinDetailDescriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoinDetailDescriptionModelCopyWith<_CoinDetailDescriptionModel> get copyWith => __$CoinDetailDescriptionModelCopyWithImpl<_CoinDetailDescriptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoinDetailDescriptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoinDetailDescriptionModel&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,en);

@override
String toString() {
  return 'CoinDetailDescriptionModel(en: $en)';
}


}

/// @nodoc
abstract mixin class _$CoinDetailDescriptionModelCopyWith<$Res> implements $CoinDetailDescriptionModelCopyWith<$Res> {
  factory _$CoinDetailDescriptionModelCopyWith(_CoinDetailDescriptionModel value, $Res Function(_CoinDetailDescriptionModel) _then) = __$CoinDetailDescriptionModelCopyWithImpl;
@override @useResult
$Res call({
 String en
});




}
/// @nodoc
class __$CoinDetailDescriptionModelCopyWithImpl<$Res>
    implements _$CoinDetailDescriptionModelCopyWith<$Res> {
  __$CoinDetailDescriptionModelCopyWithImpl(this._self, this._then);

  final _CoinDetailDescriptionModel _self;
  final $Res Function(_CoinDetailDescriptionModel) _then;

/// Create a copy of CoinDetailDescriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? en = null,}) {
  return _then(_CoinDetailDescriptionModel(
en: null == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CoinDetailMarketDataModel {

@JsonKey(name: 'current_price') Map<String, double> get currentPrice;@JsonKey(name: 'market_cap') Map<String, double> get marketCap;@JsonKey(name: 'total_volume') Map<String, double> get totalVolume; Map<String, double> get ath;@JsonKey(name: 'ath_change_percentage') Map<String, double> get athChangePercentage; Map<String, double> get atl;@JsonKey(name: 'atl_change_percentage') Map<String, double> get atlChangePercentage;@JsonKey(name: 'price_change_percentage_24h') double get priceChangePercentage24h;@JsonKey(name: 'circulating_supply') double get circulatingSupply;@JsonKey(name: 'total_supply') double? get totalSupply;@JsonKey(name: 'max_supply') double? get maxSupply;
/// Create a copy of CoinDetailMarketDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinDetailMarketDataModelCopyWith<CoinDetailMarketDataModel> get copyWith => _$CoinDetailMarketDataModelCopyWithImpl<CoinDetailMarketDataModel>(this as CoinDetailMarketDataModel, _$identity);

  /// Serializes this CoinDetailMarketDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinDetailMarketDataModel&&const DeepCollectionEquality().equals(other.currentPrice, currentPrice)&&const DeepCollectionEquality().equals(other.marketCap, marketCap)&&const DeepCollectionEquality().equals(other.totalVolume, totalVolume)&&const DeepCollectionEquality().equals(other.ath, ath)&&const DeepCollectionEquality().equals(other.athChangePercentage, athChangePercentage)&&const DeepCollectionEquality().equals(other.atl, atl)&&const DeepCollectionEquality().equals(other.atlChangePercentage, atlChangePercentage)&&(identical(other.priceChangePercentage24h, priceChangePercentage24h) || other.priceChangePercentage24h == priceChangePercentage24h)&&(identical(other.circulatingSupply, circulatingSupply) || other.circulatingSupply == circulatingSupply)&&(identical(other.totalSupply, totalSupply) || other.totalSupply == totalSupply)&&(identical(other.maxSupply, maxSupply) || other.maxSupply == maxSupply));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(currentPrice),const DeepCollectionEquality().hash(marketCap),const DeepCollectionEquality().hash(totalVolume),const DeepCollectionEquality().hash(ath),const DeepCollectionEquality().hash(athChangePercentage),const DeepCollectionEquality().hash(atl),const DeepCollectionEquality().hash(atlChangePercentage),priceChangePercentage24h,circulatingSupply,totalSupply,maxSupply);

@override
String toString() {
  return 'CoinDetailMarketDataModel(currentPrice: $currentPrice, marketCap: $marketCap, totalVolume: $totalVolume, ath: $ath, athChangePercentage: $athChangePercentage, atl: $atl, atlChangePercentage: $atlChangePercentage, priceChangePercentage24h: $priceChangePercentage24h, circulatingSupply: $circulatingSupply, totalSupply: $totalSupply, maxSupply: $maxSupply)';
}


}

/// @nodoc
abstract mixin class $CoinDetailMarketDataModelCopyWith<$Res>  {
  factory $CoinDetailMarketDataModelCopyWith(CoinDetailMarketDataModel value, $Res Function(CoinDetailMarketDataModel) _then) = _$CoinDetailMarketDataModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'current_price') Map<String, double> currentPrice,@JsonKey(name: 'market_cap') Map<String, double> marketCap,@JsonKey(name: 'total_volume') Map<String, double> totalVolume, Map<String, double> ath,@JsonKey(name: 'ath_change_percentage') Map<String, double> athChangePercentage, Map<String, double> atl,@JsonKey(name: 'atl_change_percentage') Map<String, double> atlChangePercentage,@JsonKey(name: 'price_change_percentage_24h') double priceChangePercentage24h,@JsonKey(name: 'circulating_supply') double circulatingSupply,@JsonKey(name: 'total_supply') double? totalSupply,@JsonKey(name: 'max_supply') double? maxSupply
});




}
/// @nodoc
class _$CoinDetailMarketDataModelCopyWithImpl<$Res>
    implements $CoinDetailMarketDataModelCopyWith<$Res> {
  _$CoinDetailMarketDataModelCopyWithImpl(this._self, this._then);

  final CoinDetailMarketDataModel _self;
  final $Res Function(CoinDetailMarketDataModel) _then;

/// Create a copy of CoinDetailMarketDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPrice = null,Object? marketCap = null,Object? totalVolume = null,Object? ath = null,Object? athChangePercentage = null,Object? atl = null,Object? atlChangePercentage = null,Object? priceChangePercentage24h = null,Object? circulatingSupply = null,Object? totalSupply = freezed,Object? maxSupply = freezed,}) {
  return _then(_self.copyWith(
currentPrice: null == currentPrice ? _self.currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as Map<String, double>,marketCap: null == marketCap ? _self.marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as Map<String, double>,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as Map<String, double>,ath: null == ath ? _self.ath : ath // ignore: cast_nullable_to_non_nullable
as Map<String, double>,athChangePercentage: null == athChangePercentage ? _self.athChangePercentage : athChangePercentage // ignore: cast_nullable_to_non_nullable
as Map<String, double>,atl: null == atl ? _self.atl : atl // ignore: cast_nullable_to_non_nullable
as Map<String, double>,atlChangePercentage: null == atlChangePercentage ? _self.atlChangePercentage : atlChangePercentage // ignore: cast_nullable_to_non_nullable
as Map<String, double>,priceChangePercentage24h: null == priceChangePercentage24h ? _self.priceChangePercentage24h : priceChangePercentage24h // ignore: cast_nullable_to_non_nullable
as double,circulatingSupply: null == circulatingSupply ? _self.circulatingSupply : circulatingSupply // ignore: cast_nullable_to_non_nullable
as double,totalSupply: freezed == totalSupply ? _self.totalSupply : totalSupply // ignore: cast_nullable_to_non_nullable
as double?,maxSupply: freezed == maxSupply ? _self.maxSupply : maxSupply // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoinDetailMarketDataModel].
extension CoinDetailMarketDataModelPatterns on CoinDetailMarketDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoinDetailMarketDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoinDetailMarketDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoinDetailMarketDataModel value)  $default,){
final _that = this;
switch (_that) {
case _CoinDetailMarketDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoinDetailMarketDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _CoinDetailMarketDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_price')  Map<String, double> currentPrice, @JsonKey(name: 'market_cap')  Map<String, double> marketCap, @JsonKey(name: 'total_volume')  Map<String, double> totalVolume,  Map<String, double> ath, @JsonKey(name: 'ath_change_percentage')  Map<String, double> athChangePercentage,  Map<String, double> atl, @JsonKey(name: 'atl_change_percentage')  Map<String, double> atlChangePercentage, @JsonKey(name: 'price_change_percentage_24h')  double priceChangePercentage24h, @JsonKey(name: 'circulating_supply')  double circulatingSupply, @JsonKey(name: 'total_supply')  double? totalSupply, @JsonKey(name: 'max_supply')  double? maxSupply)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoinDetailMarketDataModel() when $default != null:
return $default(_that.currentPrice,_that.marketCap,_that.totalVolume,_that.ath,_that.athChangePercentage,_that.atl,_that.atlChangePercentage,_that.priceChangePercentage24h,_that.circulatingSupply,_that.totalSupply,_that.maxSupply);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'current_price')  Map<String, double> currentPrice, @JsonKey(name: 'market_cap')  Map<String, double> marketCap, @JsonKey(name: 'total_volume')  Map<String, double> totalVolume,  Map<String, double> ath, @JsonKey(name: 'ath_change_percentage')  Map<String, double> athChangePercentage,  Map<String, double> atl, @JsonKey(name: 'atl_change_percentage')  Map<String, double> atlChangePercentage, @JsonKey(name: 'price_change_percentage_24h')  double priceChangePercentage24h, @JsonKey(name: 'circulating_supply')  double circulatingSupply, @JsonKey(name: 'total_supply')  double? totalSupply, @JsonKey(name: 'max_supply')  double? maxSupply)  $default,) {final _that = this;
switch (_that) {
case _CoinDetailMarketDataModel():
return $default(_that.currentPrice,_that.marketCap,_that.totalVolume,_that.ath,_that.athChangePercentage,_that.atl,_that.atlChangePercentage,_that.priceChangePercentage24h,_that.circulatingSupply,_that.totalSupply,_that.maxSupply);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'current_price')  Map<String, double> currentPrice, @JsonKey(name: 'market_cap')  Map<String, double> marketCap, @JsonKey(name: 'total_volume')  Map<String, double> totalVolume,  Map<String, double> ath, @JsonKey(name: 'ath_change_percentage')  Map<String, double> athChangePercentage,  Map<String, double> atl, @JsonKey(name: 'atl_change_percentage')  Map<String, double> atlChangePercentage, @JsonKey(name: 'price_change_percentage_24h')  double priceChangePercentage24h, @JsonKey(name: 'circulating_supply')  double circulatingSupply, @JsonKey(name: 'total_supply')  double? totalSupply, @JsonKey(name: 'max_supply')  double? maxSupply)?  $default,) {final _that = this;
switch (_that) {
case _CoinDetailMarketDataModel() when $default != null:
return $default(_that.currentPrice,_that.marketCap,_that.totalVolume,_that.ath,_that.athChangePercentage,_that.atl,_that.atlChangePercentage,_that.priceChangePercentage24h,_that.circulatingSupply,_that.totalSupply,_that.maxSupply);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoinDetailMarketDataModel implements CoinDetailMarketDataModel {
  const _CoinDetailMarketDataModel({@JsonKey(name: 'current_price') final  Map<String, double> currentPrice = const <String, double>{}, @JsonKey(name: 'market_cap') final  Map<String, double> marketCap = const <String, double>{}, @JsonKey(name: 'total_volume') final  Map<String, double> totalVolume = const <String, double>{}, final  Map<String, double> ath = const <String, double>{}, @JsonKey(name: 'ath_change_percentage') final  Map<String, double> athChangePercentage = const <String, double>{}, final  Map<String, double> atl = const <String, double>{}, @JsonKey(name: 'atl_change_percentage') final  Map<String, double> atlChangePercentage = const <String, double>{}, @JsonKey(name: 'price_change_percentage_24h') this.priceChangePercentage24h = 0.0, @JsonKey(name: 'circulating_supply') this.circulatingSupply = 0.0, @JsonKey(name: 'total_supply') this.totalSupply, @JsonKey(name: 'max_supply') this.maxSupply}): _currentPrice = currentPrice,_marketCap = marketCap,_totalVolume = totalVolume,_ath = ath,_athChangePercentage = athChangePercentage,_atl = atl,_atlChangePercentage = atlChangePercentage;
  factory _CoinDetailMarketDataModel.fromJson(Map<String, dynamic> json) => _$CoinDetailMarketDataModelFromJson(json);

 final  Map<String, double> _currentPrice;
@override@JsonKey(name: 'current_price') Map<String, double> get currentPrice {
  if (_currentPrice is EqualUnmodifiableMapView) return _currentPrice;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_currentPrice);
}

 final  Map<String, double> _marketCap;
@override@JsonKey(name: 'market_cap') Map<String, double> get marketCap {
  if (_marketCap is EqualUnmodifiableMapView) return _marketCap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_marketCap);
}

 final  Map<String, double> _totalVolume;
@override@JsonKey(name: 'total_volume') Map<String, double> get totalVolume {
  if (_totalVolume is EqualUnmodifiableMapView) return _totalVolume;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_totalVolume);
}

 final  Map<String, double> _ath;
@override@JsonKey() Map<String, double> get ath {
  if (_ath is EqualUnmodifiableMapView) return _ath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ath);
}

 final  Map<String, double> _athChangePercentage;
@override@JsonKey(name: 'ath_change_percentage') Map<String, double> get athChangePercentage {
  if (_athChangePercentage is EqualUnmodifiableMapView) return _athChangePercentage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_athChangePercentage);
}

 final  Map<String, double> _atl;
@override@JsonKey() Map<String, double> get atl {
  if (_atl is EqualUnmodifiableMapView) return _atl;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_atl);
}

 final  Map<String, double> _atlChangePercentage;
@override@JsonKey(name: 'atl_change_percentage') Map<String, double> get atlChangePercentage {
  if (_atlChangePercentage is EqualUnmodifiableMapView) return _atlChangePercentage;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_atlChangePercentage);
}

@override@JsonKey(name: 'price_change_percentage_24h') final  double priceChangePercentage24h;
@override@JsonKey(name: 'circulating_supply') final  double circulatingSupply;
@override@JsonKey(name: 'total_supply') final  double? totalSupply;
@override@JsonKey(name: 'max_supply') final  double? maxSupply;

/// Create a copy of CoinDetailMarketDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoinDetailMarketDataModelCopyWith<_CoinDetailMarketDataModel> get copyWith => __$CoinDetailMarketDataModelCopyWithImpl<_CoinDetailMarketDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoinDetailMarketDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoinDetailMarketDataModel&&const DeepCollectionEquality().equals(other._currentPrice, _currentPrice)&&const DeepCollectionEquality().equals(other._marketCap, _marketCap)&&const DeepCollectionEquality().equals(other._totalVolume, _totalVolume)&&const DeepCollectionEquality().equals(other._ath, _ath)&&const DeepCollectionEquality().equals(other._athChangePercentage, _athChangePercentage)&&const DeepCollectionEquality().equals(other._atl, _atl)&&const DeepCollectionEquality().equals(other._atlChangePercentage, _atlChangePercentage)&&(identical(other.priceChangePercentage24h, priceChangePercentage24h) || other.priceChangePercentage24h == priceChangePercentage24h)&&(identical(other.circulatingSupply, circulatingSupply) || other.circulatingSupply == circulatingSupply)&&(identical(other.totalSupply, totalSupply) || other.totalSupply == totalSupply)&&(identical(other.maxSupply, maxSupply) || other.maxSupply == maxSupply));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_currentPrice),const DeepCollectionEquality().hash(_marketCap),const DeepCollectionEquality().hash(_totalVolume),const DeepCollectionEquality().hash(_ath),const DeepCollectionEquality().hash(_athChangePercentage),const DeepCollectionEquality().hash(_atl),const DeepCollectionEquality().hash(_atlChangePercentage),priceChangePercentage24h,circulatingSupply,totalSupply,maxSupply);

@override
String toString() {
  return 'CoinDetailMarketDataModel(currentPrice: $currentPrice, marketCap: $marketCap, totalVolume: $totalVolume, ath: $ath, athChangePercentage: $athChangePercentage, atl: $atl, atlChangePercentage: $atlChangePercentage, priceChangePercentage24h: $priceChangePercentage24h, circulatingSupply: $circulatingSupply, totalSupply: $totalSupply, maxSupply: $maxSupply)';
}


}

/// @nodoc
abstract mixin class _$CoinDetailMarketDataModelCopyWith<$Res> implements $CoinDetailMarketDataModelCopyWith<$Res> {
  factory _$CoinDetailMarketDataModelCopyWith(_CoinDetailMarketDataModel value, $Res Function(_CoinDetailMarketDataModel) _then) = __$CoinDetailMarketDataModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'current_price') Map<String, double> currentPrice,@JsonKey(name: 'market_cap') Map<String, double> marketCap,@JsonKey(name: 'total_volume') Map<String, double> totalVolume, Map<String, double> ath,@JsonKey(name: 'ath_change_percentage') Map<String, double> athChangePercentage, Map<String, double> atl,@JsonKey(name: 'atl_change_percentage') Map<String, double> atlChangePercentage,@JsonKey(name: 'price_change_percentage_24h') double priceChangePercentage24h,@JsonKey(name: 'circulating_supply') double circulatingSupply,@JsonKey(name: 'total_supply') double? totalSupply,@JsonKey(name: 'max_supply') double? maxSupply
});




}
/// @nodoc
class __$CoinDetailMarketDataModelCopyWithImpl<$Res>
    implements _$CoinDetailMarketDataModelCopyWith<$Res> {
  __$CoinDetailMarketDataModelCopyWithImpl(this._self, this._then);

  final _CoinDetailMarketDataModel _self;
  final $Res Function(_CoinDetailMarketDataModel) _then;

/// Create a copy of CoinDetailMarketDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPrice = null,Object? marketCap = null,Object? totalVolume = null,Object? ath = null,Object? athChangePercentage = null,Object? atl = null,Object? atlChangePercentage = null,Object? priceChangePercentage24h = null,Object? circulatingSupply = null,Object? totalSupply = freezed,Object? maxSupply = freezed,}) {
  return _then(_CoinDetailMarketDataModel(
currentPrice: null == currentPrice ? _self._currentPrice : currentPrice // ignore: cast_nullable_to_non_nullable
as Map<String, double>,marketCap: null == marketCap ? _self._marketCap : marketCap // ignore: cast_nullable_to_non_nullable
as Map<String, double>,totalVolume: null == totalVolume ? _self._totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as Map<String, double>,ath: null == ath ? _self._ath : ath // ignore: cast_nullable_to_non_nullable
as Map<String, double>,athChangePercentage: null == athChangePercentage ? _self._athChangePercentage : athChangePercentage // ignore: cast_nullable_to_non_nullable
as Map<String, double>,atl: null == atl ? _self._atl : atl // ignore: cast_nullable_to_non_nullable
as Map<String, double>,atlChangePercentage: null == atlChangePercentage ? _self._atlChangePercentage : atlChangePercentage // ignore: cast_nullable_to_non_nullable
as Map<String, double>,priceChangePercentage24h: null == priceChangePercentage24h ? _self.priceChangePercentage24h : priceChangePercentage24h // ignore: cast_nullable_to_non_nullable
as double,circulatingSupply: null == circulatingSupply ? _self.circulatingSupply : circulatingSupply // ignore: cast_nullable_to_non_nullable
as double,totalSupply: freezed == totalSupply ? _self.totalSupply : totalSupply // ignore: cast_nullable_to_non_nullable
as double?,maxSupply: freezed == maxSupply ? _self.maxSupply : maxSupply // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$CoinDetailModel {

 String get id; String get symbol; String get name;@JsonKey(name: 'market_cap_rank') int get marketCapRank; CoinDetailImageModel? get image; CoinDetailDescriptionModel? get description;@JsonKey(name: 'market_data') CoinDetailMarketDataModel? get marketData;
/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoinDetailModelCopyWith<CoinDetailModel> get copyWith => _$CoinDetailModelCopyWithImpl<CoinDetailModel>(this as CoinDetailModel, _$identity);

  /// Serializes this CoinDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoinDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.marketCapRank, marketCapRank) || other.marketCapRank == marketCapRank)&&(identical(other.image, image) || other.image == image)&&(identical(other.description, description) || other.description == description)&&(identical(other.marketData, marketData) || other.marketData == marketData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,symbol,name,marketCapRank,image,description,marketData);

@override
String toString() {
  return 'CoinDetailModel(id: $id, symbol: $symbol, name: $name, marketCapRank: $marketCapRank, image: $image, description: $description, marketData: $marketData)';
}


}

/// @nodoc
abstract mixin class $CoinDetailModelCopyWith<$Res>  {
  factory $CoinDetailModelCopyWith(CoinDetailModel value, $Res Function(CoinDetailModel) _then) = _$CoinDetailModelCopyWithImpl;
@useResult
$Res call({
 String id, String symbol, String name,@JsonKey(name: 'market_cap_rank') int marketCapRank, CoinDetailImageModel? image, CoinDetailDescriptionModel? description,@JsonKey(name: 'market_data') CoinDetailMarketDataModel? marketData
});


$CoinDetailImageModelCopyWith<$Res>? get image;$CoinDetailDescriptionModelCopyWith<$Res>? get description;$CoinDetailMarketDataModelCopyWith<$Res>? get marketData;

}
/// @nodoc
class _$CoinDetailModelCopyWithImpl<$Res>
    implements $CoinDetailModelCopyWith<$Res> {
  _$CoinDetailModelCopyWithImpl(this._self, this._then);

  final CoinDetailModel _self;
  final $Res Function(CoinDetailModel) _then;

/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? symbol = null,Object? name = null,Object? marketCapRank = null,Object? image = freezed,Object? description = freezed,Object? marketData = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,marketCapRank: null == marketCapRank ? _self.marketCapRank : marketCapRank // ignore: cast_nullable_to_non_nullable
as int,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as CoinDetailImageModel?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as CoinDetailDescriptionModel?,marketData: freezed == marketData ? _self.marketData : marketData // ignore: cast_nullable_to_non_nullable
as CoinDetailMarketDataModel?,
  ));
}
/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoinDetailImageModelCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $CoinDetailImageModelCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoinDetailDescriptionModelCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $CoinDetailDescriptionModelCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoinDetailMarketDataModelCopyWith<$Res>? get marketData {
    if (_self.marketData == null) {
    return null;
  }

  return $CoinDetailMarketDataModelCopyWith<$Res>(_self.marketData!, (value) {
    return _then(_self.copyWith(marketData: value));
  });
}
}


/// Adds pattern-matching-related methods to [CoinDetailModel].
extension CoinDetailModelPatterns on CoinDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoinDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoinDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoinDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _CoinDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoinDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _CoinDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String symbol,  String name, @JsonKey(name: 'market_cap_rank')  int marketCapRank,  CoinDetailImageModel? image,  CoinDetailDescriptionModel? description, @JsonKey(name: 'market_data')  CoinDetailMarketDataModel? marketData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoinDetailModel() when $default != null:
return $default(_that.id,_that.symbol,_that.name,_that.marketCapRank,_that.image,_that.description,_that.marketData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String symbol,  String name, @JsonKey(name: 'market_cap_rank')  int marketCapRank,  CoinDetailImageModel? image,  CoinDetailDescriptionModel? description, @JsonKey(name: 'market_data')  CoinDetailMarketDataModel? marketData)  $default,) {final _that = this;
switch (_that) {
case _CoinDetailModel():
return $default(_that.id,_that.symbol,_that.name,_that.marketCapRank,_that.image,_that.description,_that.marketData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String symbol,  String name, @JsonKey(name: 'market_cap_rank')  int marketCapRank,  CoinDetailImageModel? image,  CoinDetailDescriptionModel? description, @JsonKey(name: 'market_data')  CoinDetailMarketDataModel? marketData)?  $default,) {final _that = this;
switch (_that) {
case _CoinDetailModel() when $default != null:
return $default(_that.id,_that.symbol,_that.name,_that.marketCapRank,_that.image,_that.description,_that.marketData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CoinDetailModel implements CoinDetailModel {
  const _CoinDetailModel({required this.id, required this.symbol, required this.name, @JsonKey(name: 'market_cap_rank') this.marketCapRank = 0, this.image, this.description, @JsonKey(name: 'market_data') this.marketData});
  factory _CoinDetailModel.fromJson(Map<String, dynamic> json) => _$CoinDetailModelFromJson(json);

@override final  String id;
@override final  String symbol;
@override final  String name;
@override@JsonKey(name: 'market_cap_rank') final  int marketCapRank;
@override final  CoinDetailImageModel? image;
@override final  CoinDetailDescriptionModel? description;
@override@JsonKey(name: 'market_data') final  CoinDetailMarketDataModel? marketData;

/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoinDetailModelCopyWith<_CoinDetailModel> get copyWith => __$CoinDetailModelCopyWithImpl<_CoinDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoinDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoinDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.name, name) || other.name == name)&&(identical(other.marketCapRank, marketCapRank) || other.marketCapRank == marketCapRank)&&(identical(other.image, image) || other.image == image)&&(identical(other.description, description) || other.description == description)&&(identical(other.marketData, marketData) || other.marketData == marketData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,symbol,name,marketCapRank,image,description,marketData);

@override
String toString() {
  return 'CoinDetailModel(id: $id, symbol: $symbol, name: $name, marketCapRank: $marketCapRank, image: $image, description: $description, marketData: $marketData)';
}


}

/// @nodoc
abstract mixin class _$CoinDetailModelCopyWith<$Res> implements $CoinDetailModelCopyWith<$Res> {
  factory _$CoinDetailModelCopyWith(_CoinDetailModel value, $Res Function(_CoinDetailModel) _then) = __$CoinDetailModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String symbol, String name,@JsonKey(name: 'market_cap_rank') int marketCapRank, CoinDetailImageModel? image, CoinDetailDescriptionModel? description,@JsonKey(name: 'market_data') CoinDetailMarketDataModel? marketData
});


@override $CoinDetailImageModelCopyWith<$Res>? get image;@override $CoinDetailDescriptionModelCopyWith<$Res>? get description;@override $CoinDetailMarketDataModelCopyWith<$Res>? get marketData;

}
/// @nodoc
class __$CoinDetailModelCopyWithImpl<$Res>
    implements _$CoinDetailModelCopyWith<$Res> {
  __$CoinDetailModelCopyWithImpl(this._self, this._then);

  final _CoinDetailModel _self;
  final $Res Function(_CoinDetailModel) _then;

/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? symbol = null,Object? name = null,Object? marketCapRank = null,Object? image = freezed,Object? description = freezed,Object? marketData = freezed,}) {
  return _then(_CoinDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,marketCapRank: null == marketCapRank ? _self.marketCapRank : marketCapRank // ignore: cast_nullable_to_non_nullable
as int,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as CoinDetailImageModel?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as CoinDetailDescriptionModel?,marketData: freezed == marketData ? _self.marketData : marketData // ignore: cast_nullable_to_non_nullable
as CoinDetailMarketDataModel?,
  ));
}

/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoinDetailImageModelCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $CoinDetailImageModelCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoinDetailDescriptionModelCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $CoinDetailDescriptionModelCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of CoinDetailModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CoinDetailMarketDataModelCopyWith<$Res>? get marketData {
    if (_self.marketData == null) {
    return null;
  }

  return $CoinDetailMarketDataModelCopyWith<$Res>(_self.marketData!, (value) {
    return _then(_self.copyWith(marketData: value));
  });
}
}

// dart format on
