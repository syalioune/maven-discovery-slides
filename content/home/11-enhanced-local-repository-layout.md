+++
weight = 42
+++

{{% section %}}

# Initial situation

_Maven_ uses a standard local repository layout based on `GAV` coordinates.

A dependency with the following `GAV`

```xml{}
<dependency>
    <groupId>io.gitlab.syalioune</groupId>
    <artifactId>maven-settings-header-encryption</artifactId>
    <version>1.0.0</version>
</dependency>
```

result in the following tree

![standard-m2-repository-layout](standard-m2-repository-layout.png)

---

# Enhanced local repository layout (Since _Maven_ `3.9.0`)

This standard layout can be **altered** by configuring [maven enhanced local repository manager](https://maven.apache.org/resolver/local-repository.html).
This enables the following **theoritical** use cases :

* **Enhanced transparency** by being able to simply differentiate
  * Artifacts **built locally** vs Artifacts **downloaded from remote repositories** : You can clean local artifacts without re-downloading the entire internet

  * Artifacts downloaded from remote repositories by **origins** : You can clean all artifacts from a specific repository

* **Simplified branch development** : i.e working on branches producing artifact with the same coordinates
  * Isolating locally built artifacts by branches

  * Being able to compare results from different branches without overwriting them

---

# Enhanced transparency use case

```shell{}
mvn clean install -Daether.enhancedLocalRepository.split=true \ 
-Daether.enhancedLocalRepository.splitRemoteRepository=true \
-Daether.enhancedLocalRepository.splitRemote=true \
-Daether.enhancedLocalRepository.localPrefix=breizhcamp/local \
-Daether.enhancedLocalRepository.remotePrefix=breizhcamp/remote
```

Results in the following layout

```shell{2,6,7,8,10,11}      
├── local                                                                                                    
│   └── com                                                                                                  
│       └──syalioune 
│           └── settings-encryption                                                                      
└── remote                                                                                                   
    ├── central                                                                                              
    │   └── releases                                                                                         
    │       ├── aopalliance 
    ├── gcp-artifact-registry-ro                                                                             
    │   └── releases                                                                                         
    │       └── com                                                                                          
    │           └── syalioune                                                                                
```

---

# Branch development

```shell{4}
mvn clean install -Daether.enhancedLocalRepository.split=true \
-Daether.enhancedLocalRepository.splitRemoteRepository=true \
-Daether.enhancedLocalRepository.splitRemote=true \
-Daether.enhancedLocalRepository.localPrefix=breizhcamp/local/<branch> \
-Daether.enhancedLocalRepository.remotePrefix=breizhcamp/remote
```

Results in the following layout

```shell{1-4,6,7,8,10}      
├── local
│   ├── feature-A
│       └── com
│           └── syalioune
│               ├── repository-layout
│   └── feature-B
│       └── com
│           └── syalioune
│               ├── repository-layout
└── remote
    ├── central
    ├── gcp-artifact-registry-ro                                                                           
```


---

# Summary

* 💡 **[Possible] Use cases**
    * Enhanced transparency
    * Fast and precise cleanup
    * Branch development

* **🤔 Alternatives**
  * Change manually your local repository path using `settings.xml` or `-Dmaven.repo.local`

{{% /section %}}
