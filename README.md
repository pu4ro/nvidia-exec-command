# nvidia-exec-command

Kubernetes 환경에서 NVIDIA GPU 컴퓨트 모드를 관리하기 위한 Makefile 명령어 모음입니다.

## 요구 사항

- Kubernetes 클러스터
- NVIDIA GPU Operator 설치
- kubectl 접근 권한

## 사용법

```bash
make help
```

## 명령어 목록

| 명령어 | 설명 |
|--------|------|
| `make help` | 도움말 출력 |
| `make gpu-smi` | nvidia-smi 출력 |
| `make gpu-info` | GPU 상세 정보 출력 |
| `make gpu-mode-status` | 모든 GPU 컴퓨트 모드 상태 확인 |
| `make gpu-mode-prohibited` | GPU 0을 PROHIBITED 모드로 설정 |
| `make gpu-mode-default` | GPU 0을 DEFAULT 모드로 설정 |
| `make gpu1-mode-prohibited` | GPU 1을 PROHIBITED 모드로 설정 |
| `make gpu1-mode-default` | GPU 1을 DEFAULT 모드로 설정 |
| `make gpu-mode-reset-all` | 모든 GPU를 DEFAULT 모드로 리셋 |

## GPU 컴퓨트 모드

- **DEFAULT**: 일반 작동 모드 (기본값)
- **PROHIBITED**: 컴퓨트 애플리케이션 실행 불가
