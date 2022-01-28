CREATE TABLE CLIENTE(
	 ID_CLIENTE INTEGER PRIMARY KEY,
	 CI INTEGER,
	 NOMBRE VARCHAR,
	 APELLIDO VARCHAR,
	 FECHA DATE

);

CREATE TABLE PELICULA(
	 ID_PELICULA INTEGER PRIMARY KEY,
	 NOMBRE VARCHAR,
	 FECHA_ESTRENO INT

);

CREATE TABLE ALQUILER(
	 ID_ALQUILER INTEGER PRIMARY KEY,
	 ID_CLIENTE INTEGER,
	 ID_PELICULA INTEGER,
	 FECHA_PRESTAMO DATE,
	 FECHA_ENTREGA DATE,
	 VALOR INTEGER

);


alter table ALQUILER add constraint ALQUILA foreign key (ID_CLIENTE) references CLIENTE (ID_CLIENTE)
      on delete restrict on update restrict;
	  
alter table ALQUILER add constraint PUEDE_SER foreign key (ID_PELICULA) references PELICULA (ID_PELICULA)
      on delete restrict on update restrict;


-- crear funcion
create or replace function UNO ()  
returns trigger as $$
DECLARE
DIAS INT;
begin
SELECT ( DATE(NEW.FECHA_ENTREGA) - DATE (NEW.FECHA_PRESTAMO) ) INTO DIAS FROM ALQUILER 
WHERE ID_ALQUILER = NEW.ID_ALQUILER;
UPDATE ALQUILER SET VALOR = DIAS WHERE ID_ALQUILER = NEW.ID_ALQUILER;
return new;
end
$$
language plpgsql;
--Un trigger 
create or replace trigger CUATRO AFTER INSERT on ALQUILER
for each row 
execute procedure UNO ();







