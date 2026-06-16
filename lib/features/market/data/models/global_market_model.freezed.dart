// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_market_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GlobalMarketModel {

@JsonKey(name: 'total_market_cap') Map<String, double> get totalMarketCap;@JsonKey(name: 'total_volume') Map<String, double> get totalVolume;@JsonKey(name: 'market_cap_change_percentage_24h_usd') double get marketCapChangePercentage24hUsd;
/// Create a copy of GlobalMarketModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlobalMarketModelCopyWith<GlobalMarketModel> get copyWith => _$GlobalMarketModelCopyWithImpl<GlobalMarketModel>(this as GlobalMarketModel, _$identity);

  /// Serializes this GlobalMarketModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlobalMarketModel&&const DeepCollectionEquality().equals(other.totalMarketCap, totalMarketCap)&&const DeepCollectionEquality().equals(other.totalVolume, totalVolume)&&(identical(other.marketCapChangePercentage24hUsd, marketCapChangePercentage24hUsd) || other.marketCapChangePercentage24hUsd == marketCapChangePercentage24hUsd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(totalMarketCap),const DeepCollectionEquality().hash(totalVolume),marketCapChangePercentage24hUsd);

@override
String toString() {
  return 'GlobalMarketModel(totalMarketCap: $totalMarketCap, totalVolume: $totalVolume, marketCapChangePercentage24hUsd: $marketCapChangePercentage24hUsd)';
}


}

