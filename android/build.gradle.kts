// ---------------------------
// CONFIGURACIÓN PARA FIREBASE
// ---------------------------
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
    }
}

// ---------------------------
// REPOSITORIOS PARA SUBPROYECTOS
// ---------------------------
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ---------------------------
// CONFIGURACIÓN DE BUILD DIRECTORY PERSONALIZADO
// ---------------------------
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// ---------------------------
// TAREA CLEAN
// ---------------------------
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
