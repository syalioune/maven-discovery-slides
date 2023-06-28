+++
weight = 62
+++

{{% section %}}

# Problem statement

![maven-reactor-module-tree-bis](maven-reactor-module-tree-bis.png)

**How do you rebuild `common` and all dependents modules ?**

---

# Reactor before _Maven_ 4

```shell{}
cd common
mvn clean install
[INFO] Scanning for projects...
[INFO] 
[INFO] Using the MultiThreadedBuilder implementation with a thread count of 3
[INFO] 
[INFO] ------------------------< com.syalioune:common >------------------------
[INFO] Building common 1.0
[INFO] --------------------------------[ jar ]--------------------------------- 
```

🏁 **It only builds `common` module !**

---

# Reactor `--also-make-dependents` 1/2 (Since _Maven_ `4.0.0`)

```shell{1-2,7-9}
cd common
mvn clean install --also-make-dependents
[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Build Order:
[INFO] 
[INFO] common                                                             [jar]
[INFO] project-a-impl                                                     [jar]
[INFO] project-b-impl                                                     [jar]
[INFO] 
[INFO] Using the MultiThreadedBuilder implementation with a thread count of 3
```

---

# Reactor `--also-make-dependents` 2/2 (Since _Maven_ `4.0.0`)

![maven-reactor-also-make-dependents](maven-reactor-also-make-dependents.png)

---

# Summary

* 💡 **[Possible] Use cases**
    * Simplified updates on shared libs

* 🤔 **Alternatives**
    * Your brain 🧠

{{% /section %}}

