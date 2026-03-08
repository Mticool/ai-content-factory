# Настройка Notion (опционально)

## Зачем?
Notion используется для:
- 📋 Контент-план — планирование публикаций
- 📊 SwipeFile — коллекция вдохновляющего контента
- 📈 Аналитика — отслеживание метрик
- 🔄 Learning Log — история обучения системы

## Шаг 1. Создание интеграции

1. Зайди на [notion.so/my-integrations](https://notion.so/my-integrations)
2. Нажми "+ New integration"
3. Имя: "Content Factory"
4. Workspace: выбери свой
5. Скопируй Internal Integration Secret (начинается с `ntn_`)

## Шаг 2. Сохранение ключа

```bash
mkdir -p ~/.config/notion
echo "ntn_ТВОЙ_КЛЮЧ" > ~/.config/notion/api_key
```

Или в .env:
```bash
echo "NOTION_API_KEY=ntn_ТВОЙ_КЛЮЧ" >> ~/ai-content-factory/.env
```

## Шаг 3. Создание баз данных

### Контент-план
Создай базу с колонками:
| Поле | Тип | Описание |
|------|-----|----------|
| Name | Title | Название поста |
| Статус | Select | 💡 Идея / 📝 Драфт / 👀 На проверке / ✅ Одобрен / 🔄 На доработку |
| Платформа | Multi-select | Telegram / Instagram / YouTube / Threads |
| Дата | Date | Дата публикации |
| Автор | Select | writer / video / designer |
| Комментарий | Rich text | Фидбек и заметки |
| ER% | Number | Engagement Rate |

### SwipeFile
| Поле | Тип | Описание |
|------|-----|----------|
| Name | Title | Что зацепило |
| Источник | URL | Ссылка |
| Тип | Select | Reels / Post / Carousel / Video |
| Что украсть | Rich text | Приёмы для использования |
| Метрики | Rich text | Просмотры, лайки, ER |

## Шаг 4. Подключение баз

Для каждой созданной базы:
1. Открой базу в Notion
2. Нажми "..." → "Connect to"
3. Выбери "Content Factory"

## Шаг 5. Получение ID баз

ID базы — это часть URL:
```
https://notion.so/USERNAME/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX?v=...
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                          Это database_id (без дефисов)
```

## Шаг 6. Настройка в системе

Добавь ID баз в `MEMORY.md` оркестратора:
```markdown
## Notion БД
| База | ID |
|------|----|
| Контент-план | `ТВОЙ_ID` |
| SwipeFile | `ТВОЙ_ID` |
```

---

## Готово!
Теперь система может:
- Создавать записи в контент-плане
- Обновлять статусы
- Собирать SwipeFile
- Вести аналитику
