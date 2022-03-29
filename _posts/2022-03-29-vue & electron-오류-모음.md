---
layout: post
category: Note
---
> `공부 목적`으로 작성한 포스팅입니다. 오타가 많고, 틀린 내용이 있을 수 있습니다.
---
{: data-content="start!"}

### Vuetify 설치 에러

![error3](./image/error3.png)

Vuetify 설치는 됐는데, error가 발생했다.
```r
ERROR Error: You cannot call "get" on a collection with no paths. Instead, check the "length" property first to verify at least 1 path exists.
```

[github issue][issue]에 쳐보니까 vue3이 beta버전이라 발생한 것 같다. vue2로 재설치하니까 해결되었다!

### Running 에러

![error2](./image/error2.png)

Vue Router사용하려면 multi word로 이름 바꾸라는 에러이다..error 문구는 다음과 같다.

```r
Component name should always be multi-word  vue/multi-word-component-names
```

**vue.config.js** 파일을 열고 내용을 추가 하면 해결된다.

```r
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

```r
"main": "src/main.js"
```

이래도 안되면 **npm start** 돌려보자


[issue]: https://github.com/vuetifyjs/vue-cli-plugins/issues/140

