# Технический паспорт узла генерации контента (ComfyUI Engine)

**Дата настройки:** 19.03.2026  
**Инженер:** Bogdan  
**Статус:** Система развернута, оптимизирована и готова к масштабированию.

---

## 1. Аппаратное обеспечение (Hardware)
| Компонент | Спецификация |
| :--- | :--- |
| **GPU** | NVIDIA GeForce RTX 5060 Laptop (8GB VRAM) |
| **Архитектура GPU** | Blackwell (sm_120) — новейшее поколение |
| **RAM** | 8GB DDR5 |
| **Платформа** | Lenovo Legion Series |

## 2. Программный стек (Software Stack)
Система реализована на базе гибридной архитектуры Windows + Linux для максимальной производительности Torch.

* **ОС:** Windows 11 + WSL2 (Ubuntu 22.04 LTS).
* **Среда:** Python 3.12.3 (Изолированное окружение `venv`).
* **AI Core:** PyTorch 2.12.0.dev20260318+cu128 (Nightly Build).
  * *Примечание: Версия оптимизирована специально под архитектуру RTX 50-й серии.*
* **Интерфейс:** ComfyUI v0.17.0 + ComfyUI-Manager (V3.39.2).

## 3. Ключевые настройки и автоматизация
- **Автоматизация:** Разработан Shell-скрипт (`run_comfy.sh`) для автоматического запуска среды, проверки обновлений Git и проброса портов.
- **Инструментарий:** Интеграция с VS Code через Remote-WSL для прямого администрирования кода сервера.
- **Оптимизация VRAM:** Настроен режим `cudaMallocAsync` и `async weight offloading`, что позволяет генерировать изображения SDXL (1024x1024) без перегрузки памяти.

## 4. Метрики производительности
- **Модель:** Juggernaut XL (SDXL).
- **Разрешение:** 1024 x 1024 px.
- **Скорость:** ~6.5 - 10.5 it/s (итераций в секунду).
- **Время генерации:** 4.4 - 4.8 сек на 30 шагов.

---
**Вывод:** Система полностью соответствует требованиям по развертыванию удаленных GPU-серверов и готова к автоматизации через API.



