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

