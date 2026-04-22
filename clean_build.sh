#!/bin/bash
# Clean Build Script
make clean
make clobber
rm -rf out/target/product/tb351fu
echo "Cleaned."

