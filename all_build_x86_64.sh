#!/bin/bash

# build NanoDiP dependencies and test them
./install_ubuntu_dependencies.sh # requires root permissions
./f5c_v0.6_x86_64_GPU_buildscript.sh
./nanopolish_minimap2_x86_64_buildscript.sh
./samtools_x86_64_buildscript.sh
./R-3.6.3_x86_64_buildscript.sh
./download_and_prepare_reference_data.sh
