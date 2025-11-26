#!/bin/bash

# -----------------------------
# Tham số command line
# -----------------------------
# $1 = JSON file input
# $2 = class name (PascalCase)
# $3 = output file (tùy chọn, default lib/models/<classname_lower>.dart)
JSON_FILE=${1:-"./data.json"}
CLASS_NAME=${2:-"UserModel"}

# Tạo tên file dart chữ thường từ class name
CLASS_NAME_LOWER=$(echo "$CLASS_NAME" | awk '{print tolower($0)}')
OUTPUT_FILE=${3:-"./lib/models/${CLASS_NAME_LOWER}.dart"}

# -----------------------------
# Kiểm tra file JSON tồn tại
# -----------------------------
if [ ! -f "$JSON_FILE" ]; then
    echo "JSON file not found: $JSON_FILE"
    exit 1
fi

# -----------------------------
# Kiểm tra QuickType
# -----------------------------
if ! command -v quicktype &> /dev/null
then
    echo "QuickType chưa cài. Cài bằng 'brew install quicktype'"
    exit 1
fi

# -----------------------------
# Tạo thư mục output nếu chưa có
# -----------------------------
OUTPUT_DIR=$(dirname "$OUTPUT_FILE")
mkdir -p "$OUTPUT_DIR"

# -----------------------------
# Sinh model Freezed từ JSON
# -----------------------------
echo "Generating Freezed model from $JSON_FILE..."
quicktype "$JSON_FILE" -l dart -o "$OUTPUT_FILE" --freezed --top-level "$CLASS_NAME"

if [ $? -ne 0 ]; then
    echo "QuickType failed"
    exit 1
fi

echo "Model generated at $OUTPUT_FILE"

# -----------------------------
# Chạy build_runner để generate .g.dart
# -----------------------------
echo "Running build_runner..."
flutter pub run build_runner build --delete-conflicting-outputs

if [ $? -eq 0 ]; then
    echo "Done! Model is ready."
else
    echo "Build runner failed"
    exit 1
fi
