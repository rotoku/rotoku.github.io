---
title: "CKS"
linkTitle: "CKS"
date: 2024-02-14
weight: 3
---

# Certified Kubernetes Security (CKS)

## 1. Introduction

## 2. Understanding the Kubernetes Attack Surface
- The Attack
- The 4C's of cloud native security
    - cloud
    - container
    - code
    - cluster

## 3. Cluster Setup and Hardening
- CIS Benchmarks
- Authentication
- Authorization
- Service Accounts
- TLS in Kubernetes
- Protect node metadata and endpoints
- Securing the Kubernetes Dashboard
- Verifyng Platform Binaries
- Upgrade Kubernetes Frequently
- Network Policies
- Securing Ingress

## 4. System Hardening
- Minimize host OS Footprint
- Limit Node Access
- SSH Hardening
- Privilege Escalation in Linux
- Remove obsolete Packages & Services
- Restrict Kernel Modules
- Identify and disable open ports
- Minimize IAM Roles
- UFW Firewall Basics
- Restricting syscalls using seccomp
- Seccompo in Kubernetes
- Kernel Hardening Tools - AppArmor & SecComp

## 5. Minimize Microservice Vulnerabilities
- Admission Controllers
- Pod Security Policies
- Open Policy Agent
- managing Kubernetes Secrets
- Container Runtime Sandbox
- Implement Pod to Pod Encryption by use of mTLS

## 6. Supply Chain Security
- Minimize Base Image Footprint
- Image Security
- Secure your supply chain
- Use static analysis of workloads
- Scan images for known vulnerabilities

## 7. Monitoring, Logging and Runtime Security
- Detec malicious activities
- Detect Threats
- Detect all phases of attacks
- Perform deep analytical investigation
- Immutability of containers
- Use audit logs to monitor access

## 8. Mock Exams
- Mock 01
- Mock 02
- Mock 03



curl https://127.0.0.1:45025/api/v1/pods \
    --key admin.key \
    --cert admin.crt \
    --cacert ca.crt


echo "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJTGtIZmp5QzdaOGN3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBNU1EWXhORE01TlROYUZ3MHpOVEE1TURReE5EUTBOVE5hTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURFNVB4eG5iTHBQZjlUMVlia0NlQkwyck80R1QvRU5hdGxrdFpWMlg5UXROR2tSNEc3cUlZU0FDemUKRTZkd2tFd0FydnVnMEtnU1FIKzBtTjV4ckVVYnZjc2FGUlBZNVNRYlE4T2JQSGM0d0FPcUMwaTRDOXUyN3d3dgpEZ0NsVWlnN0RkNmwra0tWTVlIUFVlWEpwVEdkYy95WkgwTzdwSW9obEFSOG84ZDMvVGQwZzZaZ3NjcVFhYUlECncxdFZ5cmdDc3ZISTJiZ0x0YTc0b2VSczN3c3QrQkYwTUo0L0lvSWxDemRHV3JBZXZ0NUhJRGtaQy9JenFFb1MKT1oxRlV1YmNDM3JpRkUrY01tcU91enlRY2t5VjdxYXVzYmFhM1dkNHJyTEt3Q3dQQ2d5VWxJdUZMQStSeXR0LwpSU1pQay9mTURPV1p6OEJXSWhMQnpGcWZFaENqQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJUeHZuVDhSV3Nna3V5bDYwQkFVUTlRaEI0NTRqQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQmR0U1hNRlZsLwpXUkpVK1MrcHVFbThBYTF1QjB3d28zM1BCT1VBc3VFVTJRWVZHMUx4QXZyaFV5c05HR0cyZEpUUk1jYnNGNk1BCkFiRU82TndzclIrMjUxTFhjb2xkMGhhWEtZN3J2NlR0eUc0bUVIN3l6SzJLWXdGbXM1dDJNVXFUZ3dLcnczM1AKQkRiNjkzL1VqcXVwcjgzWmpnSURCZWJqYVliQ3ZQbmpENHk1UzdMcExqL3o5WnA5TVUyd21QdGR6Z29uRVgrdwpyZ0d4NUdIRlgya3dXVG8vcHN3b0FVV3pmOUlaYUladzlBNmlqVkU0ek9KR2sxSEhmVnZicVJlbEY0UU9PZmUyCnR2ZTcyRFNlRDI0TkkvYm1WQktVOUxKY1V5enNzRVdqNjZjN3dOQXBDSkdhNEFOMHNETis3alF1TE4wdmEwQnQKZUovVXBNa3YzOUhICi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K" | base64 -d > ca.crt

