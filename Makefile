build-android:
	flutter build apk --release

built_runner:
	dart run build_runner build --delete-conflicting-outputs