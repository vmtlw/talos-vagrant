#!/bin/bash

# Путь для бэкапа (можно задать как параметр скрипта)
BACKUP_DIR="${1:-/srv/backup-k8s}"

# Создать директорию если не существует
mkdir -p "$BACKUP_DIR"

# Получить список всех ВМ (идентификаторы)
VM_NAMES=$(virsh list --all --name)

# Текущая дата для уникальности бэкапа
DATE=$(date +'%Y-%m-%d_%H-%M-%S')

for VM in $VM_NAMES; do
    if [ -z "$VM" ]; then
        continue
    fi

    echo "Бэкап ВМ: $VM"

    # Создать папку для конкретной ВМ с датой
    VM_BACKUP_DIR="$BACKUP_DIR/$VM/$DATE"
    mkdir -p "$VM_BACKUP_DIR"

    # Сохраняем XML конфиг ВМ
    virsh dumpxml "$VM" > "$VM_BACKUP_DIR/$VM.xml"

    # Сохраняем состояние ВМ (если работает)
    STATE=$(virsh domstate "$VM")
    if [[ "$STATE" == "running" ]]; then
        echo "ВМ работает, делаем дамп памяти и приостановку"
        virsh dump $VM --memory-only --file "$VM_BACKUP_DIR/$VM.mem"
        virsh suspend $VM
    fi

    # Получаем диски ВМ (можно из XML)
    DISKS=$(virsh domblklist "$VM" --details | awk '/disk/ {print $4}')

    # Копируем диски (предполагается, что диски - файлы, не LVM или iSCSI)
    for DISK_PATH in $DISKS; do
        echo "Копируем диск $DISK_PATH"
        cp -v "$DISK_PATH" "$VM_BACKUP_DIR/"
    done

    # Если была приостановка - возобновляем ВМ
    if [[ "$STATE" == "running" ]]; then
        virsh resume "$VM"
    fi

    echo "Бэкап $VM завершён."
done

