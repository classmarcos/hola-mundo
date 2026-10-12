# Cómo contribuir

1. `git switch main && git pull && git switch -c feature/mi-cambio` (agentes: `ai/mi-cambio`)
2. Cambiar + prueba. `ruff format . && ruff check . && pytest -q`
3. `git push -u origin feature/mi-cambio` -> abrir Pull Request (completar la plantilla)
4. CI verde + aprobación -> "Squash and merge" -> se publica solo en staging
5. Producción: el responsable crea la etiqueta `vX.Y.Z` y aprueba el despliegue
