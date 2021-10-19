#!/bin/bash

# clean build directories before git commits

cd f5c-v0.6
cd htslib
make clean
cd ..
make clean
cd ..

rm -rf demo_data/demo_generated_result/*


