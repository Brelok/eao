%dw 2.0
output application/json
var itemCountEhq = sizeOf((vars.ArticleItem.item default []) filter ($.inventory_org_code == 'EHQ'))
var itemCountEsy = sizeOf((vars.ArticleItem.item default []) filter ($.inventory_org_code == 'ESY'))
---
(itemCountEhq default 0) + (itemCountEsy default 0) > 0