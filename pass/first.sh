

read -ra SERVICE <<< "sv"
# SERVICE="sv"
CURRENT=$(cd $(dirname $0);pwd)

MATCHS=$(grep "^$SERVICE:.\+:.\+$" "$CURRENT/password.txt")

echo "$MATCHS" | while IFS= read -r TEST
do
  echo "$TEST" | while IFS=":" read -r WD
  do
    echo "$WD"
  done
done

#   echo "$MATCHS" | while IFS= read -r $INaaaE; do
#     echo "$LINE"
#     IFS=':' read -ra FIELDS <<< "$LINE"
#     echo "グループ名: ${FIELDS[0]}"
#     echo "ユーザー名: ${FIELDS[1]}"
#     echo "パスワード: ${FIELDS[2]}"
#     echo "---------------------------"
#   done
# else
#   echo 'そのサービスは登録されていません。'
# fi