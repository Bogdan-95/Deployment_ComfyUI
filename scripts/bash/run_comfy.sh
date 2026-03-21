# Запуск автоматизации 
#!/bin/bash

# Переходим в рабочую директорию (на всякий случай)
cd /mnt/d/Development/ComfyUI_WSL

# Активируем виртуальную среду
source venv/bin/activate

# Сообщаем системе, что хотим использовать свежий Torch для RTX 5060
export CUDA_VISIBLE_DEVICES=0

echo "--- Запуск ComfyUI на WSL (Port 8188) ---"
python main.py --listen 0.0.0.0