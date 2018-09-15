# 1. Object value에 따른 key 정렬
stable함을 보장함.

``` javascript
Object.keys(result).sort((a,b) => { return result[b]-result[a] });
```
