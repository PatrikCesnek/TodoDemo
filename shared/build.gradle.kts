plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
    kotlin("plugin.serialization") version "1.9.0"
}

kotlin {
    androidTarget {
        compilations.all {
            kotlinOptions {
                jvmTarget = "1.8"
            }
        }
    }
    
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
            isStatic = true
        }
    }

    sourceSets {
        commonMain.dependencies {
            implementation("io.ktor:ktor-client-core:2.3.3")
            implementation("io.ktor:ktor-client-cio:2.3.3")
            implementation("io.ktor:ktor-client-darwin:2.3.3")
            implementation("io.ktor:ktor-client-logging:2.3.3")
            implementation("io.ktor:ktor-client-content-negotiation:2.3.3")
            implementation("io.ktor:ktor-serialization-kotlinx-json:2.3.3")
            implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.6.0")
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }
    }
}

android {
    namespace = "com.example.todoapp"
    compileSdk = 34
    defaultConfig {
        minSdk = 24
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}
