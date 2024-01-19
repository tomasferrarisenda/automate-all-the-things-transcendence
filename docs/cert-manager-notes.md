# Cert-Manager Notes

## Staging And Production Issuers
Let's Encrypt offers two types of issuers for their SSL/TLS certificates: staging and production. These issuers serve different purposes in the certificate issuing process.

#### Staging Issuer:
**Purpose**: Primarily used for testing and development purposes.
**Rate Limits**: More lenient, allowing for frequent generation of certificates without hitting rate limits that are imposed in the production environment.
**Trust Level**: Certificates issued by the staging issuer are not trusted by browsers or operating systems, meaning they will generally trigger security warnings if used in a live environment.
**Use Case**: Ideal for developers to ensure their systems are correctly configured for SSL/TLS without the risk of hitting rate limits or impacting live environments.

#### Production Issuer:
**Purpose**: Used for issuing certificates intended for live, public-facing websites.
**Rate Limits**: Stricter rate limits compared to the staging environment. This is to prevent abuse and to manage the load on Let's Encrypt servers.
**Trust Level**: Certificates issued are trusted by most browsers and operating systems, ensuring secure, encrypted connections without warnings.
**Use Case**: Should be used when you are ready to deploy a secure website to the public.

In summary, the staging issuer is for testing and development, with more relaxed rate limits and untrusted certificates, while the production issuer is for live websites, with trusted certificates but stricter rate limits.

## DNSSEC Issue
<!-- https://youtu.be/13ZpNsr4NBk?t=102&si=KrC2PGI0io6QPInb -->
<!-- https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-configure-dnssec.html#domain-configure-dnssec-adding-keys -->


## Secrets
A thing that confused me a lot were all the secrets created in the Cert-Manager process. the Here's a concise explanation of the three different types of secrets used in Cert-Manager with the ACME protocol:

### ACME Account Private Key Secret (privateKeySecretRef in ClusterIssuer)
**Purpose**: Stores the private key for the ACME account used to authenticate with the ACME server (like Let's Encrypt).<br>
**Usage**: Used by Cert-Manager to sign requests to the ACME server, ensuring secure and authenticated communication for operations like requesting and renewing certificates.

### Certificate Secret (secretName in Certificate)
**Purpose**: Holds the TLS certificate and its corresponding private key issued for a specific domain (e.g., example.com).<br>
**Usage**: Used by Kubernetes resources like Ingress controllers to enable TLS/SSL encryption for services. It's the certificate actually used in your environment for securing traffic. This is the one the Gatwway object will use.

### Temporary Secret for CertificateRequest
**Purpose**: Temporarily stores the private key used to generate the Certificate Signing Request (CSR) for a particular CertificateRequest.<br>
**Usage**: The private key in this secret is used to create the CSR sent to the ACME server for the issuance of a certificate. Post-issuance, this secret's role is typically concluded.