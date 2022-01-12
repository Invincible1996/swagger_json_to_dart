## generate swagger json to dart

## dart version 2.13 bellow

### 1.Use following command to generate executable file

```
dart2native bin/main.dart -o ~/.pub-cache/bin/generate_swagger
```

### 2.Please make sure you have already added the following content to your .zshrc or .bash(Mac)

```
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

### 3.Run under your project root directory

`generate_swagger`

## dart version 2.13 up

- windows

```
 dart compile exe bin/myapp.dart
```

- macos && linux

```
 dart compile aot-snapshot bin/main.dart
 Generated: /Users/xx/myapp/bin/main.aot
 dartaotruntime bin/main.aot
```
