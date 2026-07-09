local temp = require("luatemplate")

return function(ctx)
  local current_semester = 5

  local disciplines = {
    [1] = { "Mathematical analysis 1", "Physics 1" },
    [2] = { "Mathematical analysis 2", "Physics 2" },
    [3] = { "Mathematical analysis", "Test option" },
    [4] = { "Harmonic analysis", "Physics 4", "Differential equations", "Tvs",
      "anmeh", "Probability theory", "Data base", "lab", "Field theory" },
    [5] = { "Complex analysis", "Urmati", "vichmati", "Quantum mechanics" },
    [6] = { "Golang", "Flutter" },
  }

  local options = disciplines[current_semester]

  local discipline = vim.env.DISCIPLINE

  if not discipline or discipline == "" then
    discipline = temp.ui_select(options, { prompt = "Select a discipline (Semester " .. current_semester .. "):" })
  end
  -- сохраняем "frontmatter" как отдельную таблицу в ctx (можно использовать для других шаблонов)
  ctx.frontmatter = ctx.frontmatter or {}
  ctx.frontmatter["Discipline"] = discipline
  ctx.frontmatter["Semester"] = current_semester

  -- формируем строки для вставки в буфер
  local lines = {
    "Semester: " .. current_semester
  }

  return lines
end
