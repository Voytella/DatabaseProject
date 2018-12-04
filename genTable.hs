-- ----------BEGIN INPUT----------

{-
input will be of form:
```
TAB:tableName

COL:colName

data
data
data

COL:colName

data
data
data

```
-}

getIn :: String -> [String]
getIn s = lines s

-- -----------END INPUT-----------

-- ----------BEGIN OUTPUT----------

output :: [String] -> String
output [] = ""
output (s:ss) = s ++ "\n" ++ output ss



-- -----------END OUTPUT-----------

main :: IO()
main = interact $ output . getIn
