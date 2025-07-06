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
if ! command -v nginx &> /dev/null; then
    echo "🛠️ Instalando Nginx..."
    sudo apt update && sudo apt install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
else
    echo "✅ Nginx ya está instalado"
fi
sudo cp /home/grodriguez/website/src/index.html /var/www/html/
sudo chown www-data:www-data /var/www/html/index.html  # Asegura permisos para Nginx/Apache
sudo nginx -t
sudo systemctl restart nginx

REMOTE_SCRIPT"