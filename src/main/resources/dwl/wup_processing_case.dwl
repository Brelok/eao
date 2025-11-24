%dw 2.0
output application/json

var hasAnyItem = vars.hasAnyItem default false
var planning = vars.planning_make_buy_code default ""
var bomEnabled = vars.bom_enabled_flag default ""

---
if (!hasAnyItem)
  "SKIP"
else if (planning == "Buy")
  "BUY"
else if (bomEnabled == "Y")
  "WITH_BOM"
else
  "WITHOUT_BOM"
