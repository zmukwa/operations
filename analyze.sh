#!/usr/bin/env bash

if [ -z "$WORKSPACE" ]; then
    echo "Need to set WORKSPACE"
    exit 1
fi 

# set clang for scan-build analysis
export CC=clang
export CXX=clang++
export CCC_CC=$CC
export CCC_CXX=$CXX

PATH="$PATH:/usr/local/src/llvm/tools/clang/tools/scan-build"

# temp directory to store the scan-build report
SCAN_BUILD_TMPDIR=$( mktemp -d /tmp/scan-build.XXXXXX )

# directory to use for archiving the scan-build report
SCAN_BUILD_ARCHIVE="${WORKSPACE}/scan-build-archive"

# build directory
BUILD_DIR="${WORKSPACE}/build/scan-build"

if [ ! -d "${BUILD_DIR}" ]; then
    mkdir -p "${BUILD_DIR}"
    cd "${BUILD_DIR}"
    cmake -DCMAKE_C_COMPILER=`which ccc-analyzer` -DCMAKE_CXX_COMPILER=`which c++-analyzer` -DCMAKE_BUILD_TYPE=Debug "${WORKSPACE}"
else
    cd "${BUILD_DIR}"
    make rebuild_cache
fi

# do not exit immediately if any command fails
set +e

# generate the scan-build report
scan-build -k -o "${SCAN_BUILD_TMPDIR}" --use-analyzer /usr/local/bin/clang --html-title="operations static analysis" make -j`getconf _NPROCESSORS_ONLN`

cd "${WORKSPACE}"

# get the directory name of the report created by scan-build
SCAN_BUILD_REPORT=$( find ${SCAN_BUILD_TMPDIR} -maxdepth 1 -not -empty -not -name `basename ${SCAN_BUILD_TMPDIR}` )
return_code=$?

echo ">>> Removing any previous scan-build reports from ${SCAN_BUILD_ARCHIVE}"
rm -rf "${SCAN_BUILD_ARCHIVE}"
mkdir "${SCAN_BUILD_ARCHIVE}"

if [ -z "${SCAN_BUILD_REPORT}" ]; then
    echo ">>> No new bugs identified."
    echo ">>> No scan-build report has been generated"
    echo "NO BUG REPORTS" > ${SCAN_BUILD_ARCHIVE}/index.html
else
    echo ">>> New scan-build report generated in ${SCAN_BUILD_REPORT}"
    echo ">>> Creating scan-build archive directory"
    install -d -o jenkins -g nogroup -m 0755 "${SCAN_BUILD_ARCHIVE}"
    echo ">>> Archiving scan-build report to ${SCAN_BUILD_ARCHIVE}"
    mv ${SCAN_BUILD_REPORT}/* ${SCAN_BUILD_ARCHIVE}/
fi

echo ">>> Removing any temporary files and directories"
rm -rf "${SCAN_BUILD_TMPDIR}"

exit ${return_code}
