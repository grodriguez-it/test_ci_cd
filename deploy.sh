ssh -o StrictHostKeyChecking=no grodriguez@4.246.203.10 << EOF

cd /home/azureuser/practicas-ga
git pull --rebase origin main

EOF