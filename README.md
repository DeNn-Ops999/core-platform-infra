# Core Platform Infrastructure (Reference Configs)

Sanitized infrastructure configurations, Helm charts, CI/CD templates, and observability rules used for running a B2B SaaS platform on **AWS** and **Kubernetes (k3s)**.

## Stack & Structure

* **`nginx/`** — Edge reverse-proxy & upstream keepalive configuration (with tuned timeouts and proper `X-Forwarded-*` headers).
* **`charts/core-service/`** — Universal Helm chart for microservices (non-root `securityContext`, native `preStop` sleep hook, `PodDisruptionBudget`, named ports).
* **`terraform/`** — Terraform 1.10+ configuration with S3 native state locking (`use_lockfile = true`) and AWS OIDC trust policies for GitLab CI.
* **`ansible/`** — Node bootstrap playbooks with `aws_ec2` dynamic inventory and kernel/network hardening.
* **`ci/`** — GitLab CI pipeline templates using Rootless BuildKit and safe Alembic database migrations.
* **`observability/`** — Prometheus alerting rules (SLO burn-rate, OOM, CPU throttling) and Grafana Alloy log collection pipeline.
