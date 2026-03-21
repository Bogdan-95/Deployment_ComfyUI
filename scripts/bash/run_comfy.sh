# Запуск автоматизации 
#!/bin/bash

# 1. Переходим в КОРЕНЬ проекта (на две папки выше от места нахождения скрипта)
# Это позволяет запускать скрипт из любой директории
cd "$(dirname "$0")/../.."

# 2. Проверка: существует ли виртуальное окружение?
if [ ! -d "venv" ]; then
    echo "Ошибка: Папка venv не найдена в $(pwd)"
    exit 1
fi

# 3. Активируем виртуальную среду
source venv/bin/activate

# 4. Настройки для RTX 5060 (Blackwell)
# CUDA_VISIBLE_DEVICES=0 выбирает первую карту
# PYTORCH_CUDA_ALLOC_CONF помогает избежать фрагментации памяти на 8GB картах
export CUDA_VISIBLE_DEVICES=0
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

echo "-------------------------------------------------------"
echo "🚀 Запуск ComfyUI Engine [Production Mode]"
echo "📍 Рабочая директория: $(pwd)"
echo "🌐 Доступен по адресу: http://localhost:8188"
echo "-------------------------------------------------------"

# 5. Запуск основного процесса
# --listen 0.0.0.0 позволяет подключаться к серверу внутри локальной сети
# --preview-method auto включает отображение процесса генерации
python main.py --listen 0.0.0.0 --preview-method auto