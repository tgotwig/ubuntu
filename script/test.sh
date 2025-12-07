set -e

export PATH="/root/.local/bin:$PATH"

echo "[asdf]" && asdf -v
echo "[bat]" && batcat --version
echo "[cc]" && cc --version
echo "[curl]" && curl -V
echo "[dig]" && dig -v
echo "[docker]" && docker --version
echo "[dust]" && dust --version
echo "[fd]" && fdfind --version
echo "[nslookup]" && nslookup -version
echo "[fish]" && fish -v
echo "[gpg]" && gpg --version | head -1
echo "[ip]" && ip -V
echo "[jq]" && jq --version
echo "[less]" && less -V
echo "[lsd]" && lsd --version
echo "[mediainfo]" && mediainfo --Version
echo "[micro]" && micro -version
echo "[nc]" && nc -h 2>&1 | head -1
echo "[nmap]" && nmap --version | head -2
echo "[ping]" && ping -V
echo "[rg]" && rg --version | head -1
echo "[starship]" && starship --version
echo "[task]" && task --version
echo "[tree]" && tree --version
echo "[wget]" && wget --version | head -1
echo "[z]" && zoxide --version
