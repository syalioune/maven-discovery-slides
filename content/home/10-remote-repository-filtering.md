+++
weight = 41
+++

{{% section %}}

# Problem statement

![maven-dependency-resolver](maven-dependency-resolver.png)

_Maven_ **loop over all declared repositories** until it finds one containing your artifacts.

This can be problematic, especially if you use **more than one** remote repositories :
* It can **slow your build** as _Maven_ can perform **useless N-1** HTTP requests
* It can **leak information** about your internal libs (i.e. _GAV_ parameters) to external entities

---

# Remote Repository Filtering (since _Maven_ `3.9.0`)

[Remote repository filtering](https://maven.apache.org/resolver/remote-repository-filtering.html) (_RRF_) is a _Maven_ feature that enables you to influence maven artifact download by targeting the correct remote repository.

With this feature you can enable **two filters** to instruct _Maven_ about the correct path to follow depending on the artifact coordinates.

![rrf-filters-configuration](rrf-filters-configuration.png)

---

# Prefix filter

It works by providing a **prefix file** containing artifact paths prefixes (e.g. `/com/foo`) of all artifacts the remote repository is susceptible to contain.

**Remote repositories usually generate and expose those prefix files that you can download.**

```
/abbot/test
```

To use this filter, you must :

1. Enable the filter : `-Daether.remoteRepositoryFilter.prefixes=true`
2. Provide a filter base dir : `-Daether.remoteRepositoryFilter.prefixes.basedir=<path>`
3. Provide prefix files : `prefixes-${remoteRepository.id}.txt`

ℹ️ **Any remote that do not have a prefix file is not filtered** ℹ️

---

# GroupId filter

It works by providing **a list of authorized groupId per remote repositories** allowing stronger constraints than _prefix_ filter.

```
com.syalioune.gcp
```

To use this filter, you must :

1. Enable the filter : `-Daether.remoteRepositoryFilter.groupId=true`
2. Provide a filter base dir : `-Daether.remoteRepositoryFilter.groupId.basedir=<path>`
3. Provide prefix files : `groupId-${remoteRepository.id}.txt`

ℹ️ **Any remote that do not have a groupId file is not filtered** ℹ️

---

# Summary

* 💡 **[Possible] Use cases**
    * **Accelerate your build** and **prevent artifact leaking** when you use **multiple repositories**
        * It can reduce your build time and bandwith by 50% (tested with 3 remote repositories & 3 artifacts)

* 🤔 **Alternatives**
    * Use a **virtual repository** grouping all your remote repositories

{{% /section %}}