echo "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURLVENDQWhHZ0F3SUJBZ0lJRFNwWFJpYWJpbE13RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBNU1EWXhORE01TlROYUZ3MHlOakE1TURZeE5EUTBOVE5hTUR3eApIekFkQmdOVkJBb1RGbXQxWW1WaFpHMDZZMngxYzNSbGNpMWhaRzFwYm5NeEdUQVhCZ05WQkFNVEVHdDFZbVZ5CmJtVjBaWE10WVdSdGFXNHdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDdjZKbXYKNmx1Y3RXaVVFWXV2ODNQTkZWamc2QVFJY0p6Y2grZXpuOS9JRFVSYWhoZys2bTgwTHJXb3JKUUZkaDEvbmZGQQpveFp1ZjFVaXE5K2JjT0FxMHNEZjJIeTc2YWFha2IxRjhYK09qTVc3YS9CMUxCT1cvVDgrdVdwT1NpV3VGZW9zCjl0ZUdYUGFoSmpnMHB5VDZOMzFhLzlxOFVwR2hyU1JHODB1ajA3N21yM2VqZ1ZrdjBCbUlvQzRCNlM0Qndnc2EKdmZvWjZTOXA5eGFZeHVmRlY5QnkzZEU1WVdHS3BCUkROcWx0WTRrb0w0aktuakhLbnRpRjF3NFNzaUdDMVRqeQp5ejVkamRsZCttVW02bGxhOVp3eXV0anN1anNCWlpEMHV5cktNa0RXTWRKQUxIOEpjM0xuL0VZL0QzQk1Xa3VHCkpXT0s0RDJIMlArS1RwVGZBZ01CQUFHalZqQlVNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUsKQmdnckJnRUZCUWNEQWpBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRlBHK2RQeEZheUNTN0tYcgpRRUJSRDFDRUhqbmlNQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUIvYmtwTlRFNHZOcVkzMWdJQVY3OWZJNkovCit3UFg0UUovemtBMldWTEE4WUZVWFRBWGFNYTBUL0dTK01QQ3ZHb0xJOEJvSElzUTlDRjVVdHdtNGhja1Jkc0kKZDBJcldFQ1ljbVNYbE1uT1Z1NDlhNExXNy9hMGdsaEp2eWZLUnVRVFduaFZ6TS83Z09xWjBSRy9LdUp1WnJjNQpEam5iVnFLS2w2bEZoY0R5MFFObU5iMGpoRGpYT3kwMWtjUG9VWk85RmNDTnM2MktOc21RSWdOSkxwUTNaV2hTCm9qU2ladm5vVzA2R2U5NGgrQm1qWld2ZGlrWXhSeXFyY0lEUHhuOW0zVFdqc2dQbnJOYUl0eDI2WkpWNHdkQmQKQWF0SDE0c1ZZSmlRS0Y4TFc4WHMzRCtFd2w1Q3JYM0VrcGhlZk04dG40SFFyOHp0aGFJeDFXUVJNSUlaCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K" | base64 -d > admin.crt

