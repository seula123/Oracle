--ex02_datatype.sql

/*


������ �����ͺ��̽�
- ����(x) > SQL�� ���α׷��� �� �ƴϴ�.
- SQL > ��ȭ�� ��� > DB�� ��ȭ�� �������� �ϴ� ���
- �ڷ��� > ������ �����ϴ� ��Ģ > ���̺� ������ �� ��� > 


ANSI-SQL �ڷ�����
- ����Ŭ �ڷ���

1. ������
    -����, �Ǽ�
    a. number
        - (��ȿ�ڸ�) 38�ڸ� ������ ���ڸ� ǥ���ϴ� �ڷ���
        - 12345678901234567890123456789012345678
        - 5~22byte
        - 1x10^-130 ~ 9.9999x10^125
        
        - number : ����& �Ǽ�
        - number(precision): ��ü �ڸ��� = ����
        - number(precision, scale) : ��ü �ڸ���, �Ҽ� ���� �ڸ��� = �Ǽ�
        
    b. 

2. ������
    - ����, ���ڿ�
    - char vs nchar > n�� �ǹ�?
    - char vs varchar > var�� �ǹ�?
    
    a. char
        - ���� �ڸ��� ���ڿ� > ����(�÷�)�� ũ�Ⱑ �Һ��Ѵ�.
        - char(n) : �ִ� n�ڸ� ���ڿ�, n(����Ʈ)
        - char(n char)
        - �ּ� ũ�� : 1����Ʈ
        - �ִ� ũ�� : 2000����Ʈ
        
    
    b. nchar
        - n: national > ����Ŭ ���ڵ��� ������� �ش� �÷��� UTF-16 �����ϰ�
        - char(n) : �ִ� n�ڸ� ���ڿ�, n(���ڼ�)
        - �ּ� ũ�� : 1����
        - �ִ� ũ�� : 1000����Ʈ
    
    
    c. varchar2  variable > ��ĳ����, ����
        - ���� �ڸ��� ���ڿ� > ����(�÷�)�� ũ�Ⱑ ����
        - varchar2(n): �ִ� n�ڸ� ���ڿ�, n(����Ʈ)
        - varchar2(n char)
        - �ּ� �ڸ���: 1
        - �ִ� �ڸ���: 4000
    
    d. nvachar2
        - n: national > ����Ŭ ���ڵ��� ������� �ش� �÷��� UTF-16 �����ϰ�
        - ���� �ڸ��� ���ڿ� > ����(�÷�)�� ũ�Ⱑ ����
        - varchar2(n): �ִ� n�ڸ� ���ڿ�, n(���ڼ�)
        - �ּ� �ڸ���: 1����
        - �ִ� �ڸ���: 2000����
        
    e. clob, nclob
        - ��뷮 �ؽ�Ʈ
        - character large object
        - �ִ� 128TB
        - ������
        
        
    a. ���� �ڸ��� ���ڿ� > �ֹε�Ϲ�ȣ, ��ȭ��ȣ> char 
    b. ���� �ڸ��� ���ڿ� > �ּ�, �ڱ�Ұ� > varchar2
    
    a. ����/���� > varchar2
    
    
    
    
    
    
    

3. ��¥/�ð���
    a. date
        - ����Ͻú���
        - 7byte
        - ����� 4712�� 1�� 1�� ~ 9999�� 12�� 31��
        
    b. timestamp
        - ����Ͻú��� + �и��� + ������
    
    c. interval
        - �ð� 
        - ƽ�� �����
    

4. ���� ��������
    - �� �ؽ�Ʈ ������
    - �̹���, ����, ���� ���� ����, ���� ���� ��...
    - �� ��� �� ��.
    ex) �Խ��� (÷������),ȸ������(����) > ���ϸ� ����(���ڿ�)
    a. blob
        - �ִ� 128TB
        
    ���
    1. ����> NUMBER
    2. ���� > varchar2 + char
    3. ��¥ > date
    
    �ڹ�
    1. ���� > int + long , double
    2. ���ڿ� > String
    3. ��¥ > Calendar

*/

/*

--���̺� ����(����)

create table ���̺��(
    �÷� ����,
    �÷� ����,
    �÷� ����,
    �÷��� �ڷ���
);
*/

--�ĺ��� > Ÿ�� ���ξ� > �밡���� ǥ���
create table tblType(
    -- num number
    --num number
    --num number(3) --  -999 ~ +999���� ��������� �ִٴ� �� .����
    --unm number(4, 2) -- -99.99 ~ + 99.99
  
  
    --txt char(10)  -- �ִ� 10����Ʈ������ ���ڿ� -> ���� �̰� ����
    --txt char(10 char)  -- �ִ� 10���ڱ����� ���ڿ�
    --txt varchar2(10)
    
--    txt1 char(10),
--    txt2 varchar2(10)

    regdate date
    
);

drop table tblType;


-- ������ �߰�
-- insert into ���̺� (�÷�) values (��);
insert into tblType (num) values (100); -- ���� ���ͷ�
insert into tblType (num) values (3.14); --�Ǽ� ���ͷ�
insert into tblType (num) values (3.99); -- �ݿø� O
insert into tblType (num) values (1234);
insert into tblType (num) values (-999);
insert into tblType (num) values (999);

insert into tblType (num) values (99.99);
insert into tblType (num) values (-99.99);

insert into tblType (num) values (1234567890);
insert into tblType (num) values (12345678901234567890);
insert into tblType (num) values (1234567890123456789012345678901234567890);
insert into tblType (num) values (12345678901234567890123456789012345678901234567890);

--Java: Strong Type Language
--SQL Week Type Language



-- *** SQL�� �Ͻ����� ����ȯ�� ���� �Ͼ��.
insert into tblType (txt) values (100); --100(number) > '100'(char)
insert into tblType (txt) values ('100');
insert into tblType (txt) values ('ȫ�浿'); -- ���� ���ͷ� 
insert into tblType (txt) values ('ȫ�浿');

-- ����Ŭ ���ڵ� > UTF-8 > ����(1), �ѱ�(3) > 10����Ʈ
insert into tblType (txt) values ('abcdabcdab'); --10����Ʈ
--SQL ����: ORA-12899: value too large for column "HR"."TBLTYPE"."TXT" (actual: 11, maximum: 10)
insert into tblType (txt) values ('abcdabcdaba'); --11����Ʈ

insert into tblType (txt) values ('ȫ�浿�Դϴ�.'); --(actual: 19, maximum: 10) �ѱ��� �ѱ��ڿ� 3����Ʈ
insert into tblType (txt) values ('ȫ�浿');
insert into tblType (txt) values ('ȫ�浿��');  

-- "abc   "
-- "abc"
insert into tblType (txt1, txt2) values ('abc','abc');

insert into tblType (regdate) values ('2023-08-25'); --23/08-25



-- ������ �������� > ��� ���̺�(Result Table), �����(ResultSet)
select * from tblType;

commit;


--***����Ŭ�� ��� �ĺ��ڸ� �빮�ڷ� �����Ѵ�.

/*

DB Client Tools
1. SQL Developer : ����Ŭ�� ����, ����,�׷����� ������
2. SQL *PLUS : ����Ŭ ����, ����, ����Ŭ ��ġ�� �� ���� ��ġ��. CLIdds
3. SQLGate
4. Orange
5. DBeaver
6. ..
7. Toad
8. DataGrip(jetbrains) > �б� ����(�̸���) > 1�� ���� (����)


*/












