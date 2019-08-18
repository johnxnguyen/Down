#!/bin/bash

echo "- Cleaning App"
swift package clean

echo "- Building App"
swift build --configuration release

echo "- Cleaning App"
swift package clean

echo "- Done!"
