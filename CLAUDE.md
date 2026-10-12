# Hola Mundo — reglas para agentes de IA
- Trabajar SIEMPRE en una rama `ai/<tema>`. Nunca commit ni push a `main`.
- Antes de abrir el PR: `ruff format .`, `ruff check .`, `pytest -q`. Un PR = un tema.
- No modificar `.github/`, `deploy/` ni CODEOWNERS salvo pedido explícito.
- Nunca secretos en código, commits ni logs: configuración por variables de entorno (`.env`, fuera de git).
- `APP_ENV` por defecto es `dev`; nunca cambiarlo a `prod` en el código.
- Sin acceso a servidores: despliega GitHub Actions.
- Lo que deba sobrevivir a la sesión va en `docs/`, no en la memoria local del agente.
