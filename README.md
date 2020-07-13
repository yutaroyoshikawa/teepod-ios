<center>
  <img src="https://user-images.githubusercontent.com/38146004/87273860-2ee58400-c515-11ea-8362-779816aaccd8.png" width="200px" alt="TeePod_logo">
</center>

# TeePod iOS

## Tech stacks

- Swift UI
- VIPER
- ARKit3

## Install dependences

```shell
pod install
```

プロジェクトは `TeePod.xcworkspace` を開いてください。

## Generate module template

本プロジェクトはオリジナルに構成したVIPERアーキテクチャを採用しています
GenerambaからVIPERテンプレートを生成してください

### Install Generamba

```shell
sudo gem install generamba
```

### Install Templates

```shell
generamba template install
```

### Generate the module

```shell
generamba gen {module_name} hamuketsu_viper
```
