# Security Tool Findings Tables

Below are the detailed security findings categorized by the scanning tool and security phase. This format is easily copy-pasteable into Excel, or you can view it directly as Markdown.

## 1. Secrets Scanning (Gitleaks)
| Vulnerability ID | Key Finding | Service | Impact | Recommendation | Severity | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| AWS-ACCESS-KEY | 8 Hard-coded keys/tokens detected | Product Service | Complete AWS Compromise | Use Environment Variables | CRITICAL | ✅ Remediated |

## 2. SAST - Static Application Security Testing (Semgrep / Bandit)
| Vulnerability ID | Key Finding | Service | Impact | Recommendation | Severity | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| CWE-78 (RCE) | Remote Code Execution (eval) detected | User Service | Server Takeover | Remove `eval()` functions | HIGH | ✅ Remediated |

## 3. SCA - Software Composition Analysis (Trivy)
| Vulnerability ID | Key Finding | Service | Impact | Recommendation | Severity | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| CVE-2026-23745 | Multiple vulnerable NPM packages | Payment Service | Arbitrary File Overwrite | Upgrade `node-tar` to 7.5.3+ | HIGH | ⚠️ Pending Patch |

## 4. Container Image Security (Trivy)
| Vulnerability ID | Key Finding | Service | Impact | Recommendation | Severity | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| CVE-2026-27135 | OS-level vulnerabilities found in Node:slim base | Gateway (Nginx) | Denial of Service | Update Nginx to latest Alpine | HIGH | ⚠️ Update Base Image |

## 5. DAST - Dynamic Application Security Testing (OWASP ZAP)
| Vulnerability ID | Key Finding | Service | Impact | Recommendation | Severity | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 10038 (CSP) | Missing Security Headers (CSP, X-Frame) | API Gateway | XSS Vulnerability | Implement Content Security Policy | MEDIUM | ⚠️ Config Update Req |

## 6. IaC - Infrastructure as Code Security (Trivy)
| Vulnerability ID | Key Finding | Service | Impact | Recommendation | Severity | Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| N/A | 0 High-severity misconfigurations found | Global/Docker | N/A | N/A | LOW | ✅ Passed |
