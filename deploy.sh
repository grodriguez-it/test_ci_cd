# Ejecución con bash -c para evitar problemas de interpretación
bash -c "$VM_SSH << 'REMOTE_SCRIPT'
  mkdir -p $PROJECT_DIR
  cd $PROJECT_DIR || exit
  
# Forzar clonación (elimina el directorio si existe)
if [ -d .git ]; then
  git fetch --all
  git reset --hard origin/main || git reset --hard origin/master
else
  git clone --branch main https://github.com/grodriguez-it/test_ci_cd.git .
fi

REMOTE_SCRIPT"