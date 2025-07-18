echo "--------------------------------------------------------------"

for vm in $(virsh list --name); do
  allocated=$(virsh dommemstat "$vm" 2>/dev/null | awk '/actual/ {printf "%.0f", $2 / 1024}')
  used=$(virsh dommemstat "$vm" 2>/dev/null | awk '/rss/ {printf "%.0f", $2 / 1024}')

  # Пустые значения заменим на "-"
  [ -z "$allocated" ] && allocated="-"
  [ -z "$used" ] && used="-"

  printf "%-20s %-15s %-15s\n" "$vm" "$allocated" "$used"
done
