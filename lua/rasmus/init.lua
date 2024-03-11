local variants = require("rasmus.colors")
local cfg = require("rasmus.config").config
local c = variants[cfg.variant]
local utils = require("rasmus.utils")
local M = {}

local set_groups = function()
  local groups = {
    -- Base
    --common
    Type = { fg = c.bright_white }, -- int, long, char, etc.
    StorageClass = { fg = c.blue }, -- static, register, volatile, etc.
    Structure = { fg = c.white }, -- struct, union, enum, etc.
    Constant = { fg = c.white, style = "bold" }, -- any constant
    Comment = { fg = c.gray05, bg = c.none, style = cfg.comment_style }, -- italic comments
    Conditional = { fg = c.purple, bg = c.none, style = cfg.keyword_style }, -- italic if, then, else, endif, switch, etc.
    Keyword = { fg = c.purple, bg = c.none, style = cfg.keyword_style }, -- italic for, do, while, etc.
    Repeat = { fg = c.purple, bg = c.none, style = cfg.keyword_style }, -- italic any other keyword
    Boolean = { fg = c.blue, bg = c.none, style = "bold" }, -- true , false
    Function = { fg = c.white, bg = c.none, style = cfg.function_style },
    Identifier = { fg = c.gray08, bg = c.none }, -- any variable name
    String = { fg = c.gray07, bg = c.none }, -- Any string
    Character = { fg = c.cyan }, -- any character constant: 'c', '\n'
    Number = { fg = c.blue }, -- a number constant: 5
    Float = { fg = c.blue }, -- a floating point constant: 2.3e10
    Statement = { fg = c.purple }, -- any statement
    Label = { fg = c.cyan }, -- case, default, etc.
    Operator = { fg = c.cyan, style = "bold" }, -- "sizeof", "+", "*", etc.
    Exception = { fg = c.purple }, -- try, catch, throw
    PreProc = { fg = c.red }, -- generic Preprocessor
    Include = { fg = c.blue }, -- preprocessor #include
    Define = { fg = c.cyan }, -- preprocessor #define
    Macro = { fg = c.blue }, -- same as Define
    Typedef = { fg = c.cyan }, -- A typedef
    PreCondit = { fg = c.cyan }, -- preprocessor #if, #else, #endif, etc.
    Special = { fg = c.white, bg = c.none, "italic" }, -- any special symbol
    SpecialChar = { fg = c.cyan }, -- special character in a constant
    Tag = { fg = c.yellow }, -- you can use CTRL-] on this
    Delimiter = { fg = c.gray08 }, -- character that needs attention like , or .
    SpecialComment = { fg = c.blue }, -- special things inside a comment
    Debug = { fg = c.red }, -- debugging statements
    Underlined = { fg = c.cyan, bg = c.none, style = "underline" }, -- text that stands out, HTML links
    Ignore = { fg = c.gray08 }, -- left blank, hidden
    Error = { fg = c.red, bg = c.none, style = "bold" }, -- any erroneous construct
    Todo = { fg = c.cyan, bg = c.none, style = "bold,italic" }, -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    -- Editor highlight groups
    Normal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg }, -- normal text and background color
    NormalNC = { fg = c.fg, bg = cfg.transparent and c.none or c.bg }, -- normal text in non-current windows
    SignColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg }, -- column where signs are displayed
    EndOfBuffer = { fg = c.gray03 }, -- ~ lines at the end of a buffer
    NormalFloat = { fg = c.fg, bg = c.gray01 }, -- normal text and background color for floating windows
    FloatBorder = { fg = c.blue, bg = c.gray02 },
    ColorColumn = { fg = c.none, bg = c.gray01 }, --  used for the columns set with 'colorcolumn'
    Conceal = { fg = c.gray05 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor = { fg = c.cyan, bg = c.none, style = "reverse" }, -- the character under the cursor
    CursorIM = { fg = c.cyan, bg = c.none, style = "reverse" }, -- like Cursor, but used when in IME mode
    Directory = { fg = c.blue, bg = c.none, style = "bold" }, -- directory names (and other special names in listings)
    DiffAdd = { fg = c.green, bg = c.none, style = "reverse" }, -- diff mode: Added line
    DiffChange = { fg = c.blue, bg = c.none, style = "reverse" }, --  diff mode: Changed line
    DiffDelete = { fg = c.red, bg = c.none, style = "reverse" }, -- diff mode: Deleted line
    DiffText = { fg = c.fg, bg = c.none, style = "reverse" }, -- diff mode: Changed text within a changed line
    ErrorMsg = { fg = c.red }, -- error messages
    Folded = { fg = c.gray05, bg = c.none, style = "italic" },
    FoldColumn = { fg = c.blue },
    IncSearch = { style = "reverse" },
    LineNr = { fg = c.gray05 },
    CursorLineNr = { fg = c.gray08 },
    MatchParen = { fg = c.yellow, style = "bold" },
    ModeMsg = { fg = c.cyan, style = "bold" },
    MoreMsg = { fg = c.cyan, style = "bold" },
    NonText = { fg = c.gray03 },
    Pmenu = { fg = c.gray08, bg = c.gray02 },
    PmenuSel = { fg = c.bg, bg = c.gray06 },
    PmenuSbar = { fg = c.fg, bg = c.gray02 },
    PmenuThumb = { fg = c.fg, bg = c.gray05 },
    Question = { fg = c.green, style = "bold" },
    QuickFixLine = { fg = c.blue, bg = c.gray01, style = "bold,italic" },
    qfLineNr = { fg = c.blue, bg = c.gray01 },
    Search = { style = "reverse" },
    SpecialKey = { fg = c.gray03 },
    SpellBad = { fg = c.red, bg = c.none, style = "italic" },
    SpellCap = { fg = c.none, bg = c.none, style = "italic" },
    SpellLocal = { fg = c.cyan, bg = c.none, style = "italic" },
    SpellRare = { fg = c.cyan, bg = c.none, style = "italic" },
    StatusLine = { fg = c.gray08, bg = c.gray01 },
    StatusLineNC = { fg = c.gray06, bg = c.gray01 },
    StatusLineTerm = { fg = c.gray08, bg = c.gray01 },
    StatusLineTermNC = { fg = c.gray08, bg = c.gray01 },
    TabLineFill = { fg = c.gray05, bg = c.gray01 },
    TablineSel = { fg = c.bg, bg = c.gray08 },
    Tabline = { fg = c.gray05 },
    Title = { fg = c.cyan, bg = c.none, style = "bold" },
    Visual = { fg = c.none, bg = c.gray03 },
    VisualNOS = { fg = c.none, bg = c.gray03 },
    WarningMsg = { fg = c.yellow, style = "bold" },
    WildMenu = { fg = c.bg, bg = c.blue, style = "bold" },
    CursorColumn = { fg = c.none, bg = c.gray02 },
    CursorLine = { fg = c.none, bg = c.gray01 },
    ToolbarLine = { fg = c.fg, bg = c.gray01 },
    ToolbarButton = { fg = c.fg, bg = c.none, style = "bold" },
    NormalMode = { fg = c.cyan, bg = c.none, style = "reverse" },
    InsertMode = { fg = c.green, bg = c.none, style = "reverse" },
    VisualMode = { fg = c.cyan, bg = c.none, style = "reverse" },
    VertSplit = { fg = c.gray02 },
    CommandMode = { fg = c.gray05, bg = c.none, style = "reverse" },
    Warnings = { fg = c.yellow },
    healthError = { fg = c.red },
    healthSuccess = { fg = c.green },
    healthWarning = { fg = c.yellow },
    -- HTML
    htmlArg = { fg = c.fg, style = "italic" },
    htmlBold = { fg = c.fg, bg = c.none, style = "bold" },
    htmlEndTag = { fg = c.fg },
    htmlStyle = { fg = c.cyan, bg = c.none, style = "italic" },
    htmlLink = { fg = c.cyan, style = "underline" },
    htmlSpecialChar = { fg = c.yellow },
    htmlSpecialTagName = { fg = c.blue, style = "bold" },
    htmlTag = { fg = c.fg },
    htmlTagN = { fg = c.yellow },
    htmlTagName = { fg = c.yellow },
    htmlTitle = { fg = c.fg },
    htmlH1 = { fg = c.blue, style = "bold" },
    htmlH2 = { fg = c.blue, style = "bold" },
    htmlH3 = { fg = c.blue, style = "bold" },
    htmlH4 = { fg = c.blue, style = "bold" },
    htmlH5 = { fg = c.blue, style = "bold" },
    -- highlight groups for the native LSP client
    LspReferenceText = { fg = c.bg, bg = c.magenta }, -- used for highlighting "text" references
    LspReferenceRead = { fg = c.bg, bg = c.magenta }, -- used for highlighting "read" references
    LspReferenceWrite = { fg = c.bg, bg = c.magenta }, -- used for highlighting "write" references
    -- Diagnostics
    DiagnosticError = { fg = c.red }, -- base highlight group for "Error"
    DiagnosticWarn = { fg = c.yellow }, -- base highlight group for "Warning"
    DiagnosticInfo = { fg = c.blue }, -- base highlight group from "Information"
    DiagnosticHint = { fg = c.cyan }, -- base highlight group for "Hint"
    DiagnosticUnderlineError = { fg = c.red, style = "undercurl", sp = c.red }, -- used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn = { fg = c.yellow, style = "undercurl", sp = c.yellow }, -- used to underline "Warning" diagnostics.
    DiagnosticUnderlineInfo = { fg = c.blue, style = "undercurl", sp = c.blue }, -- used to underline "Information" diagnostics.
    DiagnosticUnderlineHint = { fg = c.cyan, style = "undercurl", sp = c.cyan }, -- used to underline "Hint" diagnostics.
    -- LspTrouble
    LspTroubleText = { fg = c.gray04 },
    LspTroubleCount = { fg = c.magenta, bg = c.gray03 },
    LspTroubleNormal = { fg = c.fg, bg = c.bg },
    -- Diff
    diffAdded = { fg = c.green },
    diffRemoved = { fg = c.red },
    diffChanged = { fg = c.blue },
    diffOldFile = { fg = c.gray04 },
    diffNewFile = { fg = c.fg },
    diffFile = { fg = c.gray05 },
    diffLine = { fg = c.cyan },
    diffIndexLine = { fg = c.magenta },
    -- GitSigns
    GitSignsAdd = { fg = c.green }, -- diff mode: Added line |diff.txt|
    GitSignsAddNr = { fg = c.green }, -- diff mode: Added line |diff.txt|
    GitSignsAddLn = { fg = c.green }, -- diff mode: Added line |diff.txt|
    GitSignsChange = { fg = c.yellow }, -- diff mode: Changed line |diff.txt|
    GitSignsChangeNr = { fg = c.yellow }, -- diff mode: Changed line |diff.txt|
    GitSignsChangeLn = { fg = c.yellow }, -- diff mode: Changed line |diff.txt|
    GitSignsDelete = { fg = c.red }, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteNr = { fg = c.red }, -- diff mode: Deleted line |diff.txt|
    GitSignsDeleteLn = { fg = c.red }, -- diff mode: Deleted line |diff.txt|
    -- Telescope
    TelescopeSelectionCaret = { fg = c.blue, bg = c.gray01 },
    TelescopeBorder = { fg = c.gray05 },
    TelescopePromptBorder = { fg = c.blue },
    TelescopeResultsBorder = { fg = c.gray08 },
    TelescopePreviewBorder = { fg = c.gray05 },
    TelescopeMatching = { fg = c.yellow },
    TelescopePromptPrefix = { fg = c.blue },
    -- BufferLine
    BufferLineIndicatorSelected = { fg = c.green },
    BufferLineFill = { bg = c.gray03 },
    -- nvim-cmp
    CmpItemAbbrDeprecated = { fg = c.gray05, style = "strikethrough" },
    CmpItemAbbrMatch = { fg = c.yellow },
    CmpItemAbbrMatchFuzzy = { fg = c.yellow },
    CmpItemKindVariable = { fg = c.blue },
    CmpItemKindInterface = { fg = c.blue },
    CmpItemKindText = { fg = c.blue },
    CmpItemKindFunction = { fg = c.magenta },
    CmpItemKindMethod = { fg = c.magenta },
    CmpItemKindKeyword = { fg = c.fg },
    CmpItemKindProperty = { fg = c.fg },
    CmpItemKindUnit = { fg = c.fg },
  }

  for group, parameters in pairs(groups) do
    utils.highlight(group, parameters)
  end
end

M.colorscheme = function()
  vim.api.nvim_command("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.api.nvim_command("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "rasmus"

  set_groups()
end

return M
