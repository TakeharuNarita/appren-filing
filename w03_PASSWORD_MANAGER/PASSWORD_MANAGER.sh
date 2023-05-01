function main(){
  ATTEMPT=0
  GPG_FILE=`dirname "$0"`"/password.gpg"
  echo "パスワードマネージャーへようこそ！"
  v_set_phrase
  v_home
  echo "Thank you!"
  exit 0
}

function v_set_phrase(){
  [[ $ATTEMPT > 2 ]] && echo -e "\033[31m試行回数が上限に達しました。\033[0m" && exit 1
  read -sp "パスフレーズを入力してください：" PHRASE;
  v_phrase_check
}

function v_phrase_check(){
  if [ -f $GPG_FILE ]; then
    gpg -q -d --batch --yes --passphrase "${PHRASE}" "${GPG_FILE}" > /dev/null 2> /dev/null
    status=$?; echo; [[ $status != 0 ]] && v_attempt
  else
    echo "" | gpg -q -c --batch --yes --passphrase "${PHRASE}" --output "${GPG_FILE}"
    [ -t 0 ] && echo -e "\n'password.gpg'が存在しないため、新たなパスワードファイルを作成しました。"
  fi
}

function v_attempt(){
  echo -e "\033[31mgpg Error: 誤ったパスフレーズを入力した可能性があります。\033[0m"
  ATTEMPT=`expr $ATTEMPT + 1`
  v_set_phrase
}

function v_home(){
  read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" option;
  while [ true ]; do
    case $option in
      "Add Password"|"a"|"A")
        v_add_password
        read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" option;
        ;;
      "Get Password"|"g"|"G")
        v_get_password
        read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" option;
        ;;
      "Exit"|"e"|"E")
        break
        ;;
      *)
        read -p "入力が間違えています。Add Password/Get Password/Exit から入力してください。" option;
        ;;
    esac
  done
}

function v_add_password() {
  read -p "サービス名を入力してください：" service
  read -p "ユーザー名を入力してください：" user
  read -sp "パスワードを入力してください：" pass
  
  v_gpg_add "${service}:${user}:${pass}"
}

function v_get_password() {
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
function v_gpg_add () {
  line=$1
  exist=$(gpg -q -d --batch --yes --passphrase "${PHRASE}" "${GPG_FILE}")
  echo -e "${line}\n${exist}" | gpg -q -c --batch --yes --passphrase "${PHRASE}" --output "${GPG_FILE}"
  [ -t 0 ] && echo -e "\nパスワードの追加は成功しました。"
}

main
