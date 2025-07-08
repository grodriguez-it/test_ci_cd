BRANCH=$1

if [ "$BRANCH" == "main" ]; then
    DEPLOY_PATH="/home/grodriguez/github/main"
else
    DEPLOY_PATH="/home/grodriguez/github/stage"
fi

$VM_SSH << REMOTE_SCRIPT

# 1. Entrar al respectivo directorio
rm -r $DEPLOY_PATH
mkdir /home/grodriguez/github
mkdir -p $DEPLOY_PATH
cd $PROJECT_DIR

# 2. Clonar repositorio
git clone https://github.com/grodriguez-it/test_ci_cd.git .
git pull --rebase origin $BRANCH

REMOTE_SCRIPT