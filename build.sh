#!/bin/bash

SRC_DIR="use"
OUT_DIR="out"

C_COMPILER="clang"
C_FLAGS="-shared -fPIC" # Flags to compile to .so

ZLANG_COMPILER="./zlang"
ZLANG_FLAGS="" # Warning! Zlang yet doesnt have option to compile to .so

mkdir -p $OUT_DIR

compile_lib() {
    echo "Compiling $1 library"
    CUSTOM_BUILD_DIR="$1/build.sh"

    if [ -e $CUSTOM_BUILD_DIR ]; then
        ./"$CUSTOM_BUILD_DIR"
    else
        LIB_OUT_DIR="$OUT_DIR/$1"
        mkdir -p $LIB_OUT_DIR

        for FILE in "$1"/*; do
            FILE_NAME="$(basename "${FILE/%.*}")"
            EXTENSION="${FILE##*.}"

            if [[ "$FILE" == *.use.zl ]]; then
                cp $FILE $LIB_OUT_DIR
            elif [ $EXTENSION == "c" ]; then
                $C_COMPILER $C_FLAGS $FILE -o "$LIB_OUT_DIR/$FILE_NAME.so"
            elif [ $EXTENSION == "zl" ]; then
                $ZLANG_COMPILER $ZLANG_FLAGS $FILE -o "$LIB_OUT_DIR/$FILE_NAME.so"
            fi
        done
    fi
}

for DIR in "$SRC_DIR"/*; do
    if [ -d "$DIR" ]; then
        compile_lib $DIR
    fi
done
