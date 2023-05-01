function gpg_add () {
  gpg -c test.txt

  if [ -f test.txt.gpg ]; then
    echo "test.txt.gpgが存在します。"
  else
    echo "test.txt.gpgが存在しません。"
    echo "test.txt.gpgを作成します。"
    gpg -c test.txt
  fi
}
PASSWORD="your_password_here"

function gpg_write () {
  if [ -f password.gpg ]; then
    TEXT=$(gpg -d --batch --yes --passphrase "${PASSWORD}" password.gpg)
    echo -e "${1}\n${TEXT}" | gpg -c --batch --yes --passphrase "${PASSWORD}" --output password.gpg
  else
    echo "$1" | gpg -c --batch --yes --passphrase "${PASSWORD}" --output password.gpg
  fi
}

function gpg_read () {
  TEXT=$(gpg -d --batch --yes --passphrase "${PASSWORD}" password.gpg)
  echo "$TEXT"
}
echo "inp:"; read inp; gpg_write "${inp}"
echo "EEEEEE $(gpg_read)"