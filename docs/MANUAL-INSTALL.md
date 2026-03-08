# Ручная установка AI Content Factory

## Шаг 1. Подготовка VPS

### Минимальные требования
- **ОС:** Ubuntu 22.04+ или Debian 12+
- **RAM:** 1 GB (минимум), 2 GB (рекомендуется)
- **Диск:** 10 GB
- **CPU:** 1 vCPU

### Провайдеры VPS
| Провайдер | Минимальный тариф | Рекомендация |
|-----------|-------------------|--------------|
| Hetzner | CX22 — €4.5/мес | ⭐ Лучшее соотношение цена/качество |
| Timeweb | от 199₽/мес | 🇷🇺 Российский провайдер |
| DigitalOcean | $6/мес | 🌍 Международный |

### Подключение
```bash
ssh root@ТВОЙ_IP
```

---

## Шаг 2. Установка Node.js

```bash
# Добавить репозиторий NodeSource
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -

# Установить
apt install -y nodejs

# Проверить
node -v  # должно быть v22+
npm -v
```

---

## Шаг 3. Установка OpenClaw

```bash
npm install -g openclaw

# Проверить
openclaw --version
```

---

## Шаг 4. Создание Telegram-бота

1. Открой [@BotFather](https://t.me/BotFather) в Telegram
2. Отправь `/newbot`
3. Выбери имя (например: "My Content Factory")
4. Выбери username (например: `my_content_bot`)
5. Скопируй токен (формат: `1234567890:ABCdef...`)

---

## Шаг 5. Получение API ключа

### Anthropic (рекомендуется)
1. Зайди на [console.anthropic.com](https://console.anthropic.com)
2. Зарегистрируйся
3. Settings → API Keys → Create Key
4. Пополни баланс ($5-20 для старта)

### OpenRouter (альтернатива)
1. Зайди на [openrouter.ai](https://openrouter.ai)
2. Зарегистрируйся
3. Keys → Create Key

---

## Шаг 6. Клонирование Content Factory

```bash
cd ~
git clone https://github.com/Mticool/ai-content-factory.git
cd ai-content-factory
```

---

## Шаг 7. Настройка OpenClaw

```bash
# Инициализация
openclaw init

# Указать API ключ
openclaw config set anthropic.apiKey "sk-ant-..."

# Указать Telegram
openclaw config set telegram.token "1234567890:ABCdef..."
openclaw config set telegram.allowedUsers "ТВОЙ_TELEGRAM_ID"
```

> Узнать свой Telegram ID: отправь `/start` боту [@userinfobot](https://t.me/userinfobot)

---

## Шаг 8. Настройка бренда

Заполни 3 файла в `agents/orchestrator/brand/`:

### `brand/profile.md`
- Имя, бренд, ниша
- Описание проекта
- УТП
- Контакты

### `brand/voice-style.md`
- Тон (дружеский/формальный/экспертный)
- Обращение (ты/вы)
- Что можно, что нельзя
- Примеры текстов

### `brand/audience.md`
- Кто твоя ЦА
- Их боли и желания
- Возражения
- Где обитают

---

## Шаг 9. Запуск

```bash
# Указать workspace
openclaw config set workspace "$HOME/ai-content-factory"

# Запустить
openclaw start
```

---

## Шаг 10. Проверка

1. Открой Telegram
2. Найди своего бота
3. Напиши: "Привет! Напиши мне пост про..."
4. Бот должен ответить 🎉

---

## Автозапуск (чтобы работал после перезагрузки)

```bash
# Создать systemd сервис
openclaw service install

# Или вручную:
cat > /etc/systemd/system/openclaw.service << 'EOF'
[Unit]
Description=OpenClaw AI Agent
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/bin/openclaw start
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

systemctl enable openclaw
systemctl start openclaw
```

---

## Проблемы?

| Проблема | Решение |
|----------|---------|
| Бот не отвечает | Проверь `openclaw status` |
| "Unauthorized" | Проверь API ключ |
| "Not allowed" | Проверь telegram.allowedUsers |
| Высокие расходы | Поменяй модель на claude-haiku |

📱 Поддержка: [@Mticool](https://t.me/Mticool)
