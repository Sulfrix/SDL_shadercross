set(DXC_LINUX_X64_URL "https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.9.2602/linux_dxc_2026_02_20.x86_64.tar.gz")
set(DXC_LINUX_X64_HASH "SHA256=a1d3e3b5e1c5685b3eb27d5e8890e41d87df45def05112a2d6f1a63a931f7d60")
set(DXC_WINDOWS_X86_X64_ARM64_URL "https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.9.2602/dxc_2026_02_20.zip")
set(DXC_WINDOWS_X86_X64_ARM64_HASH "SHA256=a1e89031421cf3c1fca6627766ab3020ca4f962ac7e2caa7fab2b33a8436151e")
set(DXC_MACOS_X86_X64_ARM64_URL "https://github.com/Sulfrix/DirectXShaderCompiler/releases/download/prebuilt-1/macos_dxc.zip")
set(DXC_MACOS_X86_X64_ARM64_HASH "SHA256=65e45c5a0b9682f8d2d90371baadef2f3a93bab466bfbee7c1d0db95b855fad5")

get_filename_component(EXTERNAL_PATH "${CMAKE_CURRENT_LIST_DIR}/../external" ABSOLUTE)
if(NOT DEFINED DXC_ROOT)
    set(DXC_ROOT "${EXTERNAL_PATH}/DirectXShaderCompiler-binaries")
endif()

set(DOWNLOAD_LINUX ON)
set(DOWNLOAD_WINDOWS ON)
set(DOWNLOAD_APPLE ON)
if(DEFINED CMAKE_SYSTEM_NAME)
    if(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
        set(DOWNLOAD_LINUX OFF)
    endif()
    if(NOT CMAKE_SYSTEM_NAME STREQUAL "Windows")
        set(DOWNLOAD_WINDOWS OFF)
    endif()
    if(NOT APPLE)
        set(DOWNLOAD_APPLE OFF)
    endif()
endif()

if(DOWNLOAD_LINUX)
    include(FetchContent)
    FetchContent_Populate(
        dxc_linux
        URL  "${DXC_LINUX_X64_URL}"
        URL_HASH  "${DXC_LINUX_X64_HASH}"
        SOURCE_DIR "${DXC_ROOT}/linux"
    )
endif()

if(DOWNLOAD_WINDOWS)
    include(FetchContent)
    FetchContent_Populate(
        dxc_windows
        URL  "${DXC_WINDOWS_X86_X64_ARM64_URL}"
        URL_HASH  "${DXC_WINDOWS_X86_X64_ARM64_HASH}"
        SOURCE_DIR "${DXC_ROOT}/windows"
    )
endif()

if(DOWNLOAD_APPLE)
    include(FetchContent)
    FetchContent_Populate(
            dxc_linux
            URL  "${DXC_MACOS_X86_X64_ARM64_URL}"
            URL_HASH  "${DXC_MACOS_X86_X64_ARM64_HASH}"
            SOURCE_DIR "${DXC_ROOT}/macos"
    )
endif()

message("To make use of the prebuilt DirectXShaderCompiler libraries, configure with:")
message("")
message("  -DSDLSHADERCROSS_VENDORED=OFF")
message("")
message("and")
message("")
message("  -DDirectXShaderCompiler_ROOT=\"${DXC_ROOT}\"")
message("")
