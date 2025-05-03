// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {

 Exception get exception; String get message; StackTrace? get stackTrace; bool get isCritical; int get retryAttempts;
/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.exception, exception) || other.exception == exception)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.isCritical, isCritical) || other.isCritical == isCritical)&&(identical(other.retryAttempts, retryAttempts) || other.retryAttempts == retryAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,exception,message,stackTrace,isCritical,retryAttempts);

@override
String toString() {
  return 'Failure(exception: $exception, message: $message, stackTrace: $stackTrace, isCritical: $isCritical, retryAttempts: $retryAttempts)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>  {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 Exception exception, String message, StackTrace? stackTrace, bool isCritical, int retryAttempts
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exception = null,Object? message = null,Object? stackTrace = freezed,Object? isCritical = null,Object? retryAttempts = null,}) {
  return _then(_self.copyWith(
exception: null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as Exception,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,isCritical: null == isCritical ? _self.isCritical : isCritical // ignore: cast_nullable_to_non_nullable
as bool,retryAttempts: null == retryAttempts ? _self.retryAttempts : retryAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc


class _Failure implements Failure {
  const _Failure({required this.exception, required this.message, this.stackTrace, this.isCritical = false, this.retryAttempts = 0});
  

@override final  Exception exception;
@override final  String message;
@override final  StackTrace? stackTrace;
@override@JsonKey() final  bool isCritical;
@override@JsonKey() final  int retryAttempts;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailureCopyWith<_Failure> get copyWith => __$FailureCopyWithImpl<_Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure&&(identical(other.exception, exception) || other.exception == exception)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.isCritical, isCritical) || other.isCritical == isCritical)&&(identical(other.retryAttempts, retryAttempts) || other.retryAttempts == retryAttempts));
}


@override
int get hashCode => Object.hash(runtimeType,exception,message,stackTrace,isCritical,retryAttempts);

@override
String toString() {
  return 'Failure(exception: $exception, message: $message, stackTrace: $stackTrace, isCritical: $isCritical, retryAttempts: $retryAttempts)';
}


}

/// @nodoc
abstract mixin class _$FailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) _then) = __$FailureCopyWithImpl;
@override @useResult
$Res call({
 Exception exception, String message, StackTrace? stackTrace, bool isCritical, int retryAttempts
});




}
/// @nodoc
class __$FailureCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(this._self, this._then);

  final _Failure _self;
  final $Res Function(_Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exception = null,Object? message = null,Object? stackTrace = freezed,Object? isCritical = null,Object? retryAttempts = null,}) {
  return _then(_Failure(
exception: null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as Exception,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,isCritical: null == isCritical ? _self.isCritical : isCritical // ignore: cast_nullable_to_non_nullable
as bool,retryAttempts: null == retryAttempts ? _self.retryAttempts : retryAttempts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
