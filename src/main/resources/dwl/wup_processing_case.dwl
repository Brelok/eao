%dw 2.0
output application/json

var hasAnyItem = vars.hasAnyItem default false
var planning = vars.planning_make_buy_code default ""
var bomEnabled = vars.bom_enabled_flag default ""

---
if (!hasAnyItem)
  "SKIP"
else if (bomEnabled == "Y" and planning != "Buy")
    "WITH_BOM"
else if (planning == "Buy")
    "BUY"
else
  "WITHOUT_BOM"
