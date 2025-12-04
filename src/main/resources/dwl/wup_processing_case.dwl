%dw 2.0
output application/java

var items = (vars.ArticleItem.item default [])

var hasAnyItem = !isEmpty(items)

var hasBomFlag = !isEmpty(items filter (it) -> (it.bom_enabled_flag default "") == "Y")

var hasBuyFlag = !isEmpty(items filter (it) -> (it.planning_make_buy_code default "") == "Buy")

---
if (not hasAnyItem)
  "SKIP"
else if (hasBomFlag)
  // ALWAYS firstly we are going to BOM, to check EHQ/ESY
  "WITH_BOM"
else if (hasBuyFlag)
  "BUY"
else
  "WITHOUT_BOM"
