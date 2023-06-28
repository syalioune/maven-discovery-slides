+++
weight = 31
+++

{{% section %}}

# Problem statement

**You want to use settings encryption** to secure access to your [gitlab hosted maven private registry](https://docs.gitlab.com/ee/user/packages/maven_repository/#publish-to-the-gitlab-package-registry).

However Gitlab authentication method rely on `HTTP token`...

```xml{5-10}
<servers>
    <server>
        <id>wagon</id>
        <configuration>
            <httpHeaders>
                <property>
                    <name>Private-Token</name>
                    <value>changeme</value>
                </property>
            </httpHeaders>
        </configuration>
    </server>
</servers>
```

💡 **You can file an issue / submit a PR to _Maven_ maintainers or...**

---

# _Maven_ extension (since always 🤔 ?)

You can use/create a [Maven extension](https://maven.apache.org/guides/mini/guide-using-extensions.html) that allows you to hook into maven **inner execution lifecycle**.

![maven-settings-header-extension](maven-settings-header-extension.png)


🔥 **You can completly alter maven behavior with extensions** 🔥

---

# How to

1. Encrypt your HTTP headers values as described in [encryption guide](https://maven.apache.org/guides/mini/guide-encryption.html)

2. Define a `${projectRoot}/.mvn/extensions.xml` file containing

```xml
<extensions>
    <extension>
        <groupId>io.gitlab.syalioune</groupId>
        <artifactId>maven-settings-header-encryption</artifactId>
        <version>1.0.0</version>
    </extension>
</extensions>
```

🦚 https://gitlab.com/syalioune/maven-settings-header-encryption 🦚

---

# Summary

* 💡 **[Possible] Use cases** 
    * Extending maven without bloating the core codebase
    * Problems **very specific** to your context

* 🤔 **Alternatives**
    * _Maven_ plugins
    * _Maven_ enhancements through _PR_
    * Solutions outside maven scope (e.g. environment variables) 


{{% /section %}}
