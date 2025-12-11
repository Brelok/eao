%dw 2.0
output application/json
var existing = vars.articleItemCombined default { item: [] }
var current  = vars.singleArticleItem default { item: [] }
---
{
    item: (existing.item default []) ++ (current.item default [])
}