#!/bin/bash

# Читаем vms.json
vms=$(cat vms.json)

# Для каждого ключа (имени виртуальной машины) в JSON-файле
for vm_name in $(echo "$vms" | jq -r 'keys[]'); do
  # Создаем директорию с именем виртуальной машины
  mkdir -p "$vm_name"

  # Копируем Vagrantfile в эту директорию
  cp Vagrantfile "$vm_name/"

  # Создаем config.json с конфигурацией для данной виртуальной машины
  echo "$vms" | jq -r ".\"$vm_name\"" > "$vm_name/config.json"
done
