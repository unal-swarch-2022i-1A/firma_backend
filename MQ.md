# Comunicacion unidireccional
Emisor ---Message---> Receptor

# HTTP Comunicacion bidirecional
Cliente --HTTP(TCP:80) MSG Request Header, Body----> Servidor
Cliente <-HTTP(TCP:80) MSG Response Hedaer, Body---- Servidor

# Message Queue unidireccional
https://www.rabbitmq.com/tutorials/tutorial-one-javascript.html

Publicador --AMQP(TCP:5672)--> hola[][][][]
                               hola[][][][] --AMQP(TCP:5672)--> Consumirdor

# MQ bidireccional Remote Procedure Call RPC
https://www.rabbitmq.com/tutorials/tutorial-six-javascript.html

Cliente --AMQP(TCP:5672)--> rpc[][][][] 
                            rpc[][][][] --AMQP(TCP:5672)--> Servidor(Procedure)
                            
                            res[][][][]<--AMQP(TCP:5672)--- Servidor(Procedure)
Cliente <-AMQP(TCP:5672)--- res[][][][]
