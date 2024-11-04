-- Seed data into question table
USE question_db;
GO

INSERT INTO question_db.question (pregunta, respuesta)
VALUES ('¿Cómo puedo crear una cuenta en AllConnected?', 
        'Para crear una cuenta en AllConnected, dirígete a la página de inicio, selecciona "Registrarse", llena tus datos y sigue los pasos. Luego, verifica tu correo para activar la cuenta.');

INSERT INTO question_db.question (pregunta, respuesta)
VALUES ('¿Cómo puedo vender un producto en AllConnected?', 
        'Para vender un producto, inicia sesión en tu cuenta, ve a la sección "Vender", completa los detalles del producto y las opciones de envío, y finalmente publica el anuncio. Te notificaremos cuando recibas una oferta.');

INSERT INTO question_db.question (pregunta, respuesta)
VALUES ('¿Qué métodos de pago acepta AllConnected?', 
        'AllConnected acepta varios métodos de pago, incluidos tarjetas de crédito, débito, PayPal y transferencias bancarias. Elige el método que prefieras durante el proceso de pago.');
GO
