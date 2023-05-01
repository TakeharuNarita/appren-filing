function main(){
  ATTEMPT=0
  PW_GPG=`dirname "$0"`"/password.gpg"
  echo "パスワードマネージャーへようこそ！"
  Vset_phrase
  Vhome
  echo "Thank you!"
  exit 0
}

function Vset_phrase(){
  [[ $ATTEMPT > 2 ]] && echo -e "\033[31m試行回数が上限に達しました。\033[0m" && exit 1
  read -sp "パスフレーズを入力してください：" PHRASE; [ -t 0 ]
  Vphrase_check
}

function Vphrase_check(){
  if [ -f $PW_GPG ]; then
    gpg -q -d --batch --yes --passphrase "${PHRASE}" "${PW_GPG}" 2>/dev/null || Vattempt
  else
    echo "" | gpg -q -c --batch --yes --passphrase "${PHRASE}" --output "${PW_GPG}"
    [ -t 0 ] && echo -e "\n'password.gpg'が存在しないため、新たなパスワードファイルを作成しました。"
  fi
}

function Vattempt(){
  echo -e "\033[31m\ngpg Error: 誤ったパスフレーズを入力した可能性があります。\033[0m"
  ATTEMPT=`expr $ATTEMPT + 1`
  Vset_phrase
}

function Vhome(){
  read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" option;
  Vloop $option
}

function Vloop() {
  option=$1
  case $option in
    "Add Password"|"a"|"A")
      Vadd_password
      ;;
    "Get Password"|"g"|"G")
      Vget_password
      ;;
    "Exit"|"e"|"E")
      ;;
    *)
      read -p "入力が間違えています。Add Password/Get Password/Exit から入力してください。" option;
      Vloop $option
      ;;
  esac
}

function Vadd_password() {
  read -p "サービス名を入力してください：" SERVICE; [ -t 0 ] && echo
  read -p "ユーザー名を入力してください：" USER; [ -t 0 ] && echo
  read -sp "パスワードを入力してください：" PASS; [ -t 0 ] && echo
  
  Bgpg_add "${SERVICE}:${USER}:${PASS}"
  echo 'パスワードの追加は成功しました。'
  Vhome
}

function Vget_password() {
  echo
}

function Sgpg_read () {
   TEXT=$(gpg -d test.txt.gpg)
   echo $TEXT
}

function Bgpg_add () {
  line=$1
  exist=$(gpg -q -d --batch --yes --passphrase "${PHRASE}" "${PW_GPG}")
  echo -e "${line}\n${exist}" | gpg -q -c --batch --yes --passphrase "${PHRASE}" --output ${PW_GPG}
}

main