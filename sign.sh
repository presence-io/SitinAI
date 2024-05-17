#!/bin/bash

# 定义需要签名的文件夹路径
folder_path="./Frameworks/"

# 签名密钥，根据实际情况修改
signing_key="Apple Development: Alex Bright (WUD2H26J24)"

# 遍历文件夹中的所有文件
find "$folder_path" -type f -name "*.dylib" | while IFS= read -r file; do
    # 签名文件
    codesign -f -s "$signing_key" "$file"
    # 检查签名结果
    if codesign --verify --deep --strict --verbose=2 "$file"; then
        echo "File $file 签名成功."
    else
        echo "File $file 签名失败."
    fi
done
