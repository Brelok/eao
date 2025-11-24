%dw 2.0
output application/xml

var ignoreData = (vars.results default [] filter (!isEmpty($.numberOfComponents))).MaterialID default []

fun removenull(data) = data default [] filter (
  if (!isEmpty([$.MaterialID] -- vars.results.MaterialID)) true
  else ignoreData contains $.MaterialID
)
---
root: {
  Article: (vars.preparedArticleWithBom.root.*Article) map ((article) ->
	if (!isEmpty(removenull(article.*Component)))
	((article - "Component") ++ { Component: removenull(article.*Component) })
	else
	(article - "Component")
  )
}