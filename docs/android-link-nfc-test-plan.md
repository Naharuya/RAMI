# Android deep-link and NFC validation

Build: `flutter build apk --debug --no-pub --android-project-arg=android.builder.sdkDownload=false`.
Package: `com.rami.rami_mvp`. Use only a local/demo build without Firebase production configuration. Check device authorization, installed version and signing before any `adb install -r`. Never uninstall or clear data to bypass incompatibility.

## Automated coverage

`flutter test test/rami_card_link_test.dart` checks the three custom URIs, future HTTPS URIs, legacy Text IDs, unknown IDs and unsupported domains/schemes. This is parser coverage, not Android NFC dispatch or physical-device coverage.

## VIEW deep links (manual device checks)

Replace SERIAL with the selected authorized device. For each case use E001 (elephant), D001 (dog), C001 (car) and record expected/actual content, duplicate navigation, crashes and back behavior.

- Foreground: open RAMI and send the command below while the activity is visible.
- Background: press HOME, then send the command. Confirm correct content without duplicate screens.
- Cold start: stop the test app process, then send the explicit VIEW command. This tests process creation by VIEW, not physical NFC after Android force-stop.

```sh
adb -s SERIAL shell am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d 'rami://t/E001' com.rami.rami_mvp
```

Repeat quickly with another ID to test latest-event handling. Repeat an identical URI and verify the content stays usable. Unknown IDs must not crash.

## Physical NFC matrix

Use an existing readable test tag with URI `rami://t/E001` and a separate existing legacy Text tag `RAMI:ELEPHANT:001`. Tag writing/locking is not automated. Keep the screen on and unlocked; do not change device permissions automatically.

| App state | URI NDEF | Text NDEF | Expected |
| --- | --- | --- | --- |
| Foreground home | NOT RUN | NOT RUN | matching content opens once |
| Foreground NFC reader | NOT RUN | NOT RUN | matching content opens once |
| Background after HOME | NOT RUN | NOT RUN | app resumes with matching content |
| Process absent (not force-stopped) | NOT RUN | NOT RUN | app starts with matching content |

ADB VIEW does not contain `EXTRA_NDEF_MESSAGES`, so it cannot replace these NFC checks. After a force-stop, Android may suppress normal NFC dispatch until the app is opened again; record that separately. Locked-screen NFC and HTTPS domain association are outside this local test's pass criteria.

## Startup edge to inspect on hardware

`MainActivity.configureFlutterEngine` currently sends NFC events as soon as the native channel exists. Native channel availability does not prove Dart has registered its handler. Pay particular attention to cold-start Text NDEF delivery; code inspection alone cannot mark it passed.

## Result record

Record commit SHA, APK SHA256, build variant, device/OS, entry method, process state, expected card, actual result and sanitized error category. Do not include recordings, API credentials or personal data in logs. Firebase production, APK external distribution and NFC tag mutation require separate authorization.
