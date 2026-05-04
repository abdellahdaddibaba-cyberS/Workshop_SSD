# DevSecOps Pipeline: Runtime Secrets Management Report
**Step 8 Implementation**

## 1. Executive Summary
This report documents the remediation of hard-coded sensitive information within the SecureShop microservices architecture. By moving secrets from static files to a dynamic runtime environment, we have significantly reduced the attack surface and ensured compliance with industry security standards (OWASP, NIST).

## 2. Identified Vulnerabilities (Before)
During the initial audit, the following critical misconfigurations were identified:
- **DB Password**: Hard-coded in `docker-compose.yml`.
- **JWT Key**: Defined as a string constant in `user-service/main.py`.
- **RabbitMQ Credentials**: Exposed in plain text within `order-service` environment configs.
- **SMTP Password**: Stored directly in the `notification-service` source code.

## 3. Implemented Solutions (After)

### A. Centralized Environment Configuration
All sensitive values were moved to a root `.env` file. This file acts as the "Source of Truth" for secrets and is excluded from Git to prevent accidental leaks.
- **File**: `/.env`
- **Managed Secrets**: `DB_PASSWORD`, `JWT_SECRET`, `RABBITMQ_PASS`, `SMTP_PASS`.

### B. Secure Orchestration
The `docker-compose.yml` was updated to use **variable substitution**. This ensures that the orchestration file contains only logic, not data.
```yaml
environment:
  - DB_PASSWORD=${DB_PASSWORD}
  - JWT_SECRET=${JWT_SECRET}
```

### C. Secure Code Implementation
Microservices were refactored to use the `os.getenv()` method. This ensures that the application only receives sensitive data at the moment it starts up.
```python
import os
# SECURE: Secret is retrieved from the OS environment, not the code
JWT_SECRET = os.getenv("JWT_SECRET")
```

## 4. Verification Results
- **Secret Scanning (Step 3)**: Gitleaks now returns 0 findings for the updated code files.
- **IaC Scanning (Step 7)**: Trivy config scan confirms no plain-text passwords in Docker/Compose files.
- **Functional Check**: Services successfully initialize by reading injected environment variables.

## 5. Conclusion
The "Secrets-in-Code" vulnerability has been fully remediated. The project now follows the **Twelve-Factor App** methodology for secure configuration management.
