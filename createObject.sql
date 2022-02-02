---- USER TABLE
CREATE TABLE USER_TABLE (
USER_ID VARCHAR(7)PRIMARY KEY,
USERNAME VARCHAR(23),
EMAIL VARCHAR(23)CONSTRAINT not_an_email CHECK(EMAIL LIKE '%@%'),
PASS VARCHAR(23),
DATE_OF_REG DATE,
ADDRESS VARCHAR(100),
CONTACT_NO VARCHAR(11)
)
---AUTO INCREMENTATION FOR USER_ID
CREATE SEQUENCE auto_increment_user_id;

create trigger trg_auto_user_id
       before insert on USER_TABLE
       for each row
begin
   select 'U'||trim(to_char(auto_increment_user_id.nextval, '00099'))
         into :new.USER_ID
         from dual;
end;
---- ADMIN TABLE
CREATE TABLE ADMIN_TABLE (
ADMIN_ID VARCHAR(7)PRIMARY KEY,
EMAIL VARCHAR(23)CONSTRAINT email_val_Admin CHECK(EMAIL LIKE '%@%'),
PASS VARCHAR(23)
)
-- AUTO INCREMENTATION FOR ADMIN ID
create sequence auto_increment_adminn_id;
create trigger trg_auto_admin_id 
       before insert on ADMIN_TABLE
       for each row
begin
   select 'U'||trim(to_char(auto_increment_adminn_id.nextval, '00099'))
         into :new.ADMIN_ID
         from dual;
end;
---CATEGORY TABLE
CREATE TABLE CATEGORY_TABLE (
CATEGORY_ID VARCHAR(7)PRIMARY KEY,
CATEGORY_NAME VARCHAR(23)
)

-- AUTO INCREMENTATION FOR CATEGORY ID
create sequence auto_increment_cat_id;
create trigger trg_auto_cat_id 
       before insert on CATEGORY_TABLE
       for each row
begin
   select 'U'||trim(to_char(auto_increment_cat_id.nextval, '00099'))
         into :new.CATEGORY_ID
         from dual;
end;
--- PRODUCT TABLE
CREATE TABLE PRODUCT_TABLE (
PRODUCT_ID VARCHAR(7)PRIMARY KEY,
PRODUCT_NAME VARCHAR(23),
CATEGORY_ID VARCHAR(5) REFERENCES CATEGORY_TABLE(CATEGORY_ID),
PRODUCT_PRICE NUMBER,
PRODUCT_IMAGE VARCHAR2(23),
PRODUCT_AVAILABLE_QTY NUMBER
)

-- AUTO INCREMENTATION FOR PRODUCT_ID
create sequence auto_increment_prod_id;
create trigger trg_auto_prod_id 
       before insert on PRODUCT_TABLE
       for each row
begin
   select 'U'||trim(to_char(auto_increment_prod_id.nextval, '00099'))
         into :new.PRODUCT_ID
         from dual;
end;
--- CART TABLE
CREATE TABLE CART_TABLE (
CART_ID VARCHAR(7)PRIMARY KEY,
USER_ID VARCHAR(7)REFERENCES USER_TABLE(USER_ID)
)
-- AUTO INREMENTATION FOR CART_ID
create sequence auto_increment_cart_id;

create trigger trg_auto_cart_id 
       before insert on CART_TABLE
       for each row
begin
   select 'U'||trim(to_char(auto_increment_cart_id.nextval, '00099'))
         into :new.CART_ID
         from dual;
end;
--- CART_ITEMS_TABLE
CREATE TABLE CART_ITEMS_TABLE (
CART_ID VARCHAR(7)REFERENCES CART_TABLE(CART_ID),
USER_ID VARCHAR(7)REFERENCES USER_TABLE(USER_ID),
PRODUCT_ID VARCHAR(7) REFERENCES PRODUCT_TABLE(PRODUCT_ID),
PRODUCT_QTY VARCHAR(5)
)
CREATE TABLE COUPON_TABLE (
COUPON_ID VARCHAR(7) PRIMARY KEY,
COUPON_NAME VARCHAR(23),
DISCOUNT_VAL NUMBER,
EXP_DATE DATE
)

-- AUTO INCREMENTATION FOR COUPON_ID
create sequence auto_increment_coupon_id;

create trigger trg_auto_coupon_id 
       before insert on COUPON_TABLE
       for each row
begin
   select 'U'||trim(to_char(auto_increment_coupon_id.nextval, '00099'))
         into :new.COUPON_ID
         from dual;
end;
--- OREDER_TABLE
CREATE TABLE ORDER_TABLE (
ORDER_ID VARCHAR(7)PRIMARY KEY,
CART_ID VARCHAR(7)REFERENCES CART_TABLE(CART_ID),
USER_ID VARCHAR(7)REFERENCES USER_TABLE(USER_ID),
ORDER_DATE DATE DEFAULT SYSDATE NOT NULL,
DELIVERY_DATE DATE DEFAULT SYSDATE + 7,
COUPON_ID VARCHAR(7),
BILL_AMOUNT NUMBER,
PAYMENT_METHOD VARCHAR(23) CONSTRAINT PM_CHECK CHECK(LOWER(PAYMENT_METHOD)IN('cod', 'debit/credit card', 'online wallet'))
)

-- AUTO INCREMENTATION FOR ORDER_ID
create sequence auto_increment_order_id;

create trigger trg_auto_order_id 
       before insert on ORDER_TABLE
       for each row
begin
   select 'U'||trim(to_char(auto_increment_order_id.nextval, '00099'))
         into :new.ORDER_ID
         from dual;
end;
