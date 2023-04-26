

read -ra SERVICE <<< "sv"
# SERVICE="sv"

CURRENT=$(cd $(dirname $0);pwd)
MATCHS=$(grep "^$SERVICE:.\+:.\+$" "$CURRENT/password.txt")

if [[ -n "$MATCHS" ]]; then
  echo $MATCHS

  while IFS= read -ra LINE <<< "$MATCHS"; do
    MATCHS="$LINE"
    IFS=':' read -ra FIELDS <<< "$LINE"
    echo "グループ名: ${FIELDS[0]}"
    echo "ユーザー名: ${FIELDS[1]}"
    echo "パスワード: ${FIELDS[2]}"
    echo "---------------------------"
  done
else
  echo 'そのサービスは登録されていません。'
fi