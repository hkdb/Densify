# AppImage Building Instructions

![Densify Logo](res/desktop-icon.png)

1. Build AppImage for Testing
   ```
   ./build.sh
   ```
1. Test that AppImage works
2. Sign and Rebuild AppImage
   ```
   ./signAppImage.sh
   ```
   *Note must change the key value in signAppImage.sh if packaged by someone else

<br>

To Clean the build, simply execute:
```
./clean.sh
```