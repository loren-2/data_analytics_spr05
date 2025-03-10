-- Preparacion para Sprint 5
-- Hago las modificaciones sugeridas en los sprints 3 y 4
-- tabla credit_cards: campo iban debe ser unique
show index from credit_cards;

-- agrego constraint unique al campo iban
alter table credit_cards
add unique (iban);

show index from credit_cards;

-- Modifico campos cvv y pin:  tipo de dato y tamaño
show columns from credit_cards;

alter table credit_cards
modify pin varchar(4),
modify cvv varchar(3);

show columns from credit_cards;

-- Modifico tabla companies: reduzco tamaño de company_name y website
show columns from companies;

-- Realizo modificaciones a tabla companies
alter table companies
modify company_name varchar(100),
modify website varchar(100);

show columns from companies;

-- En tabla credit_cards: modifico tamaño de campo id
alter table credit_cards
modify id varchar(20);

show columns from credit_cards;

-- Ahora tengo que modificar campo card_id en la tabla transactions donde la id de la tabla credit_cards es foreign key
alter table transactions
modify card_id varchar(20);

show columns from transactions;

-- Creo la tabla products
create table if not exists products (
    id int primary key,
    product_name varchar(150),
    price varchar(15),
    colour varchar(15),
    weight  decimal(10,2),
    warehouse_id varchar(10)
);

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

-- Importo datos desde archivo products.csv
load data local infile 'C:\\it_academy\\da_sprint04\\products.csv'
into table products
fields terminated by ',' 
lines terminated by '\n' 
ignore 1 rows; 

select * from products;

-- Creo la tabla intermedia products_transactions para relacionar cada transacción con cada uno de los productos adquiridos en la misma.
-- Esto me permitirá eliminar la columna product_ids (con varios valores) de la tabla transactions que es difícil de manipular
create table if not exists products_transaction (
    transaction_id varchar(40),
    product_ids VARCHAR(150)
);

-- Copio las columnas id y product_ids de la tabla transactions en la tabla products_transaction
insert into products_transaction (transaction_id, product_ids)
select id, product_ids FROM transactions;

select * from products_transaction;

-- Elimino la columna product_ids (con multiples valores) de la tabla transactions
alter table transactions
drop column product_ids; 

show columns from transactions;

select * from credit_cards
limit 10;





