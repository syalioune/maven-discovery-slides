+++
weight = 21
+++

{{% section %}}

# Problem statement

There are various aspects of _Maven_ that you can configure using `CLI options` or environment variables.

* **Maven JVM** through `MAVEN_OPTS` environment variable (e.g. `-Xms256m`)

* **Build tool options** (e.g. `--fail-at-end`)

* **Extension loading** (e.g. `-Dmaven.ext.class.path=extension.jar`)


😬 It can be a burden to **share consistently a common relevant set of arguments/options** between developers in a team or environments !

---

# Enter the `.mvn` folder

![dotmvn-folder](dotmvn-folder.png)

---

# Since _Maven_ `3.3.1`

* You can create a `.mvn/jvm.config` file containing **project-wide _Maven_ JVM options** in one line.

```shell
-Xmx512m -Xms256m -Djava.awt.headless=true
```

* You can create a `.mvn/maven.config` file containing **project-wide _Maven_ CLI options** in one line

```shell
--batch-mode --errors --fail-at-end
```

* Issuing a `mvn compile` implicitly produce something like

```shell
export MAVEN_OPTS="-Xmx512m -Xms256m -Djava.awt.headless=true"
mvn compile --batch-mode --errors --fail-at-end
```

---

# Since _Maven_ `3.2.5`

* You can create a `.mvn/extensions.xml` file containing **project-wide _Maven_ extensions**.

```xml
<extensions>
    <extension>
        <groupId>com.soebes.maven.extensions</groupId>
        <artifactId>maven-buildtime-profiler</artifactId>
        <version>0.2.0</version>
    </extension>
</extensions>
```

🙊 **We'll discuss extensions in few minutes...** 🙊

---

# Override behavior

```shell{2-6,8-11}
├── pom.xml
├── .mvn
│   ├── extensions.xml
│   ├── jvm.config
│   └── maven.config
├── configuration
│   ├── pom.xml
│   ├── .mvn
│   │   ├── extensions.xml
│   │   ├── jvm.config
│   │   └── maven.config
```

* _Maven_ **honors the nearest** `.mvn` folder from its execution root
* _Maven_ **honors the options passed directly** in the command line

⛔ **_Maven_ does not perform any kind of merging** ⛔

---

# Summary

* 💡 **[Possible] Use cases**
    * **Sharing and versionning a common set of options** relevant to your project across environment and team member


* 🤔 **Alternatives** 
    * Environment variables

    * Wrapper scripts

{{% /section %}}
