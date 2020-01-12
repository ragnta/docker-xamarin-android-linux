A docker image for build xamarin android projects.

Prerequisite:
 - docker

The image contains the followings:
 - sdkman for manage java
 - android-27, android-28
 - nuget, mono, msbuild (xbuild), xamarin etc

Usage:
 - build image:
 `docker build --rm -f "Dockerfile" -t xamarin:latest "."`
 - Start docker:
 `docker run -it --name=compile  --volume Path/to/project/on/host:/Path/in/docker xamarin:latest`
 - get nuget packages:
 `nuget restore /Path/to/SLN`
 - create android package:
 `msbuild /t:SignAndroidPackage Path/to/Csproj/CsprojName.csproj /p:AndroidSdkDirectory=/android/sdk`
 - compile:
 `msbuild SolutionFile.sln /p:AndroidSdkDirectory=/android/sdk /restore`
 - debug:
 1. `docker run -it --name=compileanddebug -v /home/vagrant/source/xamarin/applicationtest:/app --privileged -v /path/to/usb:/dev/bus/usb -d xamarin:latest` --> mount all of usb interfaces
 2. `docker exec -ti compileanddebug bin/bash`
 3. Connect mobile device with usb
 4. `adb devices` --> check your device
 6. Check the ip address of the mobile device
 7. `adb connect <ipaddress>:5555` --> add your device with its ipaddress (I hope you are in the same network as the host container)
 8. `adb install path/to/apk`
 9. Happy!

 FAQ
 TBD