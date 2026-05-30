# Ansible Playbooks

A collection of reusable Ansible playbooks for server management and configuration.

## Requirements

- Ansible 2.9+
- SSH access to target hosts

## Installation

```bash
pip install ansible ansible-lint
```

## Playbooks

### playbook.yaml

General purpose playbook that:
- Ensures required packages are installed/uninstalled
- Sets the group for the `ansible` user on servers
- Checks MySQL server status

```bash
ansible-playbook -i inventory playbook.yaml
```

### ubuntu.yaml

Keeps Ubuntu/Debian/Raspbian systems updated with latest packages.

```bash
ansible-playbook -i inventory ubuntu.yaml
```

### python.yaml

Prepares systems for Python compilation:
- Installs build dependencies (gcc, make, zlib, libssl, etc.)
- Downloads Python 3.13.3 source code
- Does not compile (manual step required)

```bash
ansible-playbook -i inventory python.yaml
```

### mysql.yaml

MySQL server management playbook.

### all_facts.yaml / host_info.yaml

Gather and display system facts from target hosts.

## Usage

```bash
# Run playbook against inventory
ansible-playbook -i inventory <playbook.yaml>

# Run with verbose output
ansible-playbook -i inventory <playbook.yaml> -v

# Dry run (check mode)
ansible-playbook -i inventory <playbook.yaml> --check
```

## Linting

```bash
pip install ansible-lint
ansible-lint <playbook>
```
