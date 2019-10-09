#!/bin/bash

echo "- Cleaning App"
swift package clean
if [ $? != 0 ]; then
  echo "❌ Linux build failed."
  exit 1
fi

echo "- Building App"
swift build --configuration release
if [ $? != 0 ]; then
  echo "❌ Linux build failed."
  exit 1
fi

echo "✅ Linux build completed!"
