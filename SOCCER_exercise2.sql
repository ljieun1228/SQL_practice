-- SOCCER_SQL_011
-- 팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력

SELECT T.TEAM_NAME 팀명, S.STADIUM_NAME 스타디움
FROM TEAM T
    JOIN STADIUM S
    ON S.STADIUM_ID LIKE T.STADIUM_ID
ORDER BY TEAM_NAME;

-- SOCCER_SQL_012
-- 팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오.

SELECT S.STADIUM_NAME 스타디움, C.SCHE_DATE 경기날짜,T.TEAM_NAME 홈팀,C.AWAYTEAM_ID 원정팀
FROM STADIUM S
    JOIN TEAM T
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
WHERE C.SCHE_DATE LIKE '20120317';
 
-- 인라인뷰와 스칼라 실행 후
-- 멘트수정: 서버쿼리라고 무조건 먼저가 아니라
-- 인라인뷰, FROM, 서브쿼리, WHERE, 스칼라, SELECT 순으로 실행

SELECT S.STADIUM_NAME 스타디움, 
    C.SCHE_DATE 경기날짜,
    T.TEAM_NAME 홈팀,
    (SELECT T.TEAM_NAME 
        FROM TEAM T
        WHERE T.TEAM_ID LIKE C.AWAYTEAM_ID) 원정팀
FROM STADIUM S
    JOIN TEAM T
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN (SELECT SCHE_DATE ,HOMETEAM_ID,STADIUM_ID,AWAYTEAM_ID
      FROM SCHEDULE C
      WHERE C.SCHE_DATE LIKE '20120317') C
        ON S.STADIUM_ID LIKE C.STADIUM_ID;


-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오

SELECT P.PLAYER_NAME 선수명,
     P.POSITION 포지션,
     CONCAT( T.REGION_NAME ||' ', T.TEAM_NAME )팀명,
     S.STADIUM_NAME 스타디움,
     C.SCHE_DATE 스케줄날짜
FROM STADIUM S
    JOIN SCHEDULE C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
    JOIN TEAM T
        ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
WHERE T.TEAM_ID LIKE 'K03' AND P.POSITION LIKE 'GK' AND C.SCHE_DATE LIKE '20120317'
ORDER BY P.PLAYER_NAME;
 
-- 인라인뷰를 적용한 후
-- 쿼리의 복잡성보다는 퍼포먼스의 향상이 더 기대되므로 적용함
 
SELECT P.PLAYER_NAME 선수명,
     P.POSITION 포지션,
     CONCAT( T.REGION_NAME||' ', T.TEAM_NAME )팀명,
     S.STADIUM_NAME 스타디움,
     C.SCHE_DATE 스케줄날짜
FROM STADIUM S
    JOIN (SELECT C.SCHE_DATE,C.STADIUM_ID
            FROM SCHEDULE C 
            WHERE C.SCHE_DATE LIKE '20120317' ) C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
    JOIN (SELECT T.TEAM_ID, T.TEAM_NAME, T.REGION_NAME, T.STADIUM_ID
            FROM TEAM T 
            WHERE T.TEAM_ID LIKE 'K03') T   
        ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT P.PLAYER_NAME, P.POSITION, P.TEAM_ID
            FROM PLAYER P 
            WHERE P.POSITION LIKE 'GK') P
        ON T.TEAM_ID LIKE P.TEAM_ID
  ORDER BY P.PLAYER_NAME;



-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오

SELECT 
    S.STADIUM_NAME 스타디움,
    K.SCHE_DATE 경기날짜,
    HT.REGION_NAME || ' '||HT.TEAM_NAME 홈팀,
    AT.REGION_NAME || ' '||AT.TEAM_NAME 원정팀,
    K.HOME_SCORE "홈팀 점수",
    K.AWAY_SCORE "원정팀 점수"
FROM 
    SCHEDULE K 
    JOIN STADIUM S
    ON K.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM HT 
    ON K.HOMETEAM_ID LIKE HT.TEAM_ID
    JOIN TEAM AT
    ON K.AWAYTEAM_ID LIKE AT.TEAM_ID
WHERE
    K.HOME_SCORE >= K.AWAY_SCORE +3 
ORDER BY K.SCHE_DATE 
; 
 
-- 서브쿼리를 사용한 예제
 
