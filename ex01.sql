--���϶����ּ�

/*

���߶��� �ּ�

cC:\class\code\oracle\�ʱ�.txt



--Java
--:=��ǰ��
---ȸ���: ��->����Ŭ���� �μ���
--
--Oracale Database
---��ǰ������ ȸ����̴� ����Ŭȸ�翡�� ����Ŭ�� �Ǵ�
--
--
--Database
--- �����ͺ��̽� = ������ ����
--- ������ ���̽� ���� �ý���: ����,�,���� �ϱ� ���ؼ� �ý����� ����������
--
--������ ���̽� ���� �ý���
--= Database Managemetn System
---�� �� �ϳ��� ����Ŭ
---����Ŭ(DB + DBMS =�����͸� ��Ƴ��� ���۱��� �Ҽ�����(����))
--
--
--��׶��� ���μ���
--= ����(��� �θ���)(Service)
--=����(Daemon)
--
--
--����Ŭ ����/����/����Ȯ��
---Win + R > ���� services.msc
--
--1. OracleServiceXE = ������ ���̽�
--
--2. OracleXETNSListener = ������(Ŭ���̾�Ʈ ������ ����)
--
--3. SQL Developer
--=�����ͺ��̽� Ŭ���̾�Ʈ ��
--- ���� �Ⱥ��̴� ����Ŭ�� �����ؼ� �����ϴ� ���α׷�
--- ������ - �߰���(������ ���̽� Ŭ���̾�Ʈ) - ����Ŭ(�����ͺ��̽� ����)
--
--�÷���-�������ͺ��̽����Ӽ���
--
--
--���� â > ��ũ ��Ʈ > ��ũ��Ʈ (����) >*.sql 

/*
local host + system

localhost > ���� ��ǻ��

localhost ==127.0.0.1(IP Address, ������, this)


system �۾� ���� - ������ �ʹ� Ŀ��;; - ����,�Ǽ��ұ��

�Ϲ� ���� �۾� = Ư�� ������ ���� ������ �ִ� ���� > ����


�н��� ���� ���� (=�Ϲ� ����) > + ���� ������ ���� �ش� > hr


Ư�� ������ ��й�ȣ �ٲٱ�
-alter user ������ identified by java1234;

Ư�� ���� Ȱ��ȭ/��Ȱ��ȭ
-alter user ������ account unlock;
-alter user ������ account lock;


*/

alter user hr identified by java1234;

alter user hr account unlock;

/*




JDK 1.8 
JDK 1.20

                
                8
                9i
Oracle Database 11g Enterprise Edition (�����)
Oracle Database 11g Express Edition(����,������)
                12c
                21c


SQL, Structured Query Language
- ����ȭ�� ���� ���
- ������(SQL Developer) <-> SQL <-> ����Ŭ
- DBMS �����ϱ� ���� ���




����Ŭ + SQL 
1. �����ͺ��̽� ������, DBA
    - ��� ��

2. �����ͺ��̽� ������, DB ������
    - ��� ��
    
3. ���� ���α׷� ������ (�ڹ� ������)
    - ��� �� or �Ϻ� ���


������ DBMS
1. Oracle
2. MS-SQL(Microsoft) �����
3. MySQL > ����(����,���)
4. MariaDB > ����(����,���)
5. PostreSQL > ����(����,���)
6. DB2 > IBM
7. SQLite > Mobile 


SQL 

1. DBMS ���ۻ�� �������̴�.
    - ��� ������ �����ͺ��̽����� ���������� ����ϱ� ���� ������� ���
    - DBMS ���ۻ翡�� SQL�̶�� �� �ڽ��� ��ǰ�� ����

2. ǥ�� SQL, ANSI-SQL
    -��� DBMS�� ���� ������ SQL
    
3. �����纰 SQL
    - Ư�� DBMS�� ���� ������ SQL
    - Oracle������ PL/SQL
    - MS-SQL������ T-SQL



����Ŭ ���� = ANSI-SQL(5~60%) + PL/SQL(2~30%) + (�����ͺ��̽�)����,��Ÿ(10%)

������ �����ͺ��̽�
- ������ ǥ �������� ����/�����Ѵ�.
- SQL�� ����Ѵ�.


ANSI-SQL
1. DDL
    - Data Definition Language
    - ������ ���Ǿ�
    - ���̺�, ��, �����, �ε��� ���� �����ͺ��̽� ������Ʈ�� 
        ����/����/�����ϴ� ��ɾ�
    - ������ ����/�����ϴ� ��ɾ�
    a. CREATE: ����
    b. DROP: ����
    c. ALTER: ����
    -�����ͺ��̽� ������
    -�����ͺ��̽� �����
    -���α׷���(�Ϻ�)
    
2. DML
    - Data Manipulation Language
    - ������ ���۾�
        - �����͸� �߰�/����/����/��ȸ�ϴ� ��ɾ�
    - CRUD
    - ��� �󵵰� ���� ����
    a. SELECT : ��ȸ(�б�) > R
    b. INSERT : �߰�(����) > C
    c. UPDATE : ���� > U
    d. DELETE : ���� > D
    - �����ͺ��̽� ������
    - �����ͺ��̽� �����
    - ���α׷���(*************)
    
3. DCL
    - Data Control Language
    - ������ �����
    - ���� ����, ���� ����, Ʈ����� ���� ��..
    a. COMMIT
    b. ROLLBACK
    c. GRANT
    d. REVOKE
    - �����ͺ��̽� ������
    - �����ͺ��̽� �����
    - ���α׷���(�Ϻ�)
    

4. DQL
    - Data Query Language
    -DML �߿��� SELECT���� ���� �θ��� ǥ��

5. TCL
    - Transaction Contruol Language
    - DCL �߿��� COMMIT, ROLLBACK���� ���� �θ��� ǥ��
    
    
����Ŭ ���ڵ�
- 1.0 ~ 8i :EUC-KR
- 9.i ~ ����: UTF-8


*/


-- SQL�� ��ҹ��ڸ� �������� �ʴ´�.
-- �Ķ���: Ű����(����)
-- ������: �ĺ���
select * from tabs;

SELECT * FROM tabs;

--'JOBS' > ���� ���  > �����ʹ� ��ҹ��ڸ� �����Ѵ�(*********)
select * from tabs where table_name = 'JOBS'; 

select * from tabs where table_name = 'jobs'; 

--1. Ű���� > �빮��
--2. �ĺ��� > �ҹ���
--alt + ' ��ҹ��� ���� �ܾ�
SELECT * FROM tabs;


--1. Ű���� > �빮��
--2. �ĺ��� > ĳ��
select * from tableStudent;


-- DB Object �ĺ��� ������ > �ִ� 30����Ʈ���� (30��)
create table aaa (
    num number
);

create table aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (
    num number
);







