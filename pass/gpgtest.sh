#!/bin/bash

PASSWORD_FILE="passwo.txt"
ENCRYPTED_FILE="passwo.txt.gpg"
GPG_RECIPIENT="t995771oxff@gmail.com"

function add_password {
  echo "サービス名を入力してください："
  read service_name
  echo "ユーザー名を入力してください："
  read username
  echo "パスワードを入力してください："
  read password

  if [ -f $ENCRYPTED_FILE ]; then
    gpg --decrypt --quiet --yes --output $PASSWORD_FILE $ENCRYPTED_FILE
  fi

  echo "${service_name}:${username}:${password}" >> $PASSWORD_FILE
  gpg --encrypt --quiet --yes --output $ENCRYPTED_FILE --recipient $GPG_RECIPIENT $PASSWORD_FILE
  rm -f $PASSWORD_FILE

  echo "パスワードの追加は成功しました。"
}

function get_password {
  if [ ! -f $ENCRYPTED_FILE ]; then
    echo "そのサービスは登録されていません。"
    return
  fi

  echo "サービス名を入力してください："
  read service_name

  gpg --decrypt --quiet --yes --output $PASSWORD_FILE $ENCRYPTED_FILE
  IFS_OLD=$IFS
  IFS=$'\n'
  found=0
  for line in $(cat $PASSWORD_FILE); do
    IFS=$IFS_OLD
    arr=($(echo $line | tr ":" "\n"))
    if [ "${arr[0]}" == "$service_name" ]; then
      echo "サービス名：${arr[0]}"
      echo "ユーザー名：${arr[1]}"
      echo "パスワード：${arr[2]}"
      found=1
      break
    fi
  done
  IFS=$IFS_OLD

  if [ $found -eq 0 ]; then
    echo "そのサービスは登録されていません。"
  fi

  rm -f $PASSWORD_FILE
}

function main {
  while true; do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
    read option

    case $option in
      "Add Password"|"a"|"A")
        add_password
        ;;
      "Get Password"|"g"|"G")
        get_password
        ;;
      "Exit"|"e"|"E")
        echo "Thank you!"
        exit 0
        ;;
      *)
        echo '入力が間違えています。Add Password/Get Password/Exit から入力してください。'
        ;;
    esac
  done
}

main
