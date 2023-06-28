+++
weight = 53
+++

{{% section %}}

# _Maven_ capabilities

Maven allows you to define [dependency version ranges](https://maven.apache.org/pom.html#dependency-version-requirement-specification) just like npm uses [semantic versioning](https://docs.npmjs.com/about-semantic-versioning).

Maven version requirements has the following syntax:
* `1.0`: Soft requirement for `1.0`. Use `1.0` if no other version appears earlier in the dependency tree.
* `[1.0]`: Hard requirement for `1.0`. Use `1.0` and only `1.0`.
* `(,1.0]`: Hard requirement for any version <= `1.0`.
* `[1.2,1.3]`: Hard requirement for any version between `1.2` and `1.3` inclusive.
* `[1.0,2.0)`: `1.0` <= x < `2.0`; Hard requirement for any version between `1.0` inclusive and `2.0` exclusive.

⚠️ **It is a consensus that using version ranges is a bad practice because it can lead to non-reproductible builds** ⚠️

---

# What if...

<img src="https://media.giphy.com/media/1XeHuHcR6Mo50PibPW/giphy.gif" alt="stay in wonderland" />

...You can leverage [dependency version ranges](https://maven.apache.org/pom.html#dependency-version-requirement-specification) and [maven versions plugin](https://www.mojohaus.org/versions/versions-maven-plugin/index.html) to **implement a very basic solution to automatically and periodically upgrade your dependencies**.

The context may be :
* You cannot use [Dependabot](https://github.com/dependabot/dependabot-core) or [Renovate](https://docs.renovatebot.com/) for whatever reasons
* Your project is fairly simple
* Your project has a flat roadmap

---

# Poor's man automated deps upgrade : `pom-ranges.xml`

You can maintain in your **VCS** a `pom-ranges.xml` file which :
* **Mirrors the content** of `pom.xml`
* Contains **tolerated version ranges** of your libraries

```xml{}
<properties>
    <allowMajorUpdates>false</allowMajorUpdates>
    <allowMinorUpdates>false</allowMinorUpdates>
    <allowIncrementalUpdates>true</allowIncrementalUpdates>
</properties>
<dependencies>
    <dependency>
        <groupId>commons-beanutils</groupId>
        <artifactId>commons-beanutils</artifactId>
        <version>[1.8.0,)</version>
    </dependency>
</dependencies>
```

💡 `mvn versions:resolve-ranges` generates a `pom.xml` with satisfying soft versions

---

# Poor's man automated dependency updates : algorithm

![dependency-version-range-bump](dependency-version-range-bump.png)


---

# Poor's man automated dependency updates : execution

```shell
./try_dependencies_upgrade.sh
```

```diff{}
diff --git a/pom.xml b/pom.xml
--- a/pom.xml
+++ b/pom.xml
@@ -24,12 +24,12 @@
         <dependency>
             <artifactId>commons-beanutils</artifactId>
-            <version>1.8.0</version>
+            <version>1.9.4</version>
         </dependency>
```
---

# Summary

* 💡 **[Possible] Use cases**
    * Automatically upgrade dependency versions in a controlled environment

* 🤔 **Alternatives**
    * [Dependabot](https://github.com/dependabot/dependabot-core)
    * [Renovate](https://docs.renovatebot.com/)

{{% /section %}}
