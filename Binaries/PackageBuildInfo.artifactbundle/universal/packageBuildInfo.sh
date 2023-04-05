#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Invalid number of parameters"
    exit
fi

VERSION=$(git --git-dir "$1/.git" describe --tags)
GENERATED_FILE_PATH="$2/PackageInfo.swift"

cat > "$GENERATED_FILE_PATH" <<- EOF
// This file is generated automatically. Do not modify.
import Foundation

public struct PackageInfo {
    public static let version = "$VERSION"
}
EOF
