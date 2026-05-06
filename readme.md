Get-ChildItem -Path . -Directory -Recurse -Filter node_modules
Get-ChildItem -Path . -Directory -Recurse -Filter node_modules | Remove-Item -Recurse -Force
