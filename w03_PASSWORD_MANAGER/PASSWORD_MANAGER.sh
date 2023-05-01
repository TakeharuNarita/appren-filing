#!/bin/bash

function main(){
  ATTEMPT=0
  GPG_FILE=`dirname "$0"`"/password.gpg"
  echo "パスワードマネージャーへようこそ！"
  set_phrase
  home
}

function set_phrase(){
  [ $ATTEMPT -gt 2 ] && echo -e "\033[31m試行回数が上限に達しました。\033[0m" && exit 1
  read -sp "パスフレーズを入力してください：" PHRASE;
  phrase_check
}

function phrase_check(){
  if [ -f $GPG_FILE ]; then
    gpg -q -d --batch --yes --passphrase "${PHRASE}" "${GPG_FILE}" > /dev/null 2> /dev/null
    status=$?; echo; [[ $status != 0 ]] && attempt
  else
    echo "" | gpg -q -c --batch --yes --passphrase "${PHRASE}" --output "${GPG_FILE}"
    [ -t 0 ] && echo -e "\n'password.gpg'が存在しないため、新たなパスワードファイルを作成しました。"
  fi
}

function attempt(){
  echo -e "\033[31mgpg Error: 誤ったパスフレーズを入力した可能性があります。\033[0m"
  ATTEMPT=$(expr $ATTEMPT + 1)
  set_phrase
}

function home(){
  while true; do
    read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" option;
    select_option "${option}"
  done
}

@param $1: オプション文字列
function select_option(){
  option=$1
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
      echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
      ;;
  esac
}

function add_password() {
  read -p "サービス名を入力してください：" service
  read -p "ユーザー名を入力してください：" user
  read -sp "パスワードを入力してください：" pass
  
  gpg_add "${service}:${user}:${pass}"
}

function get_password() {
  exist=$(gpg -q -d --batch --yes --passphrase "${PHRASE}" "${GPG_FILE}")
  read -p "サービス名を入力してください：" service
  matchs=$(echo "${exist}" | grep "^${service}:.\+:.\+$")
  [ -z "${matchs}" ] && echo "そのサービスは登録されていません。" && return
  echo "--------------------------------"
  echo "${matchs}" | while IFS= read -r line; do
      IFS=":" read -ra cells <<< "${line}"
      echo "サービス名: ${cells[0]}"
      echo "ユーザー名: ${cells[1]}"
      echo "パスワード: ${cells[2]}"
      echo "--------------------------------"
  done
}

# @param $1: 追加する行の文字列、改行なし
function gpg_add () {
  line=$1
  exist=$(gpg -q -d --batch --yes --passphrase "${PHRASE}" "${GPG_FILE}")
  echo -e "${line}\n${exist}" | gpg -q -c --batch --yes --passphrase "${PHRASE}" --output "${GPG_FILE}"
  [ -t 0 ] && echo -e "\nパスワードの追加は成功しました。"
}

main
