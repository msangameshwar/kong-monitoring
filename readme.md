Get-ChildItem -Path . -Directory -Recurse -Filter node_modules
Get-ChildItem -Path . -Directory -Recurse -Filter node_modules | Remove-Item -Recurse -Force

1. Run bash npm.sh
2. Run  bash start.sh
3. Run kong gateway sync
4. Run bash stop.sh (if you want to stop the all applications)