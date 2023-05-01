# パスワードマネージャー

このスクリプトは、暗号化された形式でパスワードを保存・取得するための簡単なパスワードマネージャーです。
`サービス名、ユーザー名、パスワード`を暗号化しファイルに保存して管理します。

## 用語定義

|スクリプト|ファイル`PASSWORD_MANAGER.sh`を指します。|
|パスフレーズ|パスワードが記録されたファイルを開くのに必要な文字列です。|

## 使い方

1. このスクリプトを任意のディレクトリに保存してください。
2. ターミナルで、スクリプトが保存されているディレクトリに移動します。
3. `chmod +x PASSWORD_MANAGER.sh`を実行して、実行権限を付与します。
4. `./PASSWORD_MANAGER.sh`を実行してスクリプトを起動します。

## 機能

- パスフレーズを設定: パスワードファイルの暗号化/復号化に使用されるパスフレーズを設定します。
- パスワードの追加: サービス名、ユーザー名、パスワードを入力して、暗号化された形式で保存します。
- パスワードの取得: サービス名を入力すると、対応するユーザー名とパスワードが表示されます。

## 注意事項

- `:`は区切り文字に使用している為、使用できません。
- このスクリプトは、最初に実行する際に`password.gpg`という暗号化されたパスワードファイルを生成します。このファイルを削除すると、保存されているすべてのパスワード情報が失われます。
- パスフレーズを忘れると、暗号化されたパスワードファイルを復元することができません。パスフレーズを忘れないように注意してください。