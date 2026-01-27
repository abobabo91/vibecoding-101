@echo off
:: This script automates the process of pushing your code to GitHub and then
:: logging into your server to pull the latest version and restart the app.

echo Starting Deployment...

:: --- SECTION 1: LOCAL CHANGES ---
:: This part saves your work and sends it to the internet (GitHub).
echo.
echo [1/2] Pushing changes to GitHub...
:: Add all changed files to the "staging area"
git add .
:: Create a "commit" (a snapshot) with a timestamped message
git commit -m "Auto deploy %date% %time%"
:: Send the snapshot to the 'main' branch on GitHub
git push

:: --- SECTION 2: REMOTE SERVER ---
:: This part connects to your server using SSH and runs commands there.
:: REPLACE 'root@YOUR_IP' with your actual server address.
:: REPLACE '/root/YOUR_PROJECT_FOLDER' with the folder path on your server.
echo.
echo [2/2] Connecting to server and rebuilding...
ssh root@YOUR_IP "cd /root/YOUR_PROJECT_FOLDER && git pull && docker compose down && docker compose up -d --build"

echo.
echo Deployment Complete!
:: Keep the window open so you can see if there were any errors.
pause
