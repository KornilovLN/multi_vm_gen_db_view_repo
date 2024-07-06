#!/bin/bash

# Читаем vms.json
vms=$(cat vms.json)

# Для каждого ключа (имени виртуальной машины) в JSON-файле
#for vm_key in $(echo "$vms" | jq -r 'keys[]'); do
  # Создаем директорию с именем виртуальной машины
#  mkdir -p "$vm_key"

  # Создаем config.json с конфигурацией для данной виртуальной машины
#  config=$(echo "$vms" | jq -r ".\"$vm_key\"")
#  echo "$config" > "$vm_key/config.json"

  # Создаем директорию shared_folder внутри директории виртуальной машины
#  mkdir -p "$vm_key/shared_folder"

  # Копируем Vagrantfile в эту директорию после создания config.json
#  cp Vagrantfile "$vm_key/"

  # Цикл для создания виртуальных машин
  for vm_key in $(echo "$vms" | jq -r 'keys[]'); do
    # Создаем директорию с именем виртуальной машины
    mkdir -p "$vm_key"

    # Создаем config.json с конфигурацией для данной виртуальной машины
    config=$(echo "$vms" | jq -r ".\"$vm_key\"")
    echo "$config" > "$vm_key/config.json"

    # Создаем директорию shared_folder внутри директории виртуальной машины
    mkdir -p "$vm_key/shared_folder"

    # Копируем Vagrantfile в директорию виртуальной машины после создания config.json
    cp Vagrantfile "$vm_key/"
  done

  # После создания всех виртуальных машин, входим в цикл для запуска
  for vm_key in $(echo "$vms" | jq -r 'keys[]'); do
    read -p "Запустить виртуальную машину $vm_key? (y/n) " choice
    case "$choice" in
        y|Y)
          cd "$vm_key"
          vagrant up
          cd ..
          ;;
        n|N)
          echo "Пропускаем $vm_key"
          ;;
        *)
          echo "Неверный ввод, пропускаем $vm_key"
          ;;
    esac
  done

  # Запускаем виртуальную машину
  #cd "$vm_key"
  #vagrant up
  
  # Подключаемся к виртуальной машине по SSH
  #vagrant ssh
  
  # Возвращаемся в исходную директорию
#  cd ..
#done