/// @nodoc
abstract mixin class $GlobalMarketModelCopyWith<$Res>  {
  factory $GlobalMarketModelCopyWith(GlobalMarketModel value, $Res Function(GlobalMarketModel) _then) = _$GlobalMarketModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_market_cap') Map<String, double> totalMarketCap,@JsonKey(name: 'total_volume') Map<String, double> totalVolume,@JsonKey(name: 'market_cap_change_percentage_24h_usd') double marketCapChangePercentage24hUsd
});




}
/// @nodoc
class _$GlobalMarketModelCopyWithImpl<$Res>
    implements $GlobalMarketModelCopyWith<$Res> {
  _$GlobalMarketModelCopyWithImpl(this._self, this._then);

  final GlobalMarketModel _self;
  final $Res Function(GlobalMarketModel) _then;

/// Create a copy of GlobalMarketModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalMarketCap = null,Object? totalVolume = null,Object? marketCapChangePercentage24hUsd = null,}) {
  return _then(_self.copyWith(
totalMarketCap: null == totalMarketCap ? _self.totalMarketCap : totalMarketCap // ignore: cast_nullable_to_non_nullable
as Map<String, double>,totalVolume: null == totalVolume ? _self.totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as Map<String, double>,marketCapChangePercentage24hUsd: null == marketCapChangePercentage24hUsd ? _self.marketCapChangePercentage24hUsd : marketCapChangePercentage24hUsd // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GlobalMarketModel].
extension GlobalMarketModelPatterns on GlobalMarketModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlobalMarketModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlobalMarketModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlobalMarketModel value)  $default,){
final _that = this;
switch (_that) {
case _GlobalMarketModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlobalMarketModel value)?  $default,){
final _that = this;
switch (_that) {
case _GlobalMarketModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_market_cap')  Map<String, double> totalMarketCap, @JsonKey(name: 'total_volume')  Map<String, double> totalVolume, @JsonKey(name: 'market_cap_change_percentage_24h_usd')  double marketCapChangePercentage24hUsd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlobalMarketModel() when $default != null:
return $default(_that.totalMarketCap,_that.totalVolume,_that.marketCapChangePercentage24hUsd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_market_cap')  Map<String, double> totalMarketCap, @JsonKey(name: 'total_volume')  Map<String, double> totalVolume, @JsonKey(name: 'market_cap_change_percentage_24h_usd')  double marketCapChangePercentage24hUsd)  $default,) {final _that = this;
switch (_that) {
case _GlobalMarketModel():
return $default(_that.totalMarketCap,_that.totalVolume,_that.marketCapChangePercentage24hUsd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_market_cap')  Map<String, double> totalMarketCap, @JsonKey(name: 'total_volume')  Map<String, double> totalVolume, @JsonKey(name: 'market_cap_change_percentage_24h_usd')  double marketCapChangePercentage24hUsd)?  $default,) {final _that = this;
switch (_that) {
case _GlobalMarketModel() when $default != null:
return $default(_that.totalMarketCap,_that.totalVolume,_that.marketCapChangePercentage24hUsd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GlobalMarketModel implements GlobalMarketModel {
  const _GlobalMarketModel({@JsonKey(name: 'total_market_cap') final  Map<String, double> totalMarketCap = const <String, double>{}, @JsonKey(name: 'total_volume') final  Map<String, double> totalVolume = const <String, double>{}, @JsonKey(name: 'market_cap_change_percentage_24h_usd') this.marketCapChangePercentage24hUsd = 0.0}): _totalMarketCap = totalMarketCap,_totalVolume = totalVolume;
  factory _GlobalMarketModel.fromJson(Map<String, dynamic> json) => _$GlobalMarketModelFromJson(json);

 final  Map<String, double> _totalMarketCap;
@override@JsonKey(name: 'total_market_cap') Map<String, double> get totalMarketCap {
  if (_totalMarketCap is EqualUnmodifiableMapView) return _totalMarketCap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_totalMarketCap);
}

 final  Map<String, double> _totalVolume;
@override@JsonKey(name: 'total_volume') Map<String, double> get totalVolume {
  if (_totalVolume is EqualUnmodifiableMapView) return _totalVolume;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_totalVolume);
}

@override@JsonKey(name: 'market_cap_change_percentage_24h_usd') final  double marketCapChangePercentage24hUsd;

/// Create a copy of GlobalMarketModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlobalMarketModelCopyWith<_GlobalMarketModel> get copyWith => __$GlobalMarketModelCopyWithImpl<_GlobalMarketModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GlobalMarketModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlobalMarketModel&&const DeepCollectionEquality().equals(other._totalMarketCap, _totalMarketCap)&&const DeepCollectionEquality().equals(other._totalVolume, _totalVolume)&&(identical(other.marketCapChangePercentage24hUsd, marketCapChangePercentage24hUsd) || other.marketCapChangePercentage24hUsd == marketCapChangePercentage24hUsd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_totalMarketCap),const DeepCollectionEquality().hash(_totalVolume),marketCapChangePercentage24hUsd);

@override
String toString() {
  return 'GlobalMarketModel(totalMarketCap: $totalMarketCap, totalVolume: $totalVolume, marketCapChangePercentage24hUsd: $marketCapChangePercentage24hUsd)';
}


}

/// @nodoc
abstract mixin class _$GlobalMarketModelCopyWith<$Res> implements $GlobalMarketModelCopyWith<$Res> {
  factory _$GlobalMarketModelCopyWith(_GlobalMarketModel value, $Res Function(_GlobalMarketModel) _then) = __$GlobalMarketModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_market_cap') Map<String, double> totalMarketCap,@JsonKey(name: 'total_volume') Map<String, double> totalVolume,@JsonKey(name: 'market_cap_change_percentage_24h_usd') double marketCapChangePercentage24hUsd
});




}
/// @nodoc
class __$GlobalMarketModelCopyWithImpl<$Res>
    implements _$GlobalMarketModelCopyWith<$Res> {
  __$GlobalMarketModelCopyWithImpl(this._self, this._then);

  final _GlobalMarketModel _self;
  final $Res Function(_GlobalMarketModel) _then;

/// Create a copy of GlobalMarketModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalMarketCap = null,Object? totalVolume = null,Object? marketCapChangePercentage24hUsd = null,}) {
  return _then(_GlobalMarketModel(
totalMarketCap: null == totalMarketCap ? _self._totalMarketCap : totalMarketCap // ignore: cast_nullable_to_non_nullable
as Map<String, double>,totalVolume: null == totalVolume ? _self._totalVolume : totalVolume // ignore: cast_nullable_to_non_nullable
as Map<String, double>,marketCapChangePercentage24hUsd: null == marketCapChangePercentage24hUsd ? _self.marketCapChangePercentage24hUsd : marketCapChangePercentage24hUsd // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