SELECT S.STADIUM_NAME "경기장 이름",
       C.SCHE_DATE "경기 일정",
       T.TEAM_NAME "홈팀 이름,", 
      C.HOME_SCORE "홈팀 점수",
     (SELECT TEAM_NAME 
        FROM TEAM T
        WHERE T.TEAM_ID LIKE C.AWAYTEAM_ID ) "원정팀 이름",
     C.AWAY_SCORE "원정팀 점수"
        
FROM STADIUM S
    JOIN TEAM T
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN (SELECT C.SCHE_DATE,
                    C.STADIUM_ID, 
                    C.HOMETEAM_ID, 
                    C.AWAYTEAM_ID,
                    C.HOME_SCORE,
                    C.AWAY_SCORE
            FROM SCHEDULE C
            WHERE C.HOME_SCORE >= C.AWAY_SCORE + 3) C
        ON C.STADIUM_ID LIKE S.STADIUM_ID
;
 

-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20

SELECT  S.STADIUM_NAME "스타디움 이름",
        S.STADIUM_ID "아이디",
        S.SEAT_COUNT 좌석수,    
        S.HOMETEAM_ID "홈팀 아이디",
        T.E_TEAM_NAME "영문 팀이름"
FROM STADIUM S
    LEFT JOIN TEAM T
        ON S.STADIUM_ID LIKE T.STADIUM_ID;  -- 15
        
-- 스칼라를 사용한 예제 (추천)        
        
SELECT  S.STADIUM_NAME "스타디움 이름",
        S.STADIUM_ID "아이디",
        S.SEAT_COUNT 좌석수,    
        S.HOMETEAM_ID "홈팀 아이디",
        (SELECT T.E_TEAM_NAME 
        FROM TEAM T 
        WHERE T.STADIUM_ID LIKE S.STADIUM_ID ) "영문 팀이름"
FROM STADIUM S
;


 -- SOCCER_SQL_016
-- 평균키가 인천 유나이티스팀의 평균키 보다 작은 팀의 
-- 팀ID, 팀명, 평균키 추출

SELECT P.TEAM_ID, T.TEAM_NAME, ROUND(AVG(P.HEIGHT),2) 평균키
 FROM PLAYER P
 JOIN TEAM T 
  ON T.TEAM_ID LIKE P.TEAM_ID
 WHERE P.HEIGHT < (SELECT ROUND(AVG(P.HEIGHT),2) AS HE
         FROM PLAYER P
        WHERE TEAM_ID LIKE 'K04')
    GROUP BY P.TEAM_ID, T.TEAM_NAME
    ORDER BY TEAM_NAME
;

-- SOCCER_SQL_017
-- 포지션이 MF 인 선수들의  소속팀명 및 선수명, 백넘버 출력
SELECT t.team_name, p.player_name, p.back_no, p.position
from team t
    join player p
        on p.TEAM_ID = t.TEAM_ID
where p.position like 'MF'
order by player_name
;
--스칼라로 처리하기
SELECT t.team_name, p.player_name, p.back_no, p.position
from team t
    join player p
        on p.TEAM_ID = t.TEAM_ID
where p.position like 'MF'
order by player_name
;
-- SOCCER_SQL_018
-- 가장 키큰 선수 5 추출, 오라클, 단 키 값이 없으면 제외
select   player_name, back_no, position, height
from player
where 

-- SOCCER_SQL_019
-- 선수 자신이 속한 팀의 평균키보다 작은 선수 정보 출력

-- SOCCER_SQL_020
-- 2012년 5월 한달간 경기가 있는 경기장 조회
-- EXISTS 쿼리는 항상 연관쿼리로 상요한다.
-- 또한 아무리 조건을 만족하는 건이 여러 건이라도
-- 조건을 만족하는 1건만 찾으면 추가적인 검색을 진행하지 않는다.


-- SOCCER_SQL_021
-- 이현 선수 소속팀의 선수명단 출력

-- SOCCER_SQL_022
-- NULL 처리에 있어
-- SUM(NVL(SAL,0)) 로 하지말고
-- NVL(SUM(SAL),0) 으로 해야 자원낭비가 줄어든다
 
-- 팀별 포지션별 인원수와 팀별 전체 인원수 출력
 
-- Oracle, Simple Case Expr

-- SOCCER_SQL_023
-- GROUP BY 절 없이 전체 선수들의 포지션별 평균 키 및 전체 평균 키 출력