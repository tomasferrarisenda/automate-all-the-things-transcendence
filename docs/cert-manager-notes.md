# Cert-Manager Notes

## Secrets
A thing that confused me a lot were all the secrets created in the Cert-Manager process. the Here's a concise explanation of the three different types of secrets used in Cert-Manager with the ACME protocol:

### ACME Account Private Key Secret (privateKeySecretRef in ClusterIssuer)
**Purpose**: Stores the private key for the ACME account used to authenticate with the ACME server (like Let's Encrypt).
**Usage**: Used by Cert-Manager to sign requests to the ACME server, ensuring secure and authenticated communication for operations like requesting and renewing certificates.

### Certificate Secret (secretName in Certificate)
**Purpose**: Holds the TLS certificate and its corresponding private key issued for a specific domain (e.g., tferrari.com).
**Usage**: Used by Kubernetes resources like Ingress controllers to enable TLS/SSL encryption for services. It's the certificate actually used in your environment for securing traffic. This is the one the Gatwway object will use.

### Temporary Secret for CertificateRequest
**Purpose**: Temporarily stores the private key used to generate the Certificate Signing Request (CSR) for a particular CertificateRequest.
**Usage**: The private key in this secret is used to create the CSR sent to the ACME server for the issuance of a certificate. Post-issuance, this secret's role is typically concluded.