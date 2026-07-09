local temp = require("luatemplate")

return function(ctx)
  ctx.frontmatter = ctx.frontmatter or {}

  -- Словарь дней недели
  local weekdays = {
    ["воскресенье"] = 0,
    ["понедельник"] = 1,
    ["вторник"] = 2,
    ["среда"] = 3,
    ["четверг"] = 4,
    ["пятница"] = 5,
    ["суббота"] = 6
  }

  -- Функция форматирования даты
  local function format_date(time)
    return os.date("%d %B, %A, %Y", time)
  end

  -- Функция для вычисления следующего указанного дня недели
  local function next_weekday(target_w)
    local today_w = tonumber(os.date("%w")) -- 0=воскресенье, 1=понедельник ...
    local diff = (target_w - today_w + 7) % 7
    if diff == 0 then diff = 7 end          -- следующий такой день
    return os.time() + diff * 24 * 60 * 60
  end

  -- Парсер пользовательского ввода
  local function parse_input(input)
    local now = os.time()
    if not input or input == "" then return now end

    -- Полная дата дд.мм.гггг
    local d, m, y = input:match("(%d+)[%./-](%d+)[%./-](%d+)")
    if d and m and y then
      return os.time({ year = tonumber(y), month = tonumber(m), day = tonumber(d) })
    end

    -- Частичная дата дд.мм (текущий год)
    d, m = input:match("(%d+)[%./-](%d+)")
    if d and m then
      local t = os.date("*t", now)
      return os.time({ year = t.year, month = tonumber(m), day = tonumber(d) })
    end

    -- День недели
    local w = weekdays[input:lower()]
    if w ~= nil then
      return next_weekday(w)
    end

    -- Если ничего не распознано, возвращаем сегодня
    return now
  end

  -- Запрос даты у пользователя
  local chosen_date
  vim.ui.input({ prompt = "Введите дату (дд.мм.гггг / дд.мм / день недели): " }, function(input)
    chosen_date = parse_input(input)
  end)

  -- Ждем выбора/ввода
  vim.wait(1000, function() return chosen_date ~= nil end, 10)
  local today = format_date(chosen_date)

  -- Frontmatter
  ctx.frontmatter["sport"] = false

  -- Имя файла
  ctx.filename = today .. ".md"

  local lines = {
    "---",
    "tags: ",
    "sport: false",
    "---",
    "# Мысли",
    "",
    "# Таски",
    "",
    "## IMPORTANT",
    "",
    "## Ucheba",
    "",
    "## Base",
    "",
    "## Быстро",
    "",
  }

  -- Устанавливаем курсор на первую пустую строку после # Мысли
  vim.schedule(function()
    local bufnr = ctx.bufnr
    if bufnr then
      for i, line in ipairs(lines) do
        if line == "" and lines[i - 1] == "# Мысли" then
          vim.api.nvim_win_set_cursor(0, { i, 0 })
          break
        end
      end
    end
  end)

  return lines
end

