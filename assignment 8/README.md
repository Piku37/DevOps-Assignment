# Ollama on Kubernetes 



## Create a kubernetes cluster

1. create kind cluster with default configurations
```
kind create cluster
```

2. create ollama deployment resource
    
    a. use official ollama base image

    b. created a volume to store model data. Here used emptyDir but a persistent storage can be used as well

    c. Using init container to download required model before the main container starts. Also called pre-load. Model is stored in volume created in step b.

    d. Main container ( ollama serve ) starts after init-container finishes and reads the model again from the volume created in step b and populated in step c.

    e. Service of kind NodePort is used to expose ollama service.

    ```
    kubectl apply -f ollama.yaml
    ```


3. Run model

    ```
    $ollama run llama3.2 "what comes before Monday and after Monday"
    
    The answer is Tuesday.

    - Before Monday, it's Sunday (or the previous day of the week).
    - After Monday, it's Tuesday.
    ```
     
