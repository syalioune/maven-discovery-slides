+++
weight = 61
+++

{{% section %}}

# Problem statement

![maven-reactor-module-tree](maven-reactor-module-tree.png)

**How do you do if you want to build only `project-a-impl` 🤔 ?**

---

# Reactor before _Maven_ 4

```shell{1-2,7,9,13}
cd project-a/project-a-impl
mvn clean install
[INFO] --------------------< com.syalioune:project-a-impl >--------------------
[INFO] Building project-a-impl 1.0
[INFO] --------------------------------[ jar ]---------------------------------
Downloading from central: https://repo.maven.apache.org/maven2/com/syalioune/common/1.0/common-1.0.pom
[WARNING] The POM for com.syalioune:common:jar:1.0 is missing, no dependency information available
Downloading from central: https://repo.maven.apache.org/maven2/com/syalioune/project-b-api/1.0/project-b-api-1.0.pom
[WARNING] The POM for com.syalioune:project-b-api:jar:1.0 is missing, no dependency information available
Downloading from central: https://repo.maven.apache.org/maven2/com/syalioune/common/1.0/common-1.0.jar
Downloading from central: https://repo.maven.apache.org/maven2/com/syalioune/project-b-api/1.0/project-b-api-1.0.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
```

🏁 **You must `clean install` dependent modules beforehand !**

---

# Reactor `--also-make` 1/2 (Since _Maven_ `4.0.0`)

```shell{1-2,4-10,13}
cd project-a/project-a-impl
mvn clean install --also-make
[INFO] Scanning for projects...
[INFO] Reactor Build Order:
[INFO] reactor-improvements                                               [pom]
[INFO] project-a                                                          [pom]
[INFO] common                                                             [jar]
[INFO] project-b                                                          [pom]
[INFO] project-b-api                                                      [jar]
[INFO] project-a-impl                                                     [jar] 
...
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
```

---

# Reactor `--also-make` 2/2 (Since _Maven_ `4.0.0`)

![maven-reactor-also-make](maven-reactor-also-make.png)

---

# Summary

* 💡 **[Possible] Use cases**
    * Being able to target submodules directly without worrying about module tree
        * It requires a `.mvn` folder at the top level (even empty)

* 🤔 **Alternatives**
    * Global `clean install` before using submodules individually

{{% /section %}}
