CREATE TABLE CUSTOMER (
    customer_id   CHAR(4)       NOT NULL,
    name          VARCHAR(30)   NOT NULL,
    email         VARCHAR(40)   NOT NULL,
    password      VARCHAR(20)   NOT NULL,
    shipping_addr VARCHAR(60)   NULL,
    country       VARCHAR(30)   NOT NULL,
    register_date DATE          NOT NULL,
    recommendedby CHAR(4)       NULL,
    shop_opinion  INTEGER(1)    NOT NULL DEFAULT 3 
                                CHECK (shop_opinion BETWEEN 1 AND 5),
    ispremium     BOOLEAN       NOT NULL DEFAULT FALSE,
    premium_fee   DECIMAL(6,2)  NULL,
    premium_date  DATE          NULL,
    PRIMARY KEY(customer_id),
    UNIQUE(email),
    FOREIGN KEY(recommendedby) REFERENCES CUSTOMER(customer_id)
    -- CHECK (premium_fee IS NULL OR premium_fee >= 0),
    /* CHECK ((ispremium IS TRUE
                 AND premium_fee IS NOT NULL 
                 AND premium_date IS NOT NULL)
               OR (ispremium IS FALSE
                 AND premium_fee IS NULL 
                 AND premium_date IS NULL))
    */
);
/*Una fila para cada metodo de pago de cada cliente
Ver si es necesario guardar informacion adicional para
cada metodo de pago, y diferente en funcion del metodo*/
CREATE TABLE CUSTOMER_PAYMENT_METHOD (
    customer          CHAR(4)     NOT NULL,
    payment_method    VARCHAR(20)  NOT NULL 
                        CHECK (payment_method IN ('VISA', 
                               'MASTERCARD', '4B', 
                               'EURO6000','PAYPAL')),
    -- mas atributos?
    PRIMARY KEY (customer, payment_method),
    FOREIGN KEY (customer) REFERENCES CUSTOMER(customer_id)
);

CREATE TABLE PRODUCT_CATEGORY (
    category_id CHAR(10) NOT NULL,
    description VARCHAR(60) NULL,
    -- mas atributos?
    PRIMARY KEY(category_id)
);

CREATE TABLE PRODUCT (
    product_id      CHAR(10) NOT NULL,
    name            VARCHAR(30) NOT NULL,
    price           DECIMAL(6,2) NOT NULL CHECK (price > 0),
    description     VARCHAR(60) NULL,
    imageURL        VARCHAR(60) NULL,
    manufacturer    VARCHAR(30) NOT NULL,
    stock           INTEGER(5)  NOT NULL CHECK (stock >= 0), 
    category        VARCHAR(30) NOT NULL,
    PRIMARY KEY(product_id),
    -- UNIQUE(imageURL),
    FOREIGN KEY(category) REFERENCES PRODUCT_CATEGORY(category_id)
);

CREATE TABLE SIMILAR_PRODUCT (
    product1 CHAR(10) NOT NULL,
    product2 CHAR(10) NOT NULL,
    PRIMARY KEY (product1, product2),
    FOREIGN KEY (product1) REFERENCES PRODUCT(product_id),
    FOREIGN KEY (product2) REFERENCES PRODUCT(product_id)
);

CREATE TABLE CUSTOMER_ORDER (
    order_id     INTEGER(4)   NOT NULL,
    order_date   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    customer     CHAR(4)      NOT NULL, 
    total        DECIMAL(7,2) NOT NULL CHECK (total >= 0),
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer) REFERENCES CUSTOMER(customer_id)
);

CREATE TABLE ORDER_ITEM (   
    order_id    INTEGER(4)  NOT NULL,
    item        INTEGER(2)  NOT NULL,
    product     CHAR(10)    NOT NULL,
    quantity    INTEGER(3)  NOT NULL DEFAULT 1 CHECK (quantity > 0),
    subtotal    DECIMAL(6,2) NOT NULL CHECK (subtotal >= 0), 
    PRIMARY KEY (order_id, item),
    FOREIGN KEY (order_id) REFERENCES CUSTOMER_ORDER(order_id),
    FOREIGN KEY (product) REFERENCES PRODUCT(product_id)
);

/* Re pensar lo de los descuentos y sus tipos */
CREATE TABLE DISCOUNT (
    discount_id   INTEGER(2)   NOT NULL,
    description   VARCHAR(60)   NOT NULL,
    discount_rate DECIMAL(4,2)  NOT NULL CHECK (discount_rate > 0),
    PRIMARY KEY(discount_id)
);

CREATE TABLE ORDER_DISCOUNT (
    order_id INTEGER(4) NOT NULL,
    discount INTEGER(2) NOT NULL,
    PRIMARY KEY (order_id, discount),
    FOREIGN KEY (order_id) REFERENCES CUSTOMER_ORDER(order_id),
    FOREIGN KEY (discount) REFERENCES DISCOUNT(discount_id)
);