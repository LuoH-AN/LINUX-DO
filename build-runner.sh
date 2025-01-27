#!/bin/sh

dart run build_runner build --delete-conflicting-outputs

flutter pub run build_runner build  || flutter pub run build_runner build --delete-conflicting-outputs