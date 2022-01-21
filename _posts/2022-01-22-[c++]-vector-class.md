---
layout: post
category: Algo
---
> `공부 목적`으로 작성한 포스팅입니다. 오타가 많고, 틀린 내용이 있을 수 있습니다.

## 목차

1. [Vector 클래스](#vector-클래스)
2. [Typedefs](#typedefs)
3. [Functions](#functions)

---
{: data-content="start!"}

## Vector 클래스
벡터에 연산자 오버로딩을 사용하는 이유는
1. 벡터는 하나의 값으로 나타낼 수 없으므로, 벡터를 나타내는 클래스를 정의하는 것이 비슷하다.
2. 벡터 연산은 덧셈이나 뺄셈과 같은 일반적인 산술 연산과 비슷하다.

벡터는 크기(길이)와 방향(각도)로 나타낼 수 있고, x성분과 y성분으로도 나타낼 수 있다. 어떤 경우에는 직각 좌표 형식이 편하고, 다른 경우에는 극 좌표 형식이 편할 것이다. Vector 클래스에서는 어떤 벡터의 한 가지 표현 형식을 바꾸면, 객체가 자동으로 다른 표현 형식도 갱신하도록 설계되었다. C++에 내장된 수학 함수들은 라디안 단위의 각도를 사용하는데, Vector 클래스 구현은 극 좌표를 직각 좌료로 변환하거나 라디안 단위를 도 단위로 변환하는 일들을 사용자가 볼 수 없도록 숨긴다. 물론, 

## Typedefs

| name | description |
| ---- | ----------- |
| `[allocator_type]`       | 벡터 개체의 allocator 클래스를 나타내는 형식 |
| const_iterator           | 벡터에 있는 const 요소를 읽을 수 있는 임의 액세스 반복기를 제공하는 형식 |
| const_pointer            | 벡터의 const 요소에 대한 포인터를 제공하는 형식 |
| const_reference          | 벡터에 저장 된 요소에 대 한 참조를 제공 하는 형식, const . 작업을 읽고 수행 하는 데 사용 |
| const_reverse_iterator   | 벡터의 모든 const 요소를 읽을 수 있는 임의 액세스 반복기를 제공하는 형식 |
| difference_type          | 벡터 내 두 요소 주소 간의 차이를 제공하는 형식 |
| iterator                 | 벡터에 있는 모든 요소를 읽거나 수정할 수 있는 임의 액세스 반복기를 제공하는 형식 |
| pointer                  | 벡터에서 요소에 대한 포인터를 제공하는 형식 |
| reference                | 벡터에 저장된 요소에 대한 참조를 제공하는 형식 |
| reverse_iterator         | 역방향 벡터에 있는 모든 요소를 읽거나 수정할 수 있는 임의 액세스 반복기를 제공하는 형식 |
| size_type                | 벡터의 요소 수를 계산하는 형식 |
| value_type               | 벡터에 저장된 데이터 형식을 나타내는 형식 |

## Functions

| name | description |
| ---- | ----------- |
| assign | 벡터를 지우고 지정된 요소를 빈 벡터에 복사 |
| at | 벡터의 지정된 위치에 있는 요소에 대한 참조를 반환 |
| back | 벡터의 마지막 요소에 대한 참조를 반환 |
| begin	 | 벡터의 첫 번째 요소에 대한 임의 액세스 반복기를 반환 |
| capacity | 스토리지를 더 할당하지 않고 벡터가 포함할 수 있는 요소의 수를 반환 |
| cbegin | 벡터의 첫 번째 요소에 대한 임의 액세스 const 반복기를 반환 |
| cend | 벡터 끝의 바로 다음을 가리키는 임의 액세스 const 반복기를 반환 |
| crbegin | 역방향 벡터의 첫 번째 요소에 대해 const 반복기를 반환 |
| crend | 역방향 벡터 끝에 대해 const 반복기를 반환 |
| clear	| 벡터의 요소를 지웁니다. |
| data | 벡터의 첫 번째 요소에 대한 포인터를 반환 |
| emplace | 내부에서 생성된 요소를 벡터의 지정된 위치에 삽입 |
| emplace_back | 내부에서 생성된 요소를 벡터의 끝에 추가 |
| empty	| 벡터 컨테이너가 비어 있는지 테스트 |
| end | 벡터 끝을 가리키는 임의 액세스 반복기를 반환 |
| erase	| 벡터의 지정된 위치에서 요소 또는 요소 범위를 제거 |
| front	| 벡터의 첫 번째 요소에 대한 참조를 반환 |
| get_allocator	| 벡터에서 사용하는 allocator 클래스에 개체를 반환 |
| insert | 벡터의 지정 된 위치에 요소 또는 많은 요소를 삽입  |
| max_size | 벡터의 최대 길이를 반환 |
| pop_back | 벡터의 끝에 있는 요소를 삭제 |
| push_back	| 벡터 끝에 요소를 추가 |
| rbegin | 역방향 벡터의 첫 번째 요소에 대한 반복기를 반환 |
| rend | 역방향 벡터 끝에 대해 반복기를 반환 |
| reserve | 벡터 개체에 대한 스토리지의 최소 길이를 예약 |
| resize | 벡터의 새 크기를 지정 |
| shrink_to_fit | 여분의 용량을 삭제 |
| size | 벡터에 있는 요소 수를 반환 |
| swap | 두 벡터의 요소를 교환 |

자세한 내용은 [cplusplus.com][cplus] 참조

### at

```c++
reference at(size_type position);
const_reference at(size_type position) const;
```
`position`이 벡터 크기보다 크면 `at`에서 예외를 throw. `[]`에 의한 접근은 첨자의 범위를 체크하지 않기 때문에 범위를 벗어난 접근을 시도할 경우 예외를 발생하지 않고 에러를 발생한다. 반면에, `at`을 이용한 접근은 첨자의 범위를 체크하여 벗어난 접근을 시도할 경우 `std::out_of_range` 예외를 발생한다. 
**범위 내의 접근을 보장할 경우 별도의 범위 체크가 필요 없으므로 []에 접근하고, 그렇지 않을 경우 at에 의한 접근으로 예외 처리 해준다.**

```c++
for ( int n = 0; n < (int)vInt.size(); ++n )
{
  int a = vInt[ n ];
  :
}
```
```c++
void no( int n )
{
	try
	{
		int a = vInt.at( n );
	}
	catch (std::out_of_range& e)
	{
		AfxMessageBox( _T("Catch the std::out_of_range") );
	}
}
```





[cplus]: https://www.cplusplus.com/reference/vector/vector/assign/