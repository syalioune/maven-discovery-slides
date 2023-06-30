+++
weight = 52
+++

{{% section %}}

# Problem statement

![optional-dependency-initial-situation](optional-dependency-initial-situation.png)

* The module `my_core_feature` depends on module `my_orm`
* The module `my_orm` depends on modules `my_driver_a` / `my_driver_b`
* The module `my_core_feature` want to use module `my_driver_c`

😬 **What could we do ?** 😬

---

# That's real life folks !

<img src="https://i.giphy.com/media/SwmYRaqcowXczDPAxP/giphy.webp" alt="friends-real-life"/>

**Not all of us works on new shiny bright projects designed by _Martin FOWLER_ 👴🏿 !**

---

# Classic solution with exclusions

```xml{5-10,12-16}
<dependency>
    <groupId>com.syalioune</groupId>
    <artifactId>my-orm</artifactId>
    <version>1.0</version>
    <exclusions>
        <exclusion>
            <groupId>com.syalioune.db.driver</groupId>
            <artifactId>*</artifactId>
        </exclusion>
    </exclusions>
</dependency>
<dependency>
    <groupId>com.syalioune.db.driver</groupId>
    <artifactId>my-db-driver-c</artifactId>
    <version>1.0</version>
</dependency>
```

```shell{}
[INFO] --- maven-dependency-plugin:2.8:tree (default-cli) @ my-core-feature ---
[INFO] com.syalioune:my-core-feature:jar:1.0
[INFO] +- com.syalioune:my-orm:jar:1.0:compile
[INFO] \- com.syalioune.db.driver:my-db-driver-c:jar:1.0:compile
```

---

# Solution with optional dependency 1/2 (Since `2.2.0`)

![optional-dependency](optional-dependency.png)

```xml{}
<dependency>
    <groupId>com.syalioune.db.driver</groupId>
    <artifactId>my-db-driver-a</artifactId>
    <version>1.0</version>
    <optional>true</optional>
</dependency>
```

---

# Solution with optional dependency 2/2 (Since `2.2.0`)

```xml{}
<dependencies>
    <dependency>
        <groupId>com.syalioune</groupId>
        <artifactId>my-orm</artifactId>
        <version>1.0</version>
    </dependency>
    <dependency>
        <groupId>com.syalioune.db.driver</groupId>
        <artifactId>my-db-driver-c</artifactId>
        <version>1.0</version>
    </dependency>
</dependencies>
```

```xml{}
[INFO] --- maven-dependency-plugin:2.8:tree (default-cli) @ my-core-feature-with-optionals ---
[INFO] com.syalioune:my-core-feature-with-optionals:jar:1.0
[INFO] +- com.syalioune:my-orm-with-optionals:jar:1.0:compile
[INFO] \- com.syalioune.db.driver:my-db-driver-c:jar:1.0:compile
```

---

# Summary

* 💡 **[Possible] Use cases**
    * Lighten your final package by not including unnecessary transitive packages

* 🤔 **Alternatives**
    * Rework `my-orm` architecture to not directly depends on implementations

{{% /section %}}