## 5. Логи VS Code
```markdown
bogdan@Lenovo-Legion:/mnt/d/Development/ComfyUI_WSL$ ./run_comfy.sh
--- Запуск ComfyUI на WSL (Port 8188) ---
/mnt/d/Development/ComfyUI_WSL/venv/lib/python3.12/site-packages/requests/__init__.py:113: RequestsDependencyWarning: urllib3 (2.6.3) or chardet (7.2.0)/charset_normalizer (3.4.6) doesn't match a supported version!
  warnings.warn(
[START] Security scan
[ComfyUI-Manager] Using `uv` as Python module for pip operations.
Using Python 3.12.3 environment at: venv
[DONE] Security scan
## ComfyUI-Manager: installing dependencies done.
** ComfyUI startup time: 2026-03-19 21:03:15.863
** Platform: Linux
** Python version: 3.12.3 (main, Mar  3 2026, 12:15:18) [GCC 13.3.0]
** Python executable: /mnt/d/Development/ComfyUI_WSL/venv/bin/python
** ComfyUI Path: /mnt/d/Development/ComfyUI_WSL
** ComfyUI Base Folder Path: /mnt/d/Development/ComfyUI_WSL
** User directory: /mnt/d/Development/ComfyUI_WSL/user
** ComfyUI-Manager config path: /mnt/d/Development/ComfyUI_WSL/user/__manager/config.ini
** Log path: /mnt/d/Development/ComfyUI_WSL/user/comfyui.log
Using Python 3.12.3 environment at: venv
Using Python 3.12.3 environment at: venv

Prestartup times for custom nodes:
   5.6 seconds: /mnt/d/Development/ComfyUI_WSL/custom_nodes/ComfyUI-Manager

WARNING: You need pytorch with cu130 or higher to use optimized CUDA operations.
Found comfy_kitchen backend cuda: {'available': True, 'disabled': True, 'unavailable_reason': None, 'capabilities': ['apply_rope', 'apply_rope1', 'dequantize_nvfp4', 'dequantize_per_tensor_fp8', 'quantize_mxfp8', 'quantize_nvfp4', 'quantize_per_tensor_fp8']}
Found comfy_kitchen backend triton: {'available': True, 'disabled': True, 'unavailable_reason': None, 'capabilities': ['apply_rope', 'apply_rope1', 'dequantize_nvfp4', 'dequantize_per_tensor_fp8', 'quantize_mxfp8', 'quantize_nvfp4', 'quantize_per_tensor_fp8']}
Found comfy_kitchen backend eager: {'available': True, 'disabled': False, 'unavailable_reason': None, 'capabilities': ['apply_rope', 'apply_rope1', 'dequantize_mxfp8', 'dequantize_nvfp4', 'dequantize_per_tensor_fp8', 'quantize_mxfp8', 'quantize_nvfp4', 'quantize_per_tensor_fp8', 'scaled_mm_mxfp8', 'scaled_mm_nvfp4']}
Checkpoint files will always be loaded safely.
Total VRAM 8151 MB, total RAM 7943 MB
pytorch version: 2.12.0.dev20260318+cu128
Set vram state to: NORMAL_VRAM
Device: cuda:0 NVIDIA GeForce RTX 5060 Laptop GPU : cudaMallocAsync
Using async weight offloading with 2 streams
Enabled pinned memory 7546.0
Using pytorch attention
Python version: 3.12.3 (main, Mar  3 2026, 12:15:18) [GCC 13.3.0]
ComfyUI version: 0.17.0
comfy-aimdo version: 0.2.12
comfy-kitchen version: 0.2.8
ComfyUI frontend version: 1.41.20
[Prompt Server] web root: /mnt/d/Development/ComfyUI_WSL/venv/lib/python3.12/site-packages/comfyui_frontend_package/static
Asset seeder disabled
### Loading: ComfyUI-Manager (V3.39.2)
[ComfyUI-Manager] network_mode: public
[ComfyUI-Manager] ComfyUI per-queue preview override detected (PR #11261). Manager's preview method feature is disabled. Use ComfyUI's --preview-method CLI option or 'Settings > Execution > Live preview method'.
### ComfyUI Version: v0.17.0-34-gb941913f | Released on '2026-03-17'

Import times for custom nodes:
   0.0 seconds: /mnt/d/Development/ComfyUI_WSL/custom_nodes/websocket_image_save.py
   0.3 seconds: /mnt/d/Development/ComfyUI_WSL/custom_nodes/ComfyUI-Manager

Context impl SQLiteImpl.
Will assume non-transactional DDL.
[ComfyUI-Manager] default cache updated: https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/alter-list.json
[ComfyUI-Manager] default cache updated: https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/model-list.json
[ComfyUI-Manager] default cache updated: https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/github-stats.json
[ComfyUI-Manager] default cache updated: https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/custom-node-list.json
Starting server

To see the GUI go to: http://0.0.0.0:8188
[ComfyUI-Manager] default cache updated: https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/extension-node-map.json
FETCH ComfyRegistry Data: 5/132
FETCH ComfyRegistry Data: 10/132
FETCH ComfyRegistry Data: 15/132
FETCH ComfyRegistry Data: 20/132
FETCH ComfyRegistry Data: 25/132
FETCH ComfyRegistry Data: 30/132
Cannot connect to comfyregistry.
FETCH DATA from: https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/custom-node-list.json [DONE]
[ComfyUI-Manager] All startup tasks have been completed.
got prompt
model weight dtype torch.float16, manual cast: None
model_type EPS
Using pytorch attention in VAE
Using pytorch attention in VAE
VAE load device: cuda:0, offload device: cpu, dtype: torch.bfloat16
CLIP/text encoder model load device: cuda:0, offload device: cpu, current: cpu, dtype: torch.float16
loaded diffusion model directly to GPU
Requested to load SDXL
loaded completely;  4897.05 MB loaded, full load: True
Requested to load SDXLClipModel
Unloaded partially: 822.13 MB freed, 4074.96 MB remains loaded, 9.38 MB buffer reserved, lowvram patches: 0
loaded completely; 1726.83 MB usable, 1560.80 MB loaded, full load: True
Unloaded partially: 867.47 MB freed, 693.33 MB remains loaded, 62.51 MB buffer reserved, lowvram patches: 0
loaded completely; 5048.46 MB usable, 4897.05 MB loaded, full load: True
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.29it/s]
Requested to load AutoencoderKL
Unloaded partially: 300.18 MB freed, 393.16 MB remains loaded, 62.55 MB buffer reserved, lowvram patches: 0
loaded completely; 179.75 MB usable, 159.56 MB loaded, full load: True
Prompt executed in 50.63 seconds
got prompt
got prompt
  0%|                                                      | 0/30 [00:00<?, ?it/s]got prompt
got prompt
got prompt
got prompt
got prompt
  3%|█▌                                            | 1/30 [00:00<00:07,  3.76it/s]got prompt
got prompt
got prompt
  7%|███                                           | 2/30 [00:00<00:05,  5.24it/s]got prompt
got prompt
 10%|████▌                                         | 3/30 [00:00<00:04,  5.97it/s]got prompt
got prompt
got prompt
 13%|██████▏                                       | 4/30 [00:00<00:04,  6.36it/s]got prompt
got prompt
 17%|███████▋                                      | 5/30 [00:00<00:03,  6.58it/s]got prompt
got prompt
 20%|█████████▏                                    | 6/30 [00:00<00:03,  6.71it/s]got prompt
got prompt
got prompt
 23%|██████████▋                                   | 7/30 [00:01<00:03,  6.78it/s]got prompt
got prompt
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.64it/s]
Prompt executed in 4.82 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  7.12it/s]
Prompt executed in 4.50 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  7.16it/s]
Prompt executed in 4.49 seconds
100%|█████████████████████████████████████████████| 30/30 [00:02<00:00, 10.58it/s]
Prompt executed in 4.38 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  7.29it/s]
Prompt executed in 4.41 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.87it/s]
Prompt executed in 4.69 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.77it/s]
Prompt executed in 4.76 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.58it/s]
Prompt executed in 4.87 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.89it/s]
Prompt executed in 4.66 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  7.07it/s]
Prompt executed in 4.55 seconds
100%|█████████████████████████████████████████████| 30/30 [00:02<00:00, 10.40it/s]
Prompt executed in 4.52 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  7.26it/s]
Prompt executed in 4.43 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.89it/s]
Prompt executed in 4.67 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.67it/s]
Prompt executed in 4.81 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.68it/s]
Prompt executed in 4.81 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  7.05it/s]
Prompt executed in 4.56 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.94it/s]
Prompt executed in 4.62 seconds
100%|█████████████████████████████████████████████| 30/30 [00:02<00:00, 10.41it/s]
Prompt executed in 4.51 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  7.25it/s]
Prompt executed in 4.44 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.81it/s]
Prompt executed in 4.71 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.70it/s]
Prompt executed in 4.80 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  6.72it/s]
Prompt executed in 4.79 seconds
100%|█████████████████████████████████████████████| 30/30 [00:04<00:00,  7.00it/s]
Prompt executed in 4.59 seconds
100%|█████████████████████████████████████████████| 30/30 [00:03<00:00,  9.99it/s]
Prompt executed in 4.59 seconds
^C
Stopped server
bogdan@Lenovo-Legion:/mnt/d/Development/ComfyUI_WSL$ 
```