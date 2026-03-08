#!/usr/bin/env bash
set -euo pipefail

# =============================================
# 🏭 AI Content Factory — Установка
# Автор: Marat (@Mticool)
# =============================================

VERSION="1.0.0"
REPO="Mticool/ai-content-factory"
INSTALL_DIR="$HOME/.openclaw/workspace/ai-content-factory"

# Цвета
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

print_banner() {
    echo ""
    echo -e "${CYAN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  ${BOLD}🏭 AI Content Factory v${VERSION}${NC}${CYAN}             ║${NC}"
    echo -e "${CYAN}║  Команда AI-агентов для контента         ║${NC}"
    echo -e "${CYAN}║  by @Mticool                             ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════╝${NC}"
    echo ""
}

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[✓]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
log_error()   { echo -e "${RED}[✗]${NC} $1"; }

ask() {
    local prompt="$1"
    local var="$2"
    local default="${3:-}"
    
    if [[ -n "$default" ]]; then
        echo -ne "${BOLD}$prompt${NC} [${default}]: "
    else
        echo -ne "${BOLD}$prompt${NC}: "
    fi
    read -r input
    eval "$var=\"${input:-$default}\""
}

ask_secret() {
    local prompt="$1"
    local var="$2"
    echo -ne "${BOLD}$prompt${NC}: "
    read -rs input
    echo ""
    eval "$var=\"$input\""
}

# =============================================
# Проверки
# =============================================

check_requirements() {
    log_info "Проверяю требования..."
    
    # Node.js
    if ! command -v node &>/dev/null; then
        log_error "Node.js не найден. Установите: https://nodejs.org"
        exit 1
    fi
    log_success "Node.js $(node -v)"
    
    # OpenClaw
    if ! command -v openclaw &>/dev/null; then
        log_warn "OpenClaw не установлен"
        echo ""
        ask "Установить OpenClaw автоматически? (y/n)" INSTALL_OC "y"
        if [[ "$INSTALL_OC" == "y" ]]; then
            log_info "Устанавливаю OpenClaw..."
            npm install -g openclaw
            log_success "OpenClaw установлен"
        else
            log_error "OpenClaw необходим. Установите: npm install -g openclaw"
            exit 1
        fi
    else
        log_success "OpenClaw $(openclaw --version 2>/dev/null || echo 'installed')"
    fi
    
    # Git
    if ! command -v git &>/dev/null; then
        log_error "Git не найден. Установите: apt install git"
        exit 1
    fi
    log_success "Git $(git --version | awk '{print $3}')"
    
    echo ""
}

# =============================================
# Визард настройки
# =============================================

run_wizard() {
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}  📝 Давай настроим под тебя${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    # Основная информация
    ask "Как тебя зовут?" USER_NAME
    ask "Название бренда/проекта" BRAND_NAME
    ask "Ниша (кратко, например: фитнес, маркетинг, IT)" NICHE
    ask "Язык контента" LANGUAGE "Русский"
    
    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BOLD}  🔑 API ключи${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    # Telegram
    echo -e "Создай бота через ${BOLD}@BotFather${NC} в Telegram"
    echo -e "Команда: /newbot → выбери имя → скопируй токен"
    echo ""
    ask_secret "Telegram Bot Token" TG_TOKEN
    
    ask "Твой Telegram ID (число, узнай через @userinfobot)" TG_USER_ID
    
    echo ""
    
    # Anthropic
    echo -e "Получи ключ: ${BOLD}console.anthropic.com${NC} → API Keys"
    ask_secret "Anthropic API Key" ANTHROPIC_KEY
    
    echo ""
    
    # Notion (опционально)
    ask "Подключить Notion? (y/n)" USE_NOTION "n"
    if [[ "$USE_NOTION" == "y" ]]; then
        echo -e "Создай интеграцию: ${BOLD}notion.so/my-integrations${NC}"
        ask_secret "Notion API Key" NOTION_KEY
    fi
    
    echo ""
    log_success "Данные собраны!"
}

# =============================================
# Установка
# =============================================

install_factory() {
    log_info "Скачиваю Content Factory..."
    
    if [[ -d "$INSTALL_DIR" ]]; then
        log_warn "Директория уже существует: $INSTALL_DIR"
        ask "Перезаписать? (y/n)" OVERWRITE "n"
        if [[ "$OVERWRITE" != "y" ]]; then
            log_error "Установка отменена"
            exit 1
        fi
        rm -rf "$INSTALL_DIR"
    fi
    
    git clone "https://github.com/$REPO.git" "$INSTALL_DIR" 2>/dev/null || {
        log_error "Не удалось скачать репозиторий"
        log_info "Убедитесь что https://github.com/$REPO существует"
        exit 1
    }
    
    log_success "Скачано в $INSTALL_DIR"
}

# =============================================
# Конфигурация
# =============================================

