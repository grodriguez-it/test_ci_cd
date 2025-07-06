$VM_SSH << REMOTE_SCRIPT
mkdir $PROJECT_DIR
cd $PROJECT_DIR || exit

# Verifica si es un repo Git y si está conectado a un remoto
if [ -d .git ]; then
    echo "✔ Directorio ya es un repositorio Git"
    if git remote -v | grep -q origin; then
        echo "✔ Tiene remoto 'origin' configurado"
    else
        echo "⚠ Falta remoto: agregando..."
        git remote add origin https://https://github.com/grodriguez-it/test_ci_cd.git
    fi
else
    echo "✖ Inicializando nuevo repo Git..."
    git init
    git remote add origin https://https://github.com/grodriguez-it/test_ci_cd.git
    git fetch
    git checkout -b main
fi

# Continúa con tu despliegue...
git pull origin main
REMOTE_SCRIPT