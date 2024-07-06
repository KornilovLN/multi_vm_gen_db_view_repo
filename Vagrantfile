# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

# Читаем конфигурацию из JSON-файла
config = JSON.parse(File.read('config.json'))

Vagrant.configure("2") do |vagrant_config|
  vagrant_config.vm.boot_timeout = config['boot_timeout']

  vagrant_config.vm.define config['vm_name'] do |node|
    node.vm.box = config['vm_box']
    node.vm.hostname = config['vm_name']

    node.vm.provider "virtualbox" do |vb|
      vb.name = config['vm_name']
      vb.cpus = config['vm_cpu']
      vb.memory = config['vm_ram']

      # Проверяем, существует ли диск <VM_NAME>-disk.vdi
      disk_name = "#{config['vm_name']}-disk.vdi"
      unless File.exist?(disk_name)
        # Если диск не существует, создаем его
        #vb.customize ["createhd", "--filename", disk_name, "--size", config['disk_size']]
      end
      #vb.customize ["storageattach", :id, "--storagectl", "SATA Controller", "--port", 1, "--device", 0, "--type", "hdd", "--medium", disk_name]
    end

    # Монтирование общей папки
    node.vm.synced_folder config['shared_folder'], "/vagrant_data"

    # Провижинг (установка необходимого ПО)
    node.vm.provision "shell", inline: <<-SHELL
      apt-get update

      # Устанавливаем необходимые пакеты
      for package in #{config['packages_to_install'].join(" ")}; do
        apt-get install -y $package
      done

      # Добавляем текущего пользователя в группу docker
      # и перезагружаем сессию текущего пользователя
      sudo usermod -aG docker ${USER}
      #su - ${USER}

      # Устанавливаем права доступа к Docker сокету
      sudo chmod 666 /var/run/docker.sock

      # Перезагружаем службу Docker
      sudo systemctl restart docker

      # Обновляем группы для текущего пользователя
      newgrp docker

      mkdir -p /home/vagrant/.config/systemd/user
      cat << EOF > /home/vagrant/.config/systemd/user/sender.service

    [Unit]
    Description=Sender Service
    After=network-online.target

    [Service]
    ExecStart=/usr/bin/docker run --rm -v /vagrant_data:/data alpine:latest tail -f /dev/null
    Restart=always
    RestartSec=10

    [Install]
    WantedBy=default.target
    EOF

    systemctl --user enable sender
    systemctl --user start sender

    SHELL
  end
end
