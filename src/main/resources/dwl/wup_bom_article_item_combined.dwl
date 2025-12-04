%dw 2.0
output application/json
var existing = vars.bomArticleItemCombined default { assembly_item: [] }
var current  = vars.singleBomResponse default { assembly_item: [] }
---
{
    assembly_item: (existing.assembly_item default []) ++ (current.assembly_item default [])
}