# 데이터베이스 구조 (Oracle XE 21)

## 테이블 개요

### 1. `chatuser` 테이블
사용자의 정보를 저장

| 컬럼 이름     | 데이터 타입                | 설명                                                                 |
|---------------|----------------------------|----------------------------------------------------------------------|
| `userid`      | `NUMBER` Identity(increment)        | 각 사용자의 고유 식별자, 자동 생성                              |
| `username`    | `VARCHAR2(255 CHAR)`        | 유일 제약 조건                               |
| `useremail`   | `VARCHAR2(255 CHAR)`        | 이메일 주소.                                                 |
| `userpassword`| `VARCHAR2(255 CHAR)`        | 비밀번호 (해시된 비밀번호).                                    |
| `userbio`     | `CLOB`                      | 간략한 소개 및 정보.                                     |
| `date_time`   | `TIMESTAMP`                 | 사용자가 생성된 시점의 타임스탬프. 기본값은 현재 시간          |
| `status`      | `VARCHAR2(255 CHAR)`        | 사용자의 상태 (예: 'online', 'offline'). 기본값은 'offline'     |

### 2. `chatroom` 테이블
채팅방에 대한 정보를 저장

| 컬럼 이름      | 데이터 타입               | 설명                                                               |
|----------------|---------------------------|--------------------------------------------------------------------|
| `roomid`       | `NUMBER` Identity(increment)       | 각 채팅방의 고유 식별자, 자동 생성                           |
| `roomname`     | `VARCHAR2(255 CHAR)`       | 채팅방의 이름.                                                      |
| `roomnameinname` | `VARCHAR2(255 CHAR)`     | 채팅방의 부제목 같은 느낌                              |
| `date_time`    | `TIMESTAMP`                | 채팅방이 생성된 시점의 타임스탬프. 기본값은 현재 시간          |
| `ownername`    | `VARCHAR2(255 CHAR)`       | 채팅방의 소유자의 사용자 이름, `chatuser` 테이블의 `username`과 참조 관계. |

### 3. `chat_message` 테이블
채팅 메시지에 대한 정보를 저장

| 컬럼 이름      | 데이터 타입               | 설명                                                               |
|----------------|---------------------------|--------------------------------------------------------------------|
| `message_id`   | `NUMBER` Identity(increment)       | 각 메시지의 고유 식별자, 자동 생성                           |
| `roomid`       | `NUMBER`                  | 메시지가 속한 채팅방의 `roomid`. `chatroom` 테이블과 참조 관계     |
| `userid`       | `NUMBER`                  | 메시지를 보낸 사용자의 `userid`. `chatuser` 테이블과 참조 관계     |
| `chattext`     | `CLOB`                    | 메시지 내용                                                       |
| `date_time`    | `TIMESTAMP`               | 메시지가 보내진 시점의 타임스탬프. 기본값은 현재 시간          |
| `username`     | `VARCHAR2(255 CHAR)`      | 메시지를 보낸 사용자의 사용자 이름.                                 |
| `type`         | `VARCHAR2(50)`            | 메시지의 타입 (예: enter, msg, chat, exit, 이미지 등).                              |
| `sender`       | `VARCHAR2(255 CHAR)`      | 메시지의 발신자 이름                                               |
| `receiver`     | `VARCHAR2(255 CHAR)`      | 메시지의 수신자 이름.                                               |
| `data`         | `CLOB`                    | chattext랑 똑같음 chattext필드의 실질적인 값 (기본 생성자)          |

## 테이블 간 관계

- `chatuser`와 `chatroom`은 1:N 관계, 각 `chatroom`은 하나의 `chatuser`에 의해 소유
- `chatroom`과 `chat_message`는 1:N 관계, 하나의 채팅방은 여러 메시지를 가질 수 있음
- `chatuser`와 `chat_message`는 1:N 관계, 하나의 사용자는 여러 메시지를 보낼 수 있음
- `chat_message` 테이블의 `roomid`와 `userid`는 각각 `chatroom`과 `chatuser` 테이블의 외래 키로 설정

id 생성할 때
예) id NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1 NOCACHE) PRIMARY KEY
