# Ejecución con bash -c para evitar problemas de interpretación
$VM_SSH << REMOTE_SCRIPT

# Verificar Nginx
if ! command -v nginx &> /dev/null; then
    echo "Nginx se está instalando"
    sudo apt update && sudo apt install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
else
    echo "Nginx ya está instalado"
fi

# 1. Directorio Repo
rm -rf $PROJECT_DIR
mkdir $PROJECT_DIR
cd $PROJECT_DIR || exit

# 2. Clonar repositorio
git clone https://github.com/grodriguez-it/test_ci_cd.git .

# 3. Seleccionar rama automáticamente
if git branch -r | grep -q 'origin/main'; then
    git checkout main
else
    git checkout master
fi

# Verificar Nginx
if ! command -v nginx &> /dev/null; then
    sudo apt update && sudo apt install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
else
    echo "Nginx ya está instalado"
fi

# 4. Copiar archivos a Nginx
sudo cp -r public/index.html /var/www/html/index.html
sudo chown -R www-data:www-data /var/www/html
sudo chown www-data:www-data /var/www/html/index.html  # Asegura permisos para Nginx/Apache

# 5. Verificar Nginx
sudo nginx -t
sudo systemctl restart nginx

REMOTE_SCRIPT