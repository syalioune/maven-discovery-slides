+++
weight = 51
+++

{{% section %}}

# Situation

_Maven_ repositories **automatically generates checksums** using `MD5` and `SHA1` for each deployed artifacts.

![commons-beanutils-checksums](commons-beanutils-checksums.png)

_Maven_ CLI leverages those checksums when downloading artifacts from repositories to **verify the package integrity**.

😬 What happens when checksum validation fails ? 😬

---

# Schrödinger build

<img src="https://media.tenor.com/qiyi2zyk8KYAAAAC/mission-failed.gif" alt="Schrödinger build" />

---

# Maven < 4.0.0

`mvn clean install`

```shell{6-7,10-12}
[INFO] Scanning for projects...
[INFO] -----------------< com.syalioune:dependency-checksum >------------------
[INFO] Building dependency-checksum 1.0
[INFO] --------------------------------[ jar ]---------------------------------
Downloading from local-mock-registry: http://localhost:5000/commons-beanutils/commons-beanutils-custom/1.9.4/commons-beanutils-custom-1.9.4.pom
[WARNING] Checksum validation failed, expected 42e7c39331e1735250b294ce29840e434ebc955 but is 6e3b205edece1aa2dea644a3c36b736b6c448f4f from local-mock-registry for http://localhost:5000/commons-beanutils/commons-beanutils-custom/1.9.4/commons-beanutils-custom-1.9.4.pom
[WARNING] Could not validate integrity of download from http://localhost:5000/commons-beanutils/commons-beanutils-custom/1.9.4/commons-beanutils-custom-1.9.4.pom
org.eclipse.aether.transfer.ChecksumFailureException: Checksum validation failed, expected 42e7c39331e1735250b294ce29840e434ebc955 but is 6e3b205edece1aa2dea644a3c36b736b6c448f4f
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.119 s (Wall Clock)
[INFO] Finished at: 2023-06-25T21:47:24+02:00
[INFO] ------------------------------------------------------------------------
```

⚠️😱 **Maven will only emit a warning and proceed unless you set `-C` flag** ⚠️😱

---

# Maven 4.0.0

`mvn clean install`

```shell{6-7,10-12}
[INFO] Scanning for projects...
[INFO] -----------------< com.syalioune:dependency-checksum >------------------
[INFO] Building dependency-checksum 1.0
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
Downloading from local-mock-registry: http://localhost:5000/commons-beanutils/commons-beanutils-custom/1.9.4/commons-beanutils-custom-1.9.4.pom
[WARNING] Checksum validation failed, expected '42e7c39331e1735250b294ce29840e434ebc955' (REMOTE_EXTERNAL) but is actually '6e3b205edece1aa2dea644a3c36b736b6c448f4f' from local-mock-registry for http://localhost:5000/commons-beanutils/commons-beanutils-custom/1.9.4/commons-beanutils-custom-1.9.4.pom
[IJ]-18-ARTIFACT_DOWNLOADING-[IJ]-path=-[IJ]-artifactCoord=commons-beanutils:commons-beanutils-custom:pom:1.9.4-[IJ]-error=
Downloading from central: https://repo.maven.apache.org/maven2/commons-beanutils/commons-beanutils-custom/1.9.4/commons-beanutils-custom-1.9.4.pom
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.247 s (Wall Clock)
[INFO] Finished at: 2023-06-26T19:40:04+02:00
[INFO] ------------------------------------------------------------------------
```

👍 **Maven 4.0.0 fails the build by default if checksum verification fails** 👍

---

# Summary

* 💡 **[Possible] Use cases**
    * Secure your software supply chain

* 🤔 **Alternatives**
    * YOLO 🙈

{{% /section %}}