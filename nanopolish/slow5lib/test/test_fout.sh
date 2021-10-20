#!/bin/bash
# Usage $0
# Tests that f2s matches the expected output.

# Note:
#
# - Don't move this file from "slow5/tests/".
#   Requires subdirectory "data/" with testing dataset(s),
#   and "slow5tools" executable in parent directory.
#
# - Expects testing datasets with the following structure:
#     - dataset/
#         |- expected.slow5
#         |- expected.slow5.s5i
#         |- expected.blow5
#         |- expected.blow5.b5i
#         |- fast5_files/
#             |- expected_1.fast5
#             |- ...



# Relative path to "slow5/tests/"
REL_PATH="$(dirname $0)/"

# Change directory to tests folder
# since filenames are output relative this directory
# and will influence test results
# TODO necessary?
cd $REL_PATH

# Folder containing testing datasets
DATA_DIR="data"
# Ensure data directory exists
if [ ! -d $DATA_DIR ]; then
    echo "ERROR: Missing data directory \""$REL_PATH"/"$DATA_DIR"\""

    # Change back to original directory
    cd - >/dev/null

    echo "Exiting"
    exit 1
fi

# Path to slow5tools
SLOW5TOOLS_PATH="../slow5tools"
# Ensure slow5tools exists
if [ ! -f $SLOW5TOOLS_PATH ]; then
    echo "ERROR: Missing slow5tools \""$REL_PATH"/"$SLOW5TOOLS_PATH"\""

    # Change back to original directory
    cd - >/dev/null

    echo "Exiting"
    exit 1
fi

CMD_FAST5_TO_SLOW5="f2s"
CMD_FAST5_TO_BLOW5="f2s -b"
CMD_SLOW5_IDX="index"
CMD_BLOW5_IDX="index"


# Folder name in datasets containing FAST5 files
FAST5_FOLDER="fast5_files/"

# File name of expected SLOW5 output
SLOW5_EXPECTED="expected.slow5"
# File name of actual SLOW5 output
SLOW5_ACTUAL="actual.slow5"

# File name of expected BLOW5 output
BLOW5_EXPECTED="expected.blow5"
# File name of actual BLOW5 output
BLOW5_ACTUAL="actual.blow5"

# File name of expected SLOW5 index output
SLOW5_IDX_EXPECTED="expected.slow5.s5i"
# File name of actual SLOW5 index output
SLOW5_IDX_ACTUAL="actual.slow5.s5i"

# File name of expected SLOW5 index output
BLOW5_IDX_EXPECTED="expected.blow5.b5i"
# File name of actual SLOW5 index output
BLOW5_IDX_ACTUAL="actual.blow5.b5i"

declare -i ret=0

# Iterate through each testset
for testset in $DATA_DIR/*; do
    echo "$testset"

    rm "$testset/$SLOW5_ACTUAL"
    rm "$testset/$SLOW5_IDX_ACTUAL"

    # Sort the reads but not the header
    "$SLOW5TOOLS_PATH" "$CMD_FAST5_TO_SLOW5" "$testset/$FAST5_FOLDER" 2>/dev/null | awk '{if (substr($0,1,1) == "#") print $0 > "/dev/stderr"; else print $0}' 2> "$testset/$SLOW5_ACTUAL" | sort -r >> "$testset/$SLOW5_ACTUAL"
    "$SLOW5TOOLS_PATH" $CMD_SLOW5_IDX "$testset/$SLOW5_ACTUAL" 2>/dev/null

    if diff "$testset/$SLOW5_EXPECTED" "$testset/$SLOW5_ACTUAL" 2>&1 >/dev/null; then
        echo "SUCCESS fast5 -> slow5"
    else
        echo "FAILED fast5 -> slow5"
        ret=1
    fi

    if diff "$testset/$SLOW5_IDX_EXPECTED" "$testset/$SLOW5_IDX_ACTUAL" 2>&1 >/dev/null; then
        echo "SUCCESS slow5 index"
    else
        echo "FAILED slow5 index"
        ret=1
    fi

    rm "$testset/$BLOW5_ACTUAL"
    rm "$testset/$BLOW5_IDX_ACTUAL"

    "$SLOW5TOOLS_PATH" $CMD_FAST5_TO_BLOW5 "$testset/$FAST5_FOLDER" -o "$testset/$BLOW5_ACTUAL" 2>/dev/null
    "$SLOW5TOOLS_PATH" "$CMD_BLOW5_IDX" "$testset/$BLOW5_ACTUAL" 2>/dev/null

    if diff "$testset/$BLOW5_EXPECTED" "$testset/$BLOW5_ACTUAL" 2>&1 >/dev/null; then
        echo "SUCCESS fast5 -> blow5"
    else
        echo "FAILED fast5 -> blow5"
        ret=1
    fi

    if diff "$testset/$BLOW5_IDX_EXPECTED" "$testset/$BLOW5_IDX_ACTUAL" 2>&1 >/dev/null; then
        echo "SUCCESS blow5 index"
    else
        echo "FAILED blow5 index"
        ret=1
    fi

    echo ""
done

# Change back to original directory
cd - >/dev/null

if [ $ret -eq 0 ]; then
    echo "PASSED"
else
    echo "FAILED"
fi
exit $ret
