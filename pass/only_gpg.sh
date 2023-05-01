function c () {
  gpg -c test.txt

  if [ -f test.txt.gpg ]; then
    echo "test.txt.gpgが存在します。"
  else
    echo "test.txt.gpgが存在しません。"
    echo "test.txt.gpgを作成します。"
    gpg -c test.txt
  fi
}

function d () {
   TEXT=$(gpg -d test.txt.gpg)
   echo $TEXT
}

d
