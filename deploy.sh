# Ejecución con bash -c para evitar problemas de interpretación
bash -c "$VM_SSH << 'REMOTE_SCRIPT'
rm -rf $PROJECT_DIR
mkdir $PROJECT_DIR
cd $PROJECT_DIR || exit
  
if git branch -r | grep -q 'origin/main'; then
    git checkout main
else
    git checkout master
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