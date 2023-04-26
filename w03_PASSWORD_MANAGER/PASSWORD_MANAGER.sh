
add_password() { 
  echo 'サービス名を入力してください：'
  read SERVICE
  echo 'ユーザー名を入力してください：'
  read USER
  echo 'パスワードを入力してください：'
  read PASS

  CURRENT=$(cd $(dirname $0);pwd)
  echo "$SERVICE:$USER:$PASS" >> "$CURRENT/password.txt"

  echo 'パスワードの追加は成功しました。'
}

get_password() {
  echo 'サービス名を入力してください：'
  read SERVICE

  CURRENT=$(cd $(dirname $0);pwd)
  MATCHS=$(grep "^$SERVICE:.\+:.\+$" "$CURRENT/password.txt")

  if [[ -n "$MATCHS" ]]; then
    echo "$MATCHS" | while IFS= read -r LINE; do
      IFS=':' read -ra FIELDS <<< "$LINE"
      echo "グループ名: ${FIELDS[0]}"
      echo "ユーザー名: ${FIELDS[1]}"
      echo "パスワード: ${FIELDS[2]}"
      echo "---------------------------"
    done
  else
    echo 'そのサービスは登録されていません。'
  fi
}


echo 'パスワードマネージャーへようこそ！'

while [ true ]
do
  echo '次の選択肢から入力してください(a:Add Password/g:Get Password/e:Exit)：'
  read INPUT
  if [ "$INPUT" == "Add Password" -o "$INPUT" == 'a' ]; then
    add_password
  elif [ "$INPUT" == 'Get Password' -o "$INPUT" == 'g' ]; then
    get_password
  elif [ "$INPUT" == 'Exit' -o "$INPUT" == 'e' ]; then
    echo 'Thank you!'
    exit
  else
    echo 'Error'
  fi
done