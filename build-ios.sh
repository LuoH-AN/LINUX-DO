#!/bin/sh

cd ios && rm -rf Pods Podfile.lock && pod cache clean --all

pod install --repo-update

cd .. && flutter clean && flutter pub get && flutter build ios --no-codesign
