---
layout: post
category: Pro
---

> `공부 목적`으로 작성한 포스팅입니다. 오타가 많고, 틀린 내용이 있을 수 있습니다.

Learn go with tests의 [mocking][link] 한국어 번역이 안되어 있어서 내가 하는 중 ㅋㅋ..

## But isn't mocking evil?

mocking이 악마라고 들었니? 소프트웨어 개발에서는 무엇이든지 악마가 될 수 있어, DRY(Don't repeat yourself)처럼!
사람들은 흔히 테스트와 리팩토링 과정을 무시하고 bad state 상태가 돼.
mocking 코드가 복잡해지거나 무언가 테스트 하기 위해 너무 많이 mock 해야 하는 경우에, 드는 나쁜 감정은 접어두고 너의 코드에 대해서 생각해야 해. 보통은,
- 테스팅 중인 것이 너무 많은 것을 해야 할 때(mock하기에는 너무 많은 dependency),
  - 모듈을 쪼개자.
- dependency가 너무 fine-grained 할 때,
  - 이것들을 하나의 의미있는 모듈로 통합하자.
- 테스트가 구현을 너무 고려할 때,
  - 구현 보다는 예상값을 테스팅을 더 선호하자.

보통, 너무 많은 mocking point는 추상화가 잘못되었다는 것을 보여줘.

**사람들이 TDD의 약점이라고 생각하는 것은 사실 강점이야.** 잘못된 테스트는 설계가 잘못된거야. 좋게 말하면, 설계가 잘 된 코드는 테스트하기 좋다는 거지.

### But mocks and tests are still making my life hard!

이런 상황인 적 있어?
- 리팩토링 하고 싶어서
- 결국에 테스트를 정~말 많이 바꿨는데
- TDD에 대해 질문하고 Medium에 "Mocking = 최악"이라고 게시물을 올린거야. 

이거 왜냐면, 너가 테스트 할 때, 구현을 너무 신경써서 그래. 구현이 정말로 중요하지 않은 이상, 쓸모 있는 것들만 테스팅 해.
도대체 뭘 테스트해야 하는지 모르는 건 당연해. 아래의 룰을 지켜봐.
- **리팩토링은 behaviour은 동일한 데, 코드가 바뀌는 걸 정의해.** 만약 너가 리팩토링을 한다면, 테스트 코드 한 글자 바뀌지 않고 커밋할 수 있어야 해. 그래서 테스트 코드를 작성할 때, 아래를 상기해!
  - 내가 지금 behaviour을 테스팅하는 걸까, 구현을 테스팅하는 걸까?
  - 내가 이 코드를 리팩터하면, 테스트를 고쳐야할까?
- Go가 private 기능들을 테스트하게 놔둬도, 하지마. private 기능들은 public behaviour을 위한거야. public behaviour를 테스트 해! Sandi Metz는 private 기능들을 "불안정"하다고 해. 그니까 테스트랑 결합하지 마. 
- 테스트가 **3개 이상의 mock으로 돌아간다면, 적신호야.** 디자인에 대해 다시 생각해.
- 경고와 함께 spy를 사용해. spy는 너가 작성 중인 알고리즘의 내부를 볼 수 있어. 너무 유용하지만, 테스트 고드와 구현의 경계를 흐트려 놓지. **spy를 사용할 거면, 꼭 고려하도록 해**

### Can't i just use a mocking framework?
Mocking은 복잡하지 않아. 프레임워크를 사용하면 실제보다 더 복잡해 보일 수 있어. 이 챕터에서 자동모킹을 하지 않아서,
- 어떻게 mock 해야하는지 이해했어.
- implementing interface를 연습했지.

협동 프로젝트에서는 자동모킹이 가치 있을 수 있어. 팀에서 test double을 할 때, 코드 일관화를 할 수 있지.

interface에 대해 test double할 때만, mock generator을 쓰도록 해! 테스트 작성 방법을 지나치게 
지시하거나 너무 많은 'magic'을 사용하는 툴들은 버려

[link]: https://quii.gitbook.io/learn-go-with-tests/go-fundamentals/mocking