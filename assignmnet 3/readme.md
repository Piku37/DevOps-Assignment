# 🔐 Security & Compliance in DevOps Workflows  
**Compliance Focus:** ISO 27001, GDPR, SOC 2  

---

## ✅ Deliverables  
- A document outlining three DevOps security risks and corresponding mitigation strategies  
- Explanation of security best practices in cloud deployments, including an Azure-specific example  

---

## 1. Risk: Hardcoded Secrets in Code Repositories

### Description  
Secrets such as API keys, database credentials, and tokens are sometimes hardcoded directly in source code, which can lead to inadvertent exposure if the code is pushed to public or even private repositories.

### Compliance Mapping  
- **ISO 27001**: A.9.2.3 – Management of privileged access rights  
- **SOC 2**: CC6.1 – Logical Access Security  
- **GDPR**: Article 32 – Security of processing  

### Mitigation Strategies  
- **Secret Management Tools**: Use solutions like HashiCorp Vault, AWS Secrets Manager, or **Azure Key Vault**.  
- **Environment Variables**: Supply secrets dynamically through environment variables rather than hardcoding them.  
- **Authentication Methods**: For service-to-service communications, utilize mTLS or token-based authentication over static credentials.  
- **Pre-Commit Scanning**: Implement pre-commit hooks (e.g., with `git-secrets` or `pre-commit`) to detect secret patterns before code is committed.

### Example (Using Azure Key Vault)  
```bash
export DB_PASSWORD=$(az keyvault secret show --name dbPassword --vault-name MyKeyVault --query value -o tsv)
```



## 2. Risk: Lack of Access Control in CI/CD Pipelines

### Description

CI/CD pipelines often run with elevated or overly broad access rights. If these pipelines are compromised, they can provide attackers with a larger attack surface for lateral movement and credential exfiltration.

### Compliance Mapping

- **ISO 27001**: A.9.4.1 – Information access restriction
- **SOC 2**: CC6.2 – System Operation and Monitoring
- **GDPR**: Article 25 – Data protection by design and default

### Mitigation Strategies

- **Principle of Least Privilege**: Limit pipeline permissions to only those necessary for their tasks.
- **Explicit Permission Settings**: Configure CI/CD tools (such as GitHub Actions) with explicit, minimal permissions.
- **Audit Logging**: Enable and monitor audit logs of the pipeline activities for anomaly detection.

```yaml
permissions:
  contents: read
  packages: write
  id-token: write  # This permission is only if OIDC is required

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      # Additional steps go here
```
### Description

Modern applications frequently integrate many third-party libraries and components. If these dependencies are not properly vetted or pinned, they may introduce vulnerabilities into your system.

### Compliance Mapping

- **ISO 27001**: A.12.6.1 – Management of technical vulnerabilities
- **SOC 2**: CC7.1 – Risk Mitigation
- **GDPR**: Article 32 – Risk assessment and mitigation

### Mitigation Strategies

- **Dependency Pinning**: Lock down dependency versions using files like `package-lock.json`, `requirements.txt`, etc.
- **Automated Vulnerability Scanning**: Utilize tools such as Trivy, Snyk, or GitHub Dependabot to identify potential issues.
- **SBOM (Software Bill of Materials)**: Generate and maintain an SBOM using tools like Syft or CycloneDX.
- **Regular Updates**: Establish a routine to update and assess dependency versions periodically.


## ☁️ Security Best Practices in Cloud Deployments

### General Best Practices

- **Identity and Access Management (IAM)**:

    - Adopt RBAC (Role-Based Access Control) with minimal privileges for all users and services.
- **Encryption**:

    - Use encryption at rest (e.g., KMS) and encryption in transit (TLS).
- **Centralized Logging & Monitoring**:

    - Implement centralized logging using tools such as AWS CloudWatch, Azure Monitor, or similar.
- **Network Segmentation**:

    - Use VPCs, subnets, firewalls, and NSGs (Network Security Groups) to segment and protect workloads.
- **Compliance as Code**:

    - Use policy-as-code tools (like Open Policy Agent, Azure Policy) to enforce compliance automatically.


### 🌐 Azure-Specific Best Practices

- **Azure Key Vault**:

    - Use to manage secrets, certificates, and keys securely.
- **Azure RBAC**:

    - Implement RBAC to ensure resources are only accessible to authorized users.
- **Azure Monitor & Log Analytics**:

    - Leverage these for real-time monitoring, logging, and threat detection.
- **Microsoft Defender for Cloud**:

    - Continuously assess and harden your resource configurations.
- **Azure Policy**:

    - Create policies to enforce resource configurations. For example, you can enforce tagging policies or require encryption for storage accounts.
- **Azure Blueprints**:

    - Use for orchestrating resource templates and governance policies across subscriptions.
 
```json
{
  "policyRule": {
    "if": {
      "field": "[concat('tags[', parameters('tagName'), ']')]",
      "exists": "false"
    },
    "then": {
      "effect": "deny"
    }
  },
  "parameters": {
    "tagName": {
      "type": "String",
      "metadata": {
        "description": "Name of the tag to enforce",
        "displayName": "Tag Name"
      }
    }
  }
}

```
