TB351FU OrangeFox Device Tree
=============================

This device tree is specialized for the Lenovo Tab Plus (TB351FU) using a multi-fragment vendor_boot.

CORE LOGIC: FRAGMENT 0 (PLATFORM)
---------------------------------
Fragment 0 is the "Platform Ramdisk". In this recovery build, we treat Fragment 0 as a core system component:
- **Physical Manifest Hijack:** All VINTF manifests are physically modified to version 8.0 in the pre-build stage to prevent `servicemanager` crashes.
- **HAL Pre-loading:** The touchscreen HAL is started in Fragment 0 to ensure it is ready before OrangeFox loads.
- **Direct Block Storage:** Storage paths are hardcoded to `/dev/block/sdc64` and `/dev/block/by-name/userdata` to bypass unstable mapper links.

BUILD INSTRUCTIONS:
- Run `./build.sh` from the device tree root (or copy to project root).
- Use `./clean_build.sh` to reset the environment.

