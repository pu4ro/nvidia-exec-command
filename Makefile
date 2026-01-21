# GPU 컴퓨트 모드 관리
.PHONY: help gpu-mode-prohibited gpu-mode-default gpu-mode-status gpu-mode-reset-all gpu1-mode-prohibited gpu1-mode-default gpu-smi gpu-info

# 기본 타겟을 help로 설정
.DEFAULT_GOAL := help

# Help 명령어
help: ## Show this help message
        @echo "==================================================================="
        @echo "GPU Compute Mode Management Commands"
        @echo "==================================================================="
        @echo ""
        @grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
                awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
        @echo ""
        @echo "==================================================================="
        @echo "GPU Compute Modes:"
        @echo "  - DEFAULT:    Normal operation mode (default)"
        @echo "  - PROHIBITED: Compute applications are not allowed"
        @echo "==================================================================="

# nvidia-smi 기본 출력
gpu-smi: ## Show nvidia-smi output
        @echo "Running nvidia-smi..."
        @kubectl exec -n gpu-operator -it $$(kubectl get pods -n gpu-operator -l app=nvidia-driver-daemonset -o jsonpath='{.items[0].metadata.name}') -- nvidia-smi

# nvidia-smi 상세 정보
gpu-info: ## Show detailed GPU information
        @echo "Running nvidia-smi with detailed info..."
        @kubectl exec -n gpu-operator -it $$(kubectl get pods -n gpu-operator -l app=nvidia-driver-daemonset -o jsonpath='{.items[0].metadata.name}') -- nvidia-smi -q

# GPU 0번을 PROHIBITED 모드로 설정
gpu-mode-prohibited: ## Set GPU 0 to PROHIBITED mode
        @echo "Setting GPU 0 to PROHIBITED mode..."
        @kubectl exec -n gpu-operator -it $$(kubectl get pods -n gpu-operator -l app=nvidia-driver-daemonset -o jsonpath='{.items[0].metadata.name}') -- nvidia-smi -i 0 -c PROHIBITED
        @echo "✓ GPU 0 mode changed to PROHIBITED"

# GPU 0번을 DEFAULT 모드로 설정
gpu-mode-default: ## Set GPU 0 to DEFAULT mode
        @echo "Setting GPU 0 to DEFAULT mode..."
        @kubectl exec -n gpu-operator -it $$(kubectl get pods -n gpu-operator -l app=nvidia-driver-daemonset -o jsonpath='{.items[0].metadata.name}') -- nvidia-smi -i 0 -c DEFAULT
        @echo "✓ GPU 0 mode changed to DEFAULT"

# 모든 GPU 상태 확인
gpu-mode-status: ## Check compute mode status of all GPUs
        @echo "Checking GPU compute modes..."
        @kubectl exec -n gpu-operator -it $$(kubectl get pods -n gpu-operator -l app=nvidia-driver-daemonset -o jsonpath='{.items[0].metadata.name}') -- nvidia-smi -i 0,1 -q -d COMPUTE

# GPU 0번과 1번 모두 DEFAULT로 리셋
gpu-mode-reset-all: ## Reset all GPUs (0,1) to DEFAULT mode
        @echo "Resetting all GPUs to DEFAULT mode..."
        @kubectl exec -n gpu-operator -it $$(kubectl get pods -n gpu-operator -l app=nvidia-driver-daemonset -o jsonpath='{.items[0].metadata.name}') -- nvidia-smi -i 0 -c DEFAULT
        @kubectl exec -n gpu-operator -it $$(kubectl get pods -n gpu-operator -l app=nvidia-driver-daemonset -o jsonpath='{.items[0].metadata.name}') -- nvidia-smi -i 1 -c DEFAULT
        @echo "✓ All GPUs reset to DEFAULT mode"

# GPU 1번을 PROHIBITED 모드로 설정
gpu1-mode-prohibited: ## Set GPU 1 to PROHIBITED mode
        @echo "Setting GPU 1 to PROHIBITED mode..."
        @kubectl exec -n gpu-operator -it $$(kubectl get pods -n gpu-operator -l app=nvidia-driver-daemonset -o jsonpath='{.items[0].metadata.name}') -- nvidia-smi -i 1 -c PROHIBITED
        @echo "✓ GPU 1 mode changed to PROHIBITED"

# GPU 1번을 DEFAULT 모드로 설정
gpu1-mode-default: ## Set GPU 1 to DEFAULT mode
        @echo "Setting GPU 1 to DEFAULT mode..."
        @kubectl exec -n gpu-operator -it $$(kubectl get pods -n gpu-operator -l app=nvidia-driver-daemonset -o jsonpath='{.items[0].metadata.name}') -- nvidia-smi -i 1 -c DEFAULT
        @echo "✓ GPU 1 mode changed to DEFAULT"
