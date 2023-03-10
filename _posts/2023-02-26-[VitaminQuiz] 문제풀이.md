---
layout: post
category: Algo
---
> `이것이 자료구조+알고리즘이다` 비타민 퀴즈 풀이

학교 전자도서관에 드디어 신청했던 책이 들어왔다!! 너무 신난다 😸

---
{: data-content="start!"}

## 1-1
```js
sizeof(Node)와 sizeof(Node*)의 결과는 어떻게 다를까요?
void* malloc(size_t size)는 malloc()함수의 인터페이스로 void*를 리턴하기 때문에 반드시 타입캐스팅을 해줘야 한다.
```

## 1-2
...특정 노드 앞에 새로운 노드를 삽입하는 SLL_InsertBefore() 함수도 있곘군요. 지금부터 이 함수를 구현하세요. 원형은 다음과 같습니다.
```c++
void SLL_InsertBefore(Node** Head, Node* Current, Node* NewHead);
```
다음으로 링크드 리스트의 모든 노드를 한번에 제거하는 SLL_DestroyAllNodes() 함수를 작성하세요. 원형은 다음과 같습니다.
```c++
void SLL_DestroyAllNodes(Node ** List);
```

### 풀이
첫번째
```c++
void SLL_InsertBefore(Node **Head, Node *Current, Node *NewNode)
{
    Node *Index = *Head;
    if((*Head) == Current)
        SLL_InsertNewHead(Head, NewNode);

    else
    {
        while(Index != NULL && Index->NextNode != Current)
        {
            Index = Index->NextNode;
        }
        if(Index!=NULL)
        {
            Index->NextNode = NewNode;
            NewNode->NextNode = Current;
        }
    }
}
```
두번째
```c++
void SLL_DestroyAllNodes(Node **List)
{
    int i;
    int Count == SLL_GetNodeCount((*List));
    Node *Current = NULL;

    for (i = 0; i < Count; i++)
    {
        Current = SLL_GetNodeAt((*List), 0);
        if (Current != NULL)
        {
            SLL_RemoveNode(List, Current);
            //0번째 노드 삭제-> 다음 노드가 0이 됨 -> 삭제
            SLL_DestroyNode(Current);
        }
    }
}
```

## 1-3
더블 링크드 리스트를 역순으로 출력하는 함수를 작성해보세요. 원형은 다음과 같습니다.
```c++
void PrintReverse(Node* Head);
```

### 풀이

```c++
void PrintReverse(Node* Head)
{
    Node *Tail = Head;
    Printf("\nPrinting Reverse..\n");
    While(Tail->NextNode!=NULL){
        Tail = Tail->NextNode;
    }
    While(Tail!= Head){
        printf("List[%d] : %d\n", cnt, Tail->Data);
        Tail = Tail->PrevNode;
    }
}
```

## 2-2
배열 기반 스택 예제 프로그램에 AS_IsFull(ArrayStack*Stack)함수를 추가해보세요. 스택을 생성했을 떄 설정한 용량이 가득 찼는지 체크하는 기능입니다.

### 풀이

기본 코드에 Capacity변수가 이미 존재하기 때문에, 가득찼을 때 push해주면 된다.
**ArrayStack.h** 헤더 변경
```c
int As_IsFull(ArrayStack* Stack);
```

**ArrayStack.c** 새로운 변수 정의
```c
int As_IsFull(ArrayStack* Stack)
{
    return(Stack->Top == Stack->Capacity);
}
```

**Test_ArrayStack.c**
```c

int main(void){
    int i = 0;
    ArrayStack* Stack = NULL;
    AS_CreateStack(&Stack, 10);

    /*추가*/
    for (i = 0; i < 20;i++){
        if(AS_IsFull(Stack))
            break;

        AS_Push(Stack, i);
    }
    /**/

    AS_Push(Stack, 3);
    AS_Push(Stack, 37);
    AS_Push(Stack, 11);
    AS_Push(Stack, 12);

    printf(" Capaciy: %d, Size: %d, Top: %d\n\n, Stack->Capacity, AS_GetSize(Stack), AS_Top(Stack) ");

    for (i = 0; i < 4; i++){
        if(AS_IsEmpty(Stack))
            break;

        printf("Popped: %d", AS_Pop(Stack));

        if(!AS_IsEmpty(Stack))
            printf("Current Top: %d\n", AS_TOp(Stack));
        else
            printf("Stack Is Empty");
    }

    AS_DestroyStack(Stack);
    return 0;
}
```