configure_brand() {
    log_info "Настраиваю бренд..."
    
    # Общая brand/ директория
    local brand_dir="$INSTALL_DIR/agents/orchestrator/brand"
    
    # profile.md
    cat > "$brand_dir/profile.md" << EOF
# Профиль бренда

## Основная информация
- **Имя:** ${USER_NAME}
- **Бренд:** ${BRAND_NAME}
- **Ниша:** ${NICHE}
- **Язык:** ${LANGUAGE}

## Описание
<!-- Опиши свой бренд/проект в 2-3 предложениях -->

## УТП (Уникальное Торговое Предложение)
<!-- Чем ты отличаешься от конкурентов? -->

## Продукты/Услуги
<!-- Что ты продаёшь/предлагаешь? -->
- 

## Контакты
<!-- Telegram, сайт, соцсети -->
- 
EOF

    # voice-style.md
    cat > "$brand_dir/voice-style.md" << EOF
# Голос и стиль бренда

## Тон общения
- Дружеский, но экспертный
- На «ты» в личном общении
- На «вы» в публикациях

## Стиль текстов
- Короткие абзацы (2-3 предложения)
- Эмодзи: умеренно, по делу
- Без канцеляризмов и воды
- Конкретика и цифры

## Запрещено
- Агрессивные продажи
- Манипуляции
- Обещания без доказательств
- Копировать чужой стиль

## Примеры хорошего тона
<!-- Добавь примеры текстов, которые тебе нравятся -->
EOF

    # audience.md
    cat > "$brand_dir/audience.md" << EOF
# Целевая аудитория

## Основной сегмент
- **Возраст:** 
- **Пол:** 
- **Доход:** 
- **Интересы:** 

## Боли (проблемы)
1. 
2. 
3. 

## Желания (чего хотят)
1. 
2. 
3. 

## Возражения
1. 
2. 
3. 

## Где обитают
- Telegram
- Instagram
- YouTube
- 
EOF

    # Копируем brand во всех агентов
    for agent in writer video strategist designer analyst; do
        cp -r "$brand_dir/"* "$INSTALL_DIR/agents/$agent/brand/" 2>/dev/null || true
    done
    
    log_success "Бренд настроен"
}

configure_user() {
    log_info "Настраиваю USER.md..."
    
    cat > "$INSTALL_DIR/agents/orchestrator/USER.md" << EOF
# USER.md — О тебе

## Основная информация
- **Имя:** ${USER_NAME}
- **Бренд/Проект:** ${BRAND_NAME}
- **Ниша:** ${NICHE}
- **Язык:** ${LANGUAGE}

## Предпочтения
- **Стиль контента:** Дружеский + экспертный
- **Формат:** Посты, статьи, видео
EOF

    log_success "USER.md создан"
}

configure_openclaw() {
    log_info "Настраиваю OpenClaw..."
    
    # Создаём .env
    cat > "$INSTALL_DIR/.env" << EOF
ANTHROPIC_API_KEY=${ANTHROPIC_KEY}
TELEGRAM_BOT_TOKEN=${TG_TOKEN}
EOF

    if [[ "$USE_NOTION" == "y" && -n "${NOTION_KEY:-}" ]]; then
        echo "NOTION_API_KEY=${NOTION_KEY}" >> "$INSTALL_DIR/.env"
    fi
    
    log_success ".env создан"
    
    # Настраиваем OpenClaw конфиг
    log_info "Для завершения настройки выполни:"
    echo ""
    echo -e "  ${BOLD}openclaw init${NC}"
    echo -e "  ${BOLD}openclaw config set telegram.token ${TG_TOKEN}${NC}"
    echo -e "  ${BOLD}openclaw config set telegram.allowedUsers ${TG_USER_ID}${NC}"
    echo ""
}

# =============================================
# Финал
# =============================================

print_success() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║  ${BOLD}✅ Content Factory установлена!${NC}${GREEN}         ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BOLD}Что дальше:${NC}"
    echo ""
    echo -e "  1. ${BOLD}Заполни бренд-файлы:${NC}"
    echo -e "     ${CYAN}$INSTALL_DIR/agents/orchestrator/brand/${NC}"
    echo ""
    echo -e "  2. ${BOLD}Запусти:${NC}"
    echo -e "     ${CYAN}cd $INSTALL_DIR && openclaw start${NC}"
    echo ""
    echo -e "  3. ${BOLD}Напиши боту в Telegram${NC} и попроси первый пост!"
    echo ""
    echo -e "${YELLOW}📖 Документация: $INSTALL_DIR/docs/${NC}"
    echo -e "${YELLOW}💬 Поддержка: @Mticool в Telegram${NC}"
    echo ""
}

# =============================================
# Main
# =============================================

main() {
    print_banner
    check_requirements
    run_wizard
    install_factory
    configure_brand
    configure_user
    configure_openclaw
    print_success
}

main "$@"
