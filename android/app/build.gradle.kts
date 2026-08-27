plugins {
    id("com.android.application")

    // Firebase configuration
    id("com.google.gms.google-services")

    id("kotlin-android")

    // Flutter plugin Android aur Kotlin plugins ke baad hona chahiye
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.journey_x"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.journey_x"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Filhaal debug signing use ho rahi hai
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}