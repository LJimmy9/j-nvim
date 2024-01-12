return {
  "ziontee113/SelectEase",
  config = function()
    local select_ease = require("SelectEase")

    local select_mode = true

    -- For more language support check the `Queries` section
    local lua_query = [[
            ;; query
            ((identifier) @cap)
            ((string_content) @cap)
            ((true) @cap)
            ((false) @cap)
            ((comment) @cap)
        ]]
    local python_query = [[
            ;; query
            ((identifier) @cap)
            ((string) @cap)
        ]]

    local tsx_query = [[
    ;; query
    ((identifier) @cap)
    ((string_fragment) @cap)
    ((property_identifier) @cap)
]]

    local rust_query = [[
    ;; query
    ((boolean_literal) @cap)
    ((string_literal) @cap)

    ; Identifiers
    ((identifier) @cap)
    ((field_identifier) @cap)
    ((field_expression) @cap)
    ((scoped_identifier) @cap)
    ((unit_expression) @cap)

    ; Types
    ((reference_type) @cap)
    ((primitive_type) @cap)
    ((type_identifier) @cap)
    ((generic_type) @cap)

    ; Calls
    ((call_expression) @cap)

    ; matches
    ((match_expression) @cap)
    ((match_arm) @cap)
    ((match_pattern) @cap)

    ; Comments
    ((line_comment) @cap)
]]

    local go_query = [[
    ;; query
    ((selector_expression) @cap) ; Method call
    ((field_identifier) @cap) ; Method names in interface

    ; Identifiers
    ((identifier) @cap)
    ((expression_list) @cap) ; pseudo Identifier
    ((int_literal) @cap)
    ((interpreted_string_literal) @cap)

    ; Types
    ((type_identifier) @cap)
    ((pointer_type) @cap)
    ((slice_type) @cap)

    ; Keywords
    ((true) @cap)
    ((false) @cap)
    ((nil) @cap)

]]

    local c_query = [[
    ;; query
    ((string_literal) @cap)
    ((system_lib_string) @cap)

    ; Identifiers
    ((identifier) @cap)
    ((struct_specifier) @cap)
    ((type_identifier) @cap)
    ((field_identifier) @cap)
    ((number_literal) @cap)
    ((unary_expression) @cap)
    ((pointer_declarator) @cap)

    ; Types
    ((primitive_type) @cap)

    ; Expressions
    (assignment_expression
     right: (_) @cap)

]]
    local cpp_query = [[
    ;; query

    ; Identifiers
    ((namespace_identifier) @cap)
]] .. c_query

    local queries = {
      lua = lua_query,
      python = python_query,
      rust = rust_query,
      go = go_query,
      javascript = tsx_query,
      typescript = tsx_query,
      c = c_query,
      cpp = cpp_query
    }


    vim.keymap.set({ "n", "s", "i" }, "<C-A-k>", function()
      select_ease.select_node({
        queries = queries,
        direction = "previous",
        vertical_drill_jump = true,
        visual_mode = true, -- if you want Visual Mode instead of Select Mode
        fallback = function()
          -- if there's no target, this function will be called
          select_ease.select_node({ queries = queries, direction = "previous" })
        end,
      })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-A-j>", function()
      select_ease.select_node({
        queries = queries,
        direction = "next",
        vertical_drill_jump = true,
        visual_mode = true, -- if you want Visual Mode instead of Select Mode
        fallback = function()
          -- if there's no target, this function will be called
          select_ease.select_node({ queries = queries, direction = "next" })
        end,
      })
    end, {})

    vim.keymap.set({ "n", "s", "i" }, "<C-A-h>", function()
      select_ease.select_node({
        queries = queries,
        direction = "previous",
        current_line_only = false,
        visual_mode = true, -- if you want Visual Mode instead of Select Mode
      })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-A-l>", function()
      select_ease.select_node({
        queries = queries,
        direction = "next",
        current_line_only = false,
        visual_mode = true, -- if you want Visual Mode instead of Select Mode
      })
    end, {})

    -- previous / next node that matches query
    vim.keymap.set({ "n", "s", "i" }, "<C-A-p>", function()
      select_ease.select_node({ queries = queries, direction = "previous" })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-A-n>", function()
      select_ease.select_node({ queries = queries, direction = "next" })
    end, {})


    -- Swap Nodes
    vim.keymap.set({ "n", "s", "i" }, "<C-A-S-k>", function()
      select_ease.swap_nodes({
        queries = queries,
        direction = "previous",
        vertical_drill_jump = true,

        -- swap_in_place option. Default behavior is cursor will jump to target after the swap
        -- jump_to_target_after_swap = false --> this will keep cursor in place after the swap
      })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-A-S-j>", function()
      select_ease.swap_nodes({
        queries = queries,
        direction = "next",
        vertical_drill_jump = true,
      })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-A-S-h>", function()
      select_ease.swap_nodes({
        queries = queries,
        direction = "previous",
        current_line_only = true,
      })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-A-S-l>", function()
      select_ease.swap_nodes({
        queries = queries,
        direction = "next",
        current_line_only = true,
      })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-A-S-p>", function()
      select_ease.swap_nodes({ queries = queries, direction = "previous" })
    end, {})
    vim.keymap.set({ "n", "s", "i" }, "<C-A-S-n>", function()
      select_ease.swap_nodes({ queries = queries, direction = "next" })
    end, {})
  end,
}
