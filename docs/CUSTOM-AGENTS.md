# Добавление своих агентов

## Структура агента

Каждый агент — это папка с файлами:

```
agents/my-agent/
├── SOUL.md          # Личность и роль (обязательно)
├── IDENTITY.md      # Краткое описание
├── AGENTS.md        # Связи с другими агентами
├── USER.md          # Информация о пользователе
├── MEMORY.md        # Роутер памяти
├── HEARTBEAT.md     # Авто-обслуживание
├── brand/           # Бренд-файлы (копируются из orchestrator)
│   ├── profile.md
│   ├── voice-style.md
│   └── audience.md
├── learning/        # Обучение
│   ├── corrections.md
│   ├── approved-patterns.md
│   └── rejected-patterns.md
├── memory/          # Память (автоматически)
└── skills/          # Скиллы (если нужны)
    └── my-skill/
        └── SKILL.md
```

## Создание агента

### 1. Создать папку
```bash
mkdir -p agents/seo/{brand,learning,memory}
```

### 2. Написать SOUL.md
```markdown
# 🔍 SEO-специалист — AI Content Factory

## Роль
Оптимизирую контент для поисковых систем.

## При старте ОБЯЗАТЕЛЬНО
1. read brand/profile.md
2. read brand/voice-style.md
3. read learning/corrections.md

## Принципы
- Ключевые слова естественно вплетены в текст
- Мета-описания до 160 символов
- H1 → H2 → H3 иерархия
- Внутренняя перелинковка
```

### 3. Скопировать brand/
```bash
cp agents/orchestrator/brand/* agents/seo/brand/
```

### 4. Создать learning файлы
```bash
cp agents/orchestrator/learning/* agents/seo/learning/
```

### 5. Зарегистрировать в OpenClaw

Добавить в конфиг OpenClaw нового агента:
```bash
openclaw config  # и добавить агента
```

### 6. Добавить в роутинг оркестратора

В `agents/orchestrator/AGENTS.md` добавить:
```markdown
| `seo` | SEO | seo, keywords, meta, optimization |
```

И в роутинг:
```markdown
- **SEO** (ключевые слова, мета, оптимизация) → `seo`
```

## Примеры агентов

### Email-маркетолог
- Цепочки писем
- Темы писем
- Сегментация

### SMM-менеджер
- Планирование постов
- Хештеги
- Оптимальное время публикации

### Переводчик
- Адаптация контента на другие языки
- Локализация

### Модератор
- Ответы на комментарии
- FAQ
- Обработка возражений
