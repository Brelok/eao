%dw 2.0
/* 
 * logic "internalMovements" is processing earlier, components internalMovement will be not exists in numberOfComponents
*/
import modules::functions
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
	((article - "Component") ++ { Component: flatten(removenull(article.*Component)) })
	else
	(article - "Component")
  )
}