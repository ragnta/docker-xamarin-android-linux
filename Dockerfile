RUN apt-get update

RUN apt-get -y install bzip2 mono-complete lynx openjdk-8-jdk unzip

RUN mkdir -p /android/sdk

RUN curl -L https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o sdk-tools-linux.zip
RUN unzip sdk-tools-linux.zip
RUN rm sdk-tools-linux.zip

RUN yes | /android/sdk/tools/bin/sdkmanager --licenses
RUN /android/sdk/tools/bin/sdkmanager "platform-tools" "build-tools;28.0.3" "platforms;android-28"

RUN lynx -listonly -dump https://jenkins.mono-project.com/view/Xamarin.Android/job/xamarin-android-linux/lastSuccessfulBuild/Azure/ | grep -o "https://.*/Azure/processDownloadRequest/xamarin-android/xamarin.android.*Release.*" > link.txt
RUN curl -L $(cat link.txt) -o xamarin.tar.bz2
RUN bzip2 -cd xamarin.tar.bz2 | tar -xvf -

RUN mv xamarin.android-oss* /android/xamarin && rm xamarin.tar.bz2

RUN cp -R /android/xamarin/bin/Release/lib/xamarin.android/xbuild/Xamarin /usr/lib/mono/xbuild/
RUN cp -R /android/xamarin/bin/Release/lib/xamarin.android/xbuild-frameworks/MonoAndroid /usr/lib/mono/xbuild-frameworks/

ENV ANDROID_NDK_PATH=/android/sdk/ndk-bundle
ENV ANDROID_SDK_PATH=/android/sdk/
ENV PATH=/android/xamarin/bin/Release/bin:$PATH
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

ENTRYPOINT bash
