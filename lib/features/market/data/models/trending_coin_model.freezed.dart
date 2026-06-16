// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trending_coin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrendingCoinDataModel {

 double get price;@JsonKey(name: 'price_change_percentage_24h') Map<String, double> get priceChangePercentage24h;
/// Create a copy of TrendingCoinDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendingCoinDataModelCopyWith<TrendingCoinDataModel> get copyWith => _$TrendingCoinDataModelCopyWithImpl<TrendingCoinDataModel>(this as TrendingCoinDataModel, _$identity);

  /// Serializes this TrendingCoinDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendingCoinDataModel&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other.priceChangePercentage24h, priceChangePercentage24h));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,const DeepCollectionEquality().hash(priceChangePercentage24h));

@override
String toString() {
  return 'TrendingCoinDataModel(price: $price, priceChangePercentage24h: $priceChangePercentage24h)';
}


}

/// @nodoc
abstract mixin class $TrendingCoinDataModelCopyWith<$Res>  {
  factory $TrendingCoinDataModelCopyWith(TrendingCoinDataModel value, $Res Function(TrendingCoinDataModel) _then) = _$TrendingCoinDataModelCopyWithImpl;
@useResult
$Res call({
 double price,@JsonKey(name: 'price_change_percentage_24h') Map<String, double> priceChangePercentage24h
});




}
/// @nodoc
class _$TrendingCoinDataModelCopyWithImpl<$Res>
    implements $TrendingCoinDataModelCopyWith<$Res> {
  _$TrendingCoinDataModelCopyWithImpl(this._self, this._then);

  final TrendingCoinDataModel _self;
  final $Res Function(TrendingCoinDataModel) _then;

/// Create a copy of TrendingCoinDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? price = null,Object? priceChangePercentage24h = null,}) {
  return _then(_self.copyWith(
price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,priceChangePercentage24h: null == priceChangePercentage24h ? _self.priceChangePercentage24h : priceChangePercentage24h // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendingCoinDataModel].
extension TrendingCoinDataModelPatterns on TrendingCoinDataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendingCoinDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendingCoinDataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendingCoinDataModel value)  $default,){
final _that = this;
switch (_that) {
case _TrendingCoinDataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendingCoinDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _TrendingCoinDataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double price, @JsonKey(name: 'price_change_percentage_24h')  Map<String, double> priceChangePercentage24h)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendingCoinDataModel() when $default != null:
return $default(_that.price,_that.priceChangePercentage24h);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double price, @JsonKey(name: 'price_change_percentage_24h')  Map<String, double> priceChangePercentage24h)  $default,) {final _that = this;
switch (_that) {
case _TrendingCoinDataModel():
return $default(_that.price,_that.priceChangePercentage24h);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double price, @JsonKey(name: 'price_change_percentage_24h')  Map<String, double> priceChangePercentage24h)?  $default,) {final _that = this;
switch (_that) {
case _TrendingCoinDataModel() when $default != null:
return $default(_that.price,_that.priceChangePercentage24h);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendingCoinDataModel implements TrendingCoinDataModel {
  const _TrendingCoinDataModel({this.price = 0.0, @JsonKey(name: 'price_change_percentage_24h') final  Map<String, double> priceChangePercentage24h = const <String, double>{}}): _priceChangePercentage24h = priceChangePercentage24h;
  factory _TrendingCoinDataModel.fromJson(Map<String, dynamic> json) => _$TrendingCoinDataModelFromJson(json);

@override@JsonKey() final  double price;
 final  Map<String, double> _priceChangePercentage24h;
@override@JsonKey(name: 'price_change_percentage_24h') Map<String, double> get priceChangePercentage24h {
  if (_priceChangePercentage24h is EqualUnmodifiableMapView) return _priceChangePercentage24h;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_priceChangePercentage24h);
}


/// Create a copy of TrendingCoinDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendingCoinDataModelCopyWith<_TrendingCoinDataModel> get copyWith => __$TrendingCoinDataModelCopyWithImpl<_TrendingCoinDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendingCoinDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendingCoinDataModel&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other._priceChangePercentage24h, _priceChangePercentage24h));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,const DeepCollectionEquality().hash(_priceChangePercentage24h));

@override
String toString() {
  return 'TrendingCoinDataModel(price: $price, priceChangePercentage24h: $priceChangePercentage24h)';
}


}

/// @nodoc
abstract mixin class _$TrendingCoinDataModelCopyWith<$Res> implements $TrendingCoinDataModelCopyWith<$Res> {
  factory _$TrendingCoinDataModelCopyWith(_TrendingCoinDataModel value, $Res Function(_TrendingCoinDataModel) _then) = __$TrendingCoinDataModelCopyWithImpl;
@override @useResult
$Res call({
 double price,@JsonKey(name: 'price_change_percentage_24h') Map<String, double> priceChangePercentage24h
});




}
/// @nodoc
class __$TrendingCoinDataModelCopyWithImpl<$Res>
    implements _$TrendingCoinDataModelCopyWith<$Res> {
  __$TrendingCoinDataModelCopyWithImpl(this._self, this._then);

  final _TrendingCoinDataModel _self;
  final $Res Function(_TrendingCoinDataModel) _then;

/// Create a copy of TrendingCoinDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? price = null,Object? priceChangePercentage24h = null,}) {
  return _then(_TrendingCoinDataModel(
price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,priceChangePercentage24h: null == priceChangePercentage24h ? _self._priceChangePercentage24h : priceChangePercentage24h // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}


/// @nodoc
mixin _$TrendingCoinModel {

 String get id; String get name; String get symbol; String get thumb;@JsonKey(name: 'market_cap_rank') int get marketCapRank; TrendingCoinDataModel? get data;
/// Create a copy of TrendingCoinModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendingCoinModelCopyWith<TrendingCoinModel> get copyWith => _$TrendingCoinModelCopyWithImpl<TrendingCoinModel>(this as TrendingCoinModel, _$identity);

  /// Serializes this TrendingCoinModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendingCoinModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.thumb, thumb) || other.thumb == thumb)&&(identical(other.marketCapRank, marketCapRank) || other.marketCapRank == marketCapRank)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,symbol,thumb,marketCapRank,data);

@override
String toString() {
  return 'TrendingCoinModel(id: $id, name: $name, symbol: $symbol, thumb: $thumb, marketCapRank: $marketCapRank, data: $data)';
}


}

/// @nodoc
abstract mixin class $TrendingCoinModelCopyWith<$Res>  {
  factory $TrendingCoinModelCopyWith(TrendingCoinModel value, $Res Function(TrendingCoinModel) _then) = _$TrendingCoinModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String symbol, String thumb,@JsonKey(name: 'market_cap_rank') int marketCapRank, TrendingCoinDataModel? data
});


$TrendingCoinDataModelCopyWith<$Res>? get data;

}
/// @nodoc
class _$TrendingCoinModelCopyWithImpl<$Res>
    implements $TrendingCoinModelCopyWith<$Res> {
  _$TrendingCoinModelCopyWithImpl(this._self, this._then);

  final TrendingCoinModel _self;
  final $Res Function(TrendingCoinModel) _then;

/// Create a copy of TrendingCoinModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? symbol = null,Object? thumb = null,Object? marketCapRank = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,thumb: null == thumb ? _self.thumb : thumb // ignore: cast_nullable_to_non_nullable
as String,marketCapRank: null == marketCapRank ? _self.marketCapRank : marketCapRank // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as TrendingCoinDataModel?,
  ));
}
/// Create a copy of TrendingCoinModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrendingCoinDataModelCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $TrendingCoinDataModelCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [TrendingCoinModel].
extension TrendingCoinModelPatterns on TrendingCoinModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendingCoinModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendingCoinModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendingCoinModel value)  $default,){
final _that = this;
switch (_that) {
case _TrendingCoinModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendingCoinModel value)?  $default,){
final _that = this;
switch (_that) {
case _TrendingCoinModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String symbol,  String thumb, @JsonKey(name: 'market_cap_rank')  int marketCapRank,  TrendingCoinDataModel? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendingCoinModel() when $default != null:
return $default(_that.id,_that.name,_that.symbol,_that.thumb,_that.marketCapRank,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String symbol,  String thumb, @JsonKey(name: 'market_cap_rank')  int marketCapRank,  TrendingCoinDataModel? data)  $default,) {final _that = this;
switch (_that) {
case _TrendingCoinModel():
return $default(_that.id,_that.name,_that.symbol,_that.thumb,_that.marketCapRank,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String symbol,  String thumb, @JsonKey(name: 'market_cap_rank')  int marketCapRank,  TrendingCoinDataModel? data)?  $default,) {final _that = this;
switch (_that) {
case _TrendingCoinModel() when $default != null:
return $default(_that.id,_that.name,_that.symbol,_that.thumb,_that.marketCapRank,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendingCoinModel implements TrendingCoinModel {
  const _TrendingCoinModel({required this.id, required this.name, required this.symbol, this.thumb = '', @JsonKey(name: 'market_cap_rank') this.marketCapRank = 0, this.data});
  factory _TrendingCoinModel.fromJson(Map<String, dynamic> json) => _$TrendingCoinModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String symbol;
@override@JsonKey() final  String thumb;
@override@JsonKey(name: 'market_cap_rank') final  int marketCapRank;
@override final  TrendingCoinDataModel? data;

/// Create a copy of TrendingCoinModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendingCoinModelCopyWith<_TrendingCoinModel> get copyWith => __$TrendingCoinModelCopyWithImpl<_TrendingCoinModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendingCoinModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendingCoinModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.symbol, symbol) || other.symbol == symbol)&&(identical(other.thumb, thumb) || other.thumb == thumb)&&(identical(other.marketCapRank, marketCapRank) || other.marketCapRank == marketCapRank)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,symbol,thumb,marketCapRank,data);

@override
String toString() {
  return 'TrendingCoinModel(id: $id, name: $name, symbol: $symbol, thumb: $thumb, marketCapRank: $marketCapRank, data: $data)';
}


}

/// @nodoc
abstract mixin class _$TrendingCoinModelCopyWith<$Res> implements $TrendingCoinModelCopyWith<$Res> {
  factory _$TrendingCoinModelCopyWith(_TrendingCoinModel value, $Res Function(_TrendingCoinModel) _then) = __$TrendingCoinModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String symbol, String thumb,@JsonKey(name: 'market_cap_rank') int marketCapRank, TrendingCoinDataModel? data
});


@override $TrendingCoinDataModelCopyWith<$Res>? get data;

}
/// @nodoc
class __$TrendingCoinModelCopyWithImpl<$Res>
    implements _$TrendingCoinModelCopyWith<$Res> {
  __$TrendingCoinModelCopyWithImpl(this._self, this._then);

  final _TrendingCoinModel _self;
  final $Res Function(_TrendingCoinModel) _then;

/// Create a copy of TrendingCoinModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? symbol = null,Object? thumb = null,Object? marketCapRank = null,Object? data = freezed,}) {
  return _then(_TrendingCoinModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,symbol: null == symbol ? _self.symbol : symbol // ignore: cast_nullable_to_non_nullable
as String,thumb: null == thumb ? _self.thumb : thumb // ignore: cast_nullable_to_non_nullable
as String,marketCapRank: null == marketCapRank ? _self.marketCapRank : marketCapRank // ignore: cast_nullable_to_non_nullable
as int,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as TrendingCoinDataModel?,
  ));
}

/// Create a copy of TrendingCoinModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrendingCoinDataModelCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $TrendingCoinDataModelCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
