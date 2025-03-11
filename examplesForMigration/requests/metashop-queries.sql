
/*
https://gicd.inf.um.es/phpmyadmin/
bd_customer00 / BD-gicd-2022
*/

/* Q1. Listado (identificador, nombre, precio, stock) de productos de la 
categoría "Laptop" cuyo precio sea inferior a 1500€ y cuyo fabricante 
sea "LG" */

SELECT product_id, name, price, stock
FROM PRODUCT
WHERE category IN (SELECT category_id
                   FROM PRODUCT_CATEGORY
                   WHERE name = 'Laptop')
  AND price < 1500 and manufacturer = 'LG';

/* Q2. Compras realizadas por el cliente 'U2929' desde el 1/11/2021 al 
31/08/2022 */

SELECT * 
FROM CUSTOMER_ORDER
WHERE customer = 'U2929'
  AND order_date >= '2021-11-01' AND order_date <= '2022-08-31';

/* Q3. Productos comprados por un cliente 'U2929' entre el 1/11/2021 y el 
31/08/2022 */

SELECT product_id, name, price
FROM PRODUCT
WHERE product_id IN (SELECT product
                     FROM ORDER_ITEM
                     WHERE order_id IN (SELECT order_id
                                        FROM CUSTOMER_ORDER
                                        WHERE customer = 'U2929'
                                        AND order_date >= '2021-11-01' 
                                        AND order_date <= '2022-08-31'));

/*Q4. Lista (id y nombre) de los 10 productos mas vendidos en cada pais.*/

SELECT P.product_id, P.name, S.country, S.total_sales
FROM PRODUCT P JOIN (SELECT I.product prod, U.country, SUM(I.quantity) total_sales
                     FROM CUSTOMER_ORDER O JOIN CUSTOMER U ON O.customer = U.customer_id
                                   JOIN ORDER_ITEM I ON O.order_id = I.order_id
                     GROUP BY I.product, U.country) S
               ON P.product_id = S.prod
ORDER BY S.country, S.total_sales DESC
LIMIT 10;

/*Q5. Clientes cuyas recomendaciones directas o indirectas han realizado 
una valoracion baja de la tienda (valores 1 y 2).*/

-- No es posible la recursividad. Un nivel:
SELECT recommendedby -- el que recomendó a otro que ha puntuado bajo
FROM CUSTOMER
WHERE shop_opinion < 3;

-- Dos niveles
SELECT U1.recommendedby -- recomendo a otro que recomendo al que ha puntuado bajo
FROM CUSTOMER U1, CUSTOMER U2
WHERE U1.customer_id = U2.recommendedby AND U2.shop_opinion < 3;

-- Tres niveles
SELECT U1.recommendedby
FROM CUSTOMER U1, CUSTOMER U2, CUSTOMER U3
WHERE U1.customer_id = U2.recommendedby 
  AND U2.customer_id = U3.recommendedby AND U3.shop_opinion < 3;

/*Q6. Lista de recomendaciones directas o indirectas de un cliente.*/
-- Directas
SELECT customer_id, name, country
FROM CUSTOMER
WHERE recomendedby = 'U2929';

-- Indirectas de 1 nivel
SELECT U3.customer_id, U3.name, U3.country
FROM CUSTOMER U3 
     JOIN CUSTOMER U2 ON U2.customer_id = U3.recommendedby
WHERE U2.recommendedby = 'U2929';

SELECT customer_id, name, country
FROM CUSTOMER
WHERE recommendedby IN (SELECT customer_id
                        FROM CUSTOMER
                        WHERE recommendedby = 'U2929');

/*
Q7. Productos similares a los comprados por el ultimo pedido de un cliente
*** importante: para cada fila (p1,p2) debe haber otra fila (p2,p1)
    la similitud es bidireccional
*/

SELECT product2
FROM SIMILAR_PRODUCT
WHERE product1 IN (SELECT product
                   FROM ORDER_ITEM
                   WHERE order_id IN (SELECT order_id
                                      FROM CUSTOMER_ORDER O1
                                      WHERE customer = 'U2929' 
                                      AND order_date = (SELECT MAX(order_date) 
                                                        FROM CUSTOMER_ORDER 
                                                        WHERE O2.customer = O1.customer))
                   );
-- pendientes:
-- Clientes tales que todos sus recomendados han votado bajo.
-- Productos habitualmente comprados junto con otro producto.
