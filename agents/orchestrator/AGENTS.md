# AGENTS.md — Роутинг + Learning Loop

## STARTUP (при каждом новом сеансе)

1. `read brand/profile.md` — профиль бренда
2. `read brand/voice-style.md` — стиль и тон
3. `read brand/audience.md` — целевая аудитория
4. `read learning/corrections.md` — коррекции (ОБЯЗАТЕЛЬНО!)
5. `read learning/approved-patterns.md` — что работает
6. `read learning/rejected-patterns.md` — чего избегать

---

## Команда

| ID | Роль | Скиллы |
|----|------|--------|
| `orchestrator` | Координатор | routing, QA, handoff |
| `writer` | Тексты | threads, telegram, copywriting, headlines, editing |
| `video` | Видео | reels, youtube, storytelling, hooks |
| `strategist` | Стратегия | selling-meanings, customer-research, offer, launch |
| `designer` | Визуал | carousel, image-gen, image-to-video |
| `analyst` | Метрики | critique, learning loop, pattern tracking |

## Роутинг

- **Текст** (посты, копирайтинг, заголовки) → `writer`
- **Видео** (сценарии, YouTube, Reels) → `video`
- **Визуал** (карусели, картинки, обложки) → `designer`
- **Стратегия** (смыслы, оффер, кастдев, прогрев) → `strategist`
- **Качество** (оценка, метрики, learning) → `analyst`
- **Я**: координация, роутинг, SwipeFile, мониторинг

---

## Learning Loop

### ПЕРЕД каждой задачей:
1. Проверь `learning/corrections.md`
2. Проверь `learning/approved-patterns.md`

### ПОСЛЕ фидбека:
- **👍** → записать в `learning/approved-patterns.md`
- **👎** → записать в `learning/rejected-patterns.md`
- **✏️** → записать в `learning/corrections.md` как RULE

### Формат RULE:
```markdown
## YYYY-MM-DD: [Контекст]
**CORRECTION:** [Что было не так]
**REASON:** [Почему]
**CORRECT:** [Как правильно]
**RULE:** [category] — [правило]
```

---

## Pipeline

IDEA → RESEARCH(strategist) → BRIEF → DRAFT(writer/video/designer) → REVIEW(analyst) → APPROVAL → PUBLISH → TRACK(analyst) → LEARN(analyst)

## Гейты

- Gate 1: brief/цель/аудитория
- Gate 2: draft + review (analyst)
- Gate 3: publish + metrics + learning update
