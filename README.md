# multi_vm_gen_db_view_repo
Multi virtual mashines (generator, data base, viewer, repository)

Virtual mashines:
    - vm-flow   generator any data flow
    - vm-base   data base any data and metadata
    - vm-view   viewer any data and metadata
    - vm-repo   repository docker images

vm-flow:   generator any data flow
    Cодержит несколько докер-контейнеров для генерации источников данных.
    В каждом контейнере запускается один докер-контейнер с генератором.

vm-base:   data base any data and metadata
    Cодержит несколько докер-контейнеров для хранения данных и метаданных.
    В каждом контейнере запускается докер-контейнер с некоторой базой данных.

vm-view:   viewer any data and metadata
    Cодержит несколько докер-контейнеров для просмотра данных и метаданных.

vm-repo:   repository docker images
    Cодержит докер-контейнер для хранения docker-образов.
    Отдает по требованию docker-образы.
    Создает docker-контейнеры по образам.

Скрипт creater_vm.sh в цикле создает директории с проектами по каждой из 4-х VM и также в цикле в диалоге по запросу (y/n) запускает конкретную VM  в работу     
