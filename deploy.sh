# Ejecución con bash -c para evitar problemas de interpretación
bash -c "$VM_SSH << 'REMOTE_SCRIPT'
  mkdir -p $PROJECT_DIR
  cd $PROJECT_DIR || exit
  
  if [ -d .git ]; then
    git pull origin main
  else
    git init
    git remote add origin https://github.com/grodriguez-it/test_ci_cd.git
    git fetch && git checkout -b main
  fi
REMOTE_SCRIPT"