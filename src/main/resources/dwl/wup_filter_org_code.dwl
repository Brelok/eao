%dw 2.0
output application/json
---

sizeOf(vars.ArticleItem.item filter ($.inventory_org_code == "EHQ" ))