vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CLIUtils/CLI11
    REF 65ede431b8d3d8e3082aa5793155d0e14d1aa2f2
    SHA512 b88279ad3481e7a28d93918195be2f4181c638afd2bbef45430a72a54aea9a317fe993984101833b907f697e4541cb4685394c70a3a9f73e21b3cbf037d482eb
    HEAD_REF main
)

# 🩹 Patch CMakeLists.txt to support CMake 3.5+
file(READ "${SOURCE_PATH}/CMakeLists.txt" _contents)
string(REPLACE "cmake_minimum_required(VERSION 2.8)" "cmake_minimum_required(VERSION 3.5)" _contents "${_contents}")
file(WRITE "${SOURCE_PATH}/CMakeLists.txt" "${_contents}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DCLI11_BUILD_EXAMPLES=OFF
        -DCLI11_BUILD_DOCS=OFF
        -DCLI11_BUILD_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH share/cmake/CLI11)
vcpkg_fixup_pkgconfig()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
