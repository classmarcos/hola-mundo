# Hola Mundo

Práctica de flujo con Pull Requests, CI y despliegue a staging (`:8001`) y producción (`:8000`).

```bash
pip install -r requirements-dev.txt
pytest -q
uvicorn app.main:app --reload
```

Ver [CONTRIBUTING.md](CONTRIBUTING.md) para el flujo de trabajo.
