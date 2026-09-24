# LIFE OS test builds

| File | Built from | Android | SHA-256 |
|---|---|---|---|
| LIFE-OS-1.0.1-arm64.apk | main @ e49b8e4 | 64-bit ARM (arm64-v8a) | `7075a8e4929cda7e9d945a03d01a95c82dbbb740f9f9d79c1f8a3b9583ee0947` |

Test build signed with a temporary debug key. It installs over 1.0.0 and keeps
its data. A later build signed with a different key cannot update it in place;
uninstalling removes the app's data.
