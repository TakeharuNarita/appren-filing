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
    [ -t 0 ] && echo -e "'password.gpg'が存在しないため、新たなパスワードファイルを作成しました。"
  fi
}

function hilyo(){
  echo "hilyo"
}
function err(){
  echo "err"
}

function v_attempt(){
  echo -e "\033[31mgpg Error: 誤ったパスフレーズを入力した可能性があります。\033[0m"
  ATTEMPT=`expr $ATTEMPT + 1`
  v_set_phrase
}

function v_home(){
  read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" option;
  v_loop $option
}

function v_loop() {
  option=$1
  case $option in
    "Add Password"|"a"|"A")
      v_add_password
      ;;
    "Get Password"|"g"|"G")
      v_get_password
      ;;
    "Exit"|"e"|"E")
      ;;
    *)
      read -p "入力が間違えています。Add Password/Get Password/Exit から入力してください。" option;
      v_loop $option
      ;;
  esac
}

function v_add_password() {
  read -p "サービス名を入力してください：" SERVICE; [ -t 0 ] && echo
  read -p "ユーザー名を入力してください：" USER; [ -t 0 ] && echo
  read -sp "パスワードを入力してください：" PASS; [ -t 0 ] && echo
  
  b_gpg_add "${SERVICE}:${USER}:${PASS}"
  echo 'パスワードの追加は成功しました。'
  v_home
}

function v_get_password() {
  echo
}

function s_gpg_read () {
   TEXT=$(gpg -d test.txt.gpg)
   echo $TEXT
}

function b_gpg_add () {
  line=$1
  exist=$(gpg -q -d --batch --yes --passphrase "${PHRASE}" "${GPG_FILE}")
  echo -e "${line}\n${exist}" | gpg -q -c --batch --yes --passphrase "${PHRASE}" --output ${GPG_FILE}
}

main