#!/bin/sh

cd ios && rm -rf Pods Podfile.lock && pod cache clean --all

pod install --repo-update

cd .. && flutter clean && flutter pub get && flutter build ios --no-codesign


flutter build ipa --release --build-name=0.0.1 --build-number=001