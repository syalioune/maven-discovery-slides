+++
weight = 22
+++

{{% section %}}

# Problem statement

You often need to **connect to private repositories** or **corporate proxies** using different authentication mechanisms among which `passwords` , `passphrases` or `http tokens`.

```xml{5,6}
<settings>
    <servers>
        <server>
            <id>corporate_nexus</id>
            <username>user</username>
            <password>password123</password>
        </server>
    <servers>
</settings>
```

😬 **Do you version `settings.xml` files like the one above ¯\\\_(ツ)\_/¯ ?** 😬

---

# Settings encryption (since 2.1.0)

_Maven_ allow server credentials encryption in the `settings.xml` file (see [Password encryption](https://maven.apache.org/guides/mini/guide-encryption.html)).

This is especially useful when the `settings.xml` file :
* Is **shared between multiple users / environments** (e.g. Stored in `VCS`)

* Contains **credentials with different access rights**
  * Read-Write (`RW`) credentials for **artifact publishing**
  * Read-Only (`RO`) credentials for **artifact downloading**

You can **encrypt `RW` credentials** and **share the master encryption password with only authorized users** (or on selected deployment contexts).

You can **leave the `RO` credentials unencrypted** for everyone to use.

---

# Settings encryption : How to

1. Set the master encryption password

```shell
mvn --encrypt-master-password
```

2. Create a `${user.home}/.m2/settings-security.xml` file

```xml
<settingsSecurity>
  <master>changeme:output_from_previous_command</master>
</settingsSecurity>
```

3. Encrypt sensible data using `mvn --encrypt-password` and write it into `settings.xml`

4. Version the `settings.xml`

---

# Caveat

<img src="https://gifdb.com/images/high/tired-whining-baby-u26hzjfrbnutfmbg.gif" width="400px" height="200px" style="display:block;margin:0 auto;"/>

Maven [DefaultSettingsDecrypter](https://github.com/apache/maven/blob/master/maven-settings-builder/src/main/java/org/apache/maven/settings/crypto/DefaultSettingsDecrypter.java#L52-L106) components **only decrypts** :

* `//settings/servers/server/password`

* `//settings/servers/server/passphrase`

* `//settings/proxies/proxy/password`

ℹ️ Those tags will be **decrypted** as long as the correct `${user.home}/.m2/settings-security.xml` file is present ℹ️

---

# Summary

* 💡 **[Possible] Use cases**
    * **Sharing, versionning and securing** a single `settings.xml` file across team members, users and environment

* 🤔 **Alternatives**
    * Managing different `settings.xml` depending on the environment
      * One file shared by developers with `RO` credentials
      * One file stored in CI boxes containing `RW` credentials


{{% /section %}}