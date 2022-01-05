
## generate swagger json to dart

### 1.Use following command to generate executable file
```
dart2native bin/main.dart -o ~/.pub-cache/bin/generate_swagger 
```
### 2.Please make sure you have already added the following content to your .zshrc or .bash(Mac)
```
export PATH="$PATH":"$HOME/.pub-cache/bin"
```
### 3.Run  under your project root directory
```generate_swagger```