A docker image for build xamarin android projects.

Prerequisite:
 - docker

The image contains the followings:
 - sdkman for manage java
 - android-27, android-28
 - nuget, mono, msbuild, xamarin etc

Usage:
 - build image:
 `docker build --rm -f "Dockerfile" -t xamarin:latest "."`
 - Start docker:
 `docker run -it --name=compile  --volume Path/to/project/on/host:/Path/in/docker xamarin:latest`
 - create android package:
 `msbuild /t:SignAndroidPackage Path/to/Csproj/CsprojName.csproj /p:AndroidSdkDirectory=/android/sdk`
 - compile:
 `msbuild SolutionFile.sln /p:AndroidSdkDirectory=/android/sdk /restore`
 - debug:
 TBD