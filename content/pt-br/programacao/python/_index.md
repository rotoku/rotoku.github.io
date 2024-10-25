---
title: "Python"
linkTitle: "Python"
weight: 2
---

---

---

---

# Python

## Multiparadigma

- procedural
- orientação a objetos
- funcional

## Criando ambiente virtual para teste local sem poluir ambiente global

> Exemplo utilizando Python 3.10.6

```bash
alias python=python3.10
pip install virtualenv --user
mkdir <MY_PROJECT_NAME>
cd <MY_PROJECT_NAME>
virtualenv venv --python=python3.10
source venv/bin/activate
```
