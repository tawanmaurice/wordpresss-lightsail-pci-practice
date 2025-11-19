PCI DSS Web Application Security Project — README

A complete multi-tool security assessment workflow performed on:
https://wp.98-89-111-197.sslip.io

📌 Overview

This project demonstrates a full external web application security assessment aligned with PCI DSS Requirements 1, 2, 4, 5, 6, and 11.
The assessment was performed on a live WordPress site hosted on AWS Lightsail using HTTPS and a Let’s Encrypt certificate.

This README includes:

Tools used

What each tool checks

Key findings

Fix recommendations

Next steps for PCI readiness

This document is designed to show technical proficiency and serve as a portfolio piece for clients, employers, or certification prep.

🧰 Tools Used and What They Do
1. Nmap

Purpose: Network discovery, open port detection, OS fingerprinting, TLS enumeration
Checks PCI DSS: Req. 1 & 11

Commands included SYN scan, service scan, OS detection, UDP scan, and NSE scripts.

2. Nikto

Purpose: Web server security testing
Checks PCI DSS: Req. 6.5, 11.2
Finds outdated versions, misconfigs, and dangerous server behavior.

3. WPScan

Purpose: WordPress vulnerability scanner
Checks PCI DSS: Req. 6.3, 6.5
Includes plugin/theme vulns, users enumeration, weak passwords, config issues.

4. OWASP ZAP (Automated Scan)

Purpose: Full active + passive vulnerability scan
Checks PCI DSS: Req. 6.5 & 11.3
Finds:

SQL injection

Missing anti-CSRF tokens

Weak cookies

Missing headers

XSS weaknesses

Information disclosure

Total ZAP Findings: 16 alerts across High/Medium/Low

5. SSL Labs (Qualys)

Purpose: TLS, certificate, encryption strength
Checks PCI DSS: Req. 4.1
Your Score: A

Strengths identified:

Strong TLS 1.2 / TLS 1.3

Strong ciphers

Modern certificate

No major protocol vulnerabilities

Improvements:

Enable HSTS for A+

Enable OCSP Stapling

Remove weak CBC ciphers (if possible)

6. SecurityHeaders.com

Purpose: Browser-side defense and security hardening
Checks PCI DSS: Req. 6.5 & 6.6
Your score: F (before fixes) — typical for new WordPress builds.

Missing headers:

HSTS

CSP

X-Frame-Options

X-Content-Type-Options

Referrer-Policy

Permissions-Policy

Fix recommended (Apache / .htaccess):

<IfModule mod_headers.c>
Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
Header always set Content-Security-Policy "default-src 'self' https: data: 'unsafe-inline'"
Header always set X-Frame-Options "SAMEORIGIN"
Header always set X-Content-Type-Options "nosniff"
Header always set Referrer-Policy "strict-origin-when-cross-origin"
Header always set Permissions-Policy "camera=(), microphone=(), geolocation=()"
</IfModule>

🧪 Summary of Key Findings
🔴 High-Risk Findings (From ZAP)

SQL Injection (Time-Based Analysis)

Missing Anti-CSRF Tokens

Cookies missing Secure and HttpOnly flags

Potential XSS vectors

🟧 Medium Findings

Missing CSP

Missing X-Frame-Options

Missing HSTS

Missing X-Content-Type-Options

Charset mismatch

Cache-control issues

Information disclosure

🟨 Low Findings

Browser caching warnings

HTML comments revealing internal details

General WordPress defaults

🛠️ Fix Recommendations (Short Version)
1. Add missing security headers

Add the .htaccess block shown earlier.

2. Configure WordPress security

Enforce SSL in admin

Install security plugin (Wordfence or Sucuri)

Disable XML-RPC if not used

Remove readme.html

Disable directory listing

Restrict wp-admin access if possible

3. Secure cookies

Add in wp-config.php:

@ini_set('session.cookie_httponly', true);
@ini_set('session.cookie_secure', true);

4. Mitigate SQLi & XSS warnings

Ensure database uses parameterized queries

Add CSP

Deploy WAF rules or Cloudflare security level high

5. Add HSTS

(Required for A+ TLS rating)

📈 Next Steps
1. Install ClamAV on your Lightsail instance

Purpose: Malware detection (PCI DSS Req. 5)

2. Apply security patches

After fixing headers + cookies > re-run all scanners.

3. Create a “Before vs After” comparison

Shows your improvement — strong for portfolio.

4. Run quarterly scans

Required by PCI DSS.

5. Document everything

This README is your base, now you can produce:

A polished client report

A professional PDF

A portfolio case study

pci-wordpress-lightsail-demo/
├── README.md
├── docs/
│   ├── methodology.md
│   ├── pci-mapping.md
│   └── hardening-steps.md
├── reports/
│   ├── zap-summary.md
│   ├── ssl-labs-summary.md
│   ├── security-headers-summary.md
│   └── wpscan-summary.md
└── screenshots/
    ├── zap-alerts.png
    ├── ssl-labs-grade.png
    └── securityheaders-grade.png

