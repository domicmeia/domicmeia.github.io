---
layout: post
category: Pro
---

### Vuetify 설치 에러

![error3](./image/error3.png)

Vuetify 설치는 됐는데, error가 발생했다.
```js
ERROR Error: You cannot call "get" on a collection with no paths. Instead, check the "length" property first to verify at least 1 path exists.
```

[github issue][issue] 보니까 vue3이 beta버전이라 발생한 것 같다. vue2로 재설치하니까 해결되었다!

### Running 에러

![error2](./image/error2.png)

multi word로 이름 바꾸라는 에러이다..error 문구는 다음과 같다.

```js
Component name should always be multi-word  vue/multi-word-component-names
```

**vue.config.js** 파일을 열고 내용을 추가 하면 해결된다.

```js
const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
    transpileDependencies: true,
    lintOnSave: false
})
```

이것으로 해결되지 않으면 에러 메세지에서 경고한 파일의 이름을 바꿔준다.
나의 경우 "Home"을 "The Home"으로 바꿔서 해결했다.

## main.js가 인식이 안되는 에러

에러코드는 다음과 같다.
![error4](./image/error4.png)

**package.json** 파일을 열고 내용을 바꿔주면 해결된다.

```js
"main": "src/main.js"
```

이래도 안되면 **npm start** 돌려보자

## no-multiple-empty-lines

마지막 줄에 엔터를 두 번 쳐서 생긴 오류이다..엔터를 한번만 치면 해결된다. 에러 코드는 다음과 같다.
![error5](./image/error5.png)

## webpack 에러

electron에서 제공하는 doc을 참고하여 fs를 사용하려고 하는데, 오류가 떴다.
![error6](./image/error6.png)

대충 구글링 하니까 좀 오래된 issue인가 보다, 해결책은 간단하다. **vue.config.js**

```js
module.exports = {
    resolve: {
    fallback: {
      "fs": false
    }
    }
}
```

그런데 안된다. 파일 탐색기에서 **vue.config.js**를 검색했을 때 너무 많아서 조금 싸했는데..
다른 해결책을 찾아야 한다........<결국 폴더를 삭제하고 다시 시작하기로 했다..>



[issue]: https://github.com/vuetifyjs/vue-cli-plugins/issues/140

