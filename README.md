# TeePod iOS

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
gem install generamba
```

### Install Templates

```shell
generamba install
```

### Generate the module

```shell
generamba gen {module_name} hamuketsu_viper
```