echo "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBcitpWnIrcGJuTFZvbEJHTHIvTnp6UlZZNE9nRUNIQ2MzSWZuczUvZnlBMUVXb1lZClB1cHZOQzYxcUt5VUJYWWRmNTN4UUtNV2JuOVZJcXZmbTNEZ0t0TEEzOWg4dSttbW1wRzlSZkYvam96RnUydncKZFN3VGx2MC9QcmxxVGtvbHJoWHFMUGJYaGx6Mm9TWTROS2NrK2pkOVd2L2F2RktSb2Ewa1J2TkxvOU8rNXE5MwpvNEZaTDlBWmlLQXVBZWt1QWNJTEdyMzZHZWt2YWZjV21NYm54VmZRY3QzUk9XRmhpcVFVUXphcGJXT0pLQytJCnlwNHh5cDdZaGRjT0VySWhndFU0OHNzK1hZM1pYZnBsSnVwWld2V2NNcnJZN0xvN0FXV1E5THNxeWpKQTFqSFMKUUN4L0NYTnk1L3hHUHc5d1RGcExoaVZqaXVBOWg5ai9pazZVM3dJREFRQUJBb0lCQUFpWk9wWDJRemNrU1BIZgo3NitRbTJyOWJhUkV3eG0wZzM1bUtFWEgvVlRXalM1Tm1yYk1sOVg1cUlpUHN3YVhVUGJSZmg3Mk9kejUzV3Y5CjhjYXozRWxMbHdENklKTEE1NU5ycDFCWmJ5NUZKRTgyaGdEOFFCTGoyeWtTUUNlR2lWUDZuMEZHYVorWVFMZjgKMmNkOUdob2ZCMElnK295MURvaFVJYzlVQ2pEK1RuaWpPR1g2KzNydFlabysvb25FNTEzQjNDa0k5WUVZazNjVQppSmQ4ZmRQVlgzb203b1lseVRlUmJ6ckYyU0FOSEVjaE9EYzlDRFNmVUlUVkU4Ykd6UERkUERHVll5S0JLOVI4CkFFdS9STllNSmxuTFJXSFZabkhsQnBFU094enZLeWx2V3JpV0RoWGhmV05RdjFVK2NXNGpwMDlaM2I0ZXIvc2kKbTh0bXZZVUNnWUVBMlNYV1ZwbEFUVDUzdnUyQmpNcEVDQnUrSG8xN3dlWCtoSlpzU0pmTzlzVk1oYld2NE1NWgpZMkNCM1NXaFIvRFBhN1J2bndha01uOXhWT244bXYwbFdOTHVXU0RSclJyN2Z2UHlYYUxma21ueGR2YVpXb2UzCjRjRHFIR1pCWmRQbWM5U0kxUXJPbXlFN0loc1NsaTR6d01sVEJFcDVCaUJTZzBkNlgvUi9KVTBDZ1lFQXoySGIKVXVPMHJ1NkU4Vm5TeFIzMU5hc2FCc1dCOGxyVDR5YjRsME1XN0NPMWhWcFZ1TUd4cGVtc0NtMkhwTnhxTnV6UgpSRHJkMzFzeTIyR01wVnhpNUhHT1U1YU5xd0FqenF5eEpGZ3FOMUF4ZHNwSkhjV1oxelhsYkNoeGhnN0VUU05YCmk3S0hISWZDYkU1U0NxLzdaYUJGRGdQcmtYcjdNeUluenhlcVhOc0NnWUVBMStpYVRMTEdUOGViOHRoZXBxbDYKcVlGRU1VYkdWYzRrbXBxaWdpK0hsckFvWFE2QkdQK0VIOTZXWVZnSUcrcmhvcHJmSFlUU0FHL2ROT3dPd2VDUQpvTmZpSy9iSTVORGVYYVdiUitVcFhZQS9tZVNxS0d5bnRpMUYyZ1VHWTRRbE1PaVRRUmtrd3ZSd3dvR2VvbnEvCjlLRjVETndycDU2OXpGQm02ai9GcUVVQ2dZQW1BcDJjZDdmcVNEVjl0eVQybENNWmp4N2FGdUZXZG1kWHZ4RFoKU0thdTZXeWY0SXJOcmxMTlFpTVNWamtDY3BQVk5WcTEwc1JQNS90T1VuYmc2Q29JRFBnMVFlYjliSzBqZUd1UAphY2x6RWZPKy9oeWdwRk1xS3VxK0JEdXFncEpnUVJZT3VNNGk0STgySXJUTzJLcVBXZXpPUU5Hd2ZJWUdQVUJtCnFNUEUrUUtCZ1FDMVBOMnp6ZUVSZ2xMMzhKSXlZSUVJTGd0Z2hPK3BUbWdpMjB3cE9ITlc5a1hSR2IvaGJWQWoKdXJwMkVJQlBPSTlUWkpMNmZKdm9JRW53K2NmNHBYekRlTnBPWEdqOGVwNFQ1Mnl1TE9RaDBja0wrekdBL3pGNAplTHJxd0hGNlhvREV5MXF2SlYxQU91czQ4SHVST01sTUFpazJmZWxRK2NsSmh4cU1Ca2Y3Qnc9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=" | base64 -d > admin.key


## What is the Common Name (CN) configured on the Kube API Server Certificate?
```
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

openssl x509 -in /etc/kubernetes/pki/etcd/peer.crt -text -noout

openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

openssl x509 -in /etc/kubernetes/pki/ca.crt -text -noout
```

```
# Get Certificates
kubectl get csr

# Aprove Certificates
kubectl certificate approce jane


echo "LSJNBDNSDJNSJCJSNLCJKSLSNLN" | base64 -d
```

## ${HOME}/.kube/config
```
apiVersion: v1
current-context: kind-kumabes-cluster
kind: Config
preferences: {}
clusters:
- cluster:
    ## certificate-authority: /etc/kubernetes/pki/ca.crt
    certificate-authority-data: <CERT>
    server: https://127.0.0.1:45025
  name: kind-kumabes-cluster
users:
- name: kind-kumabes-cluster
  user:
    client-certificate-data: <CERT>
    client-key-data: <CERT>
contexts:
- context:
    cluster: kind-kumabes-cluster
    user: kind-kumabes-cluster
  name: kind-kumabes-cluster

```

kubectl get pods --kubeconfig ${HOME}/.kube/config/custom/config.yaml

k config get-contexts
k config use-context kind-kumabes-cluster
k config current-context


```
docker run --name tracee --rm --privileged --pid=host \
    -v /lib/modules:/lib/modules:ro \
    -v /usr/src:/usr/src:ro \
    -v /tmp/tracee:/tmp/tracee \
    aquasec/tracee:0.4.0 \
    --trace container=new

```